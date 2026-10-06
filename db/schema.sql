-- ============================================================================
-- Naija Life (working title) - Initial PostgreSQL schema DRAFT
-- Version 0.1 | PostgreSQL 16+
-- This is a design draft. Real migrations are created in Phase 1+ (Drizzle/SQL).
-- Money: bigint whole naira. Timestamps: timestamptz (UTC).
-- ============================================================================

CREATE EXTENSION IF NOT EXISTS citext;

-- ---------------------------------------------------------------------------
-- AUTH
-- ---------------------------------------------------------------------------
CREATE TABLE users (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email           citext NOT NULL UNIQUE,
  email_verified_at timestamptz,
  username        citext NOT NULL UNIQUE CHECK (username ~ '^[A-Za-z0-9_]{3,20}$'),
  password_hash   text NOT NULL,
  status          text NOT NULL DEFAULT 'active' CHECK (status IN ('active','suspended','banned','deleted')),
  totp_secret_enc text,
  last_login_at   timestamptz,
  created_at      timestamptz NOT NULL DEFAULT now(),
  updated_at      timestamptz NOT NULL DEFAULT now(),
  deleted_at      timestamptz
);

CREATE TABLE sessions (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  token_hash   text NOT NULL UNIQUE,
  user_agent   text,
  ip_hash      text,
  created_at   timestamptz NOT NULL DEFAULT now(),
  last_seen_at timestamptz NOT NULL DEFAULT now(),
  expires_at   timestamptz NOT NULL,
  revoked_at   timestamptz
);
CREATE INDEX sessions_user_idx ON sessions(user_id);

CREATE TABLE email_tokens (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  purpose    text NOT NULL CHECK (purpose IN ('verify_email','reset_password','change_email')),
  token_hash text NOT NULL UNIQUE,
  expires_at timestamptz NOT NULL,
  used_at    timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- ---------------------------------------------------------------------------
-- WORLD
-- ---------------------------------------------------------------------------
CREATE TABLE cities (
  id        uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug      text NOT NULL UNIQUE,
  name      text NOT NULL,
  is_active boolean NOT NULL DEFAULT true,
  config    jsonb NOT NULL DEFAULT '{}'
);

CREATE TABLE districts (
  id      uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  city_id uuid NOT NULL REFERENCES cities(id),
  slug    text NOT NULL,
  name    text NOT NULL,
  theme   text,
  UNIQUE (city_id, slug)
);

CREATE TABLE locations (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  city_id     uuid NOT NULL REFERENCES cities(id),
  district_id uuid NOT NULL REFERENCES districts(id),
  slug        text NOT NULL,
  name        text NOT NULL,
  type        text NOT NULL,
  icon        text,
  map_x       numeric(6,2) NOT NULL,
  map_y       numeric(6,2) NOT NULL,
  capacity    integer,
  open_hours  jsonb,
  actions     jsonb NOT NULL DEFAULT '[]',
  is_active   boolean NOT NULL DEFAULT true,
  UNIQUE (city_id, slug)
);
CREATE INDEX locations_district_idx ON locations(district_id);

-- ---------------------------------------------------------------------------
-- PLAYER
-- ---------------------------------------------------------------------------
CREATE TABLE characters (
  id             uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id        uuid NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  display_name   text NOT NULL,
  avatar         jsonb NOT NULL DEFAULT '{}',
  city_id        uuid REFERENCES cities(id),
  level          integer NOT NULL DEFAULT 1,
  xp             bigint NOT NULL DEFAULT 0,
  title          text,
  privacy        jsonb NOT NULL DEFAULT '{"show_online":true,"show_in_leaderboards":true,"dm_from":"everyone","visits":"friends"}',
  created_at     timestamptz NOT NULL DEFAULT now(),
  updated_at     timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE player_locations (
  character_id uuid PRIMARY KEY REFERENCES characters(id) ON DELETE CASCADE,
  location_id  uuid NOT NULL REFERENCES locations(id),
  entered_at   timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX player_locations_loc_idx ON player_locations(location_id);

CREATE TABLE needs_state (
  character_id uuid PRIMARY KEY REFERENCES characters(id) ON DELETE CASCADE,
  hunger  smallint NOT NULL DEFAULT 100 CHECK (hunger  BETWEEN 0 AND 100),
  energy  smallint NOT NULL DEFAULT 100 CHECK (energy  BETWEEN 0 AND 100),
  fun     smallint NOT NULL DEFAULT 100 CHECK (fun     BETWEEN 0 AND 100),
  social  smallint NOT NULL DEFAULT 100 CHECK (social  BETWEEN 0 AND 100),
  hygiene smallint NOT NULL DEFAULT 100 CHECK (hygiene BETWEEN 0 AND 100),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE skills (
  id    text PRIMARY KEY,
  name  text NOT NULL,
  icon  text,
  max_level smallint NOT NULL DEFAULT 10,
  config jsonb NOT NULL DEFAULT '{}'
);

CREATE TABLE player_skills (
  character_id uuid NOT NULL REFERENCES characters(id) ON DELETE CASCADE,
  skill_id     text NOT NULL REFERENCES skills(id),
  xp           bigint NOT NULL DEFAULT 0,
  level        smallint NOT NULL DEFAULT 1,
  PRIMARY KEY (character_id, skill_id)
);

-- ---------------------------------------------------------------------------
-- LEDGER (see docs/07_BANKING_AND_LEDGER.md)
-- ---------------------------------------------------------------------------
CREATE TABLE ledger_accounts (
  id         bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  owner_type text NOT NULL CHECK (owner_type IN ('player','organization','system')),
  owner_id   uuid,
  kind       text NOT NULL CHECK (kind IN ('wallet','bank','savings','bond','escrow','tax','burn','mint','reserve','treasury','business')),
  code       text UNIQUE,                       -- for system accounts e.g. SYSTEM_MINT
  balance    bigint NOT NULL DEFAULT 0,
  currency   text NOT NULL DEFAULT 'NGN_GAME',
  frozen     boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  -- player-owned and escrow accounts may never go negative; mint/system may
  CONSTRAINT non_negative_player_balance CHECK (
    owner_type = 'system' OR kind = 'mint' OR balance >= 0
  )
);
CREATE UNIQUE INDEX ledger_accounts_owner_kind_idx
  ON ledger_accounts(owner_type, owner_id, kind) WHERE owner_id IS NOT NULL;

CREATE TABLE ledger_transactions (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  type            text NOT NULL,
  reference       text NOT NULL UNIQUE,                    -- human-readable receipt code
  actor_id        uuid,                                     -- user or system actor
  idempotency_key text,
  status          text NOT NULL DEFAULT 'posted' CHECK (status IN ('pending','posted','reversed','failed')),
  metadata        jsonb NOT NULL DEFAULT '{}',
  created_at      timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX ledger_tx_idem_idx
  ON ledger_transactions(actor_id, idempotency_key) WHERE idempotency_key IS NOT NULL;
CREATE INDEX ledger_tx_type_created_idx ON ledger_transactions(type, created_at DESC);

CREATE TABLE ledger_entries (
  id             bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  transaction_id uuid NOT NULL REFERENCES ledger_transactions(id),
  account_id     bigint NOT NULL REFERENCES ledger_accounts(id),
  amount         bigint NOT NULL CHECK (amount <> 0),     -- +credit / -debit
  balance_after  bigint NOT NULL,
  created_at     timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX ledger_entries_account_idx ON ledger_entries(account_id, created_at DESC);
CREATE INDEX ledger_entries_tx_idx ON ledger_entries(transaction_id);

-- Entries of a transaction must sum to zero (checked at commit)
CREATE OR REPLACE FUNCTION ledger_check_zero_sum() RETURNS trigger AS $$
DECLARE s bigint;
BEGIN
  SELECT COALESCE(SUM(amount),0) INTO s FROM ledger_entries WHERE transaction_id = NEW.transaction_id;
  IF s <> 0 THEN
    RAISE EXCEPTION 'Ledger transaction % does not sum to zero (sum=%)', NEW.transaction_id, s;
  END IF;
  RETURN NULL;
END; $$ LANGUAGE plpgsql;

CREATE CONSTRAINT TRIGGER ledger_entries_zero_sum
  AFTER INSERT ON ledger_entries
  DEFERRABLE INITIALLY DEFERRED
  FOR EACH ROW EXECUTE FUNCTION ledger_check_zero_sum();

-- Ledger rows are append-only
CREATE OR REPLACE FUNCTION ledger_no_mutation() RETURNS trigger AS $$
BEGIN RAISE EXCEPTION 'Ledger entries and transactions are immutable'; END; $$ LANGUAGE plpgsql;
CREATE TRIGGER ledger_entries_immutable BEFORE UPDATE OR DELETE ON ledger_entries
  FOR EACH ROW EXECUTE FUNCTION ledger_no_mutation();

-- ---------------------------------------------------------------------------
-- JOBS AND CAREERS
-- ---------------------------------------------------------------------------
CREATE TABLE jobs (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug       text NOT NULL UNIQUE,
  name       text NOT NULL,
  field      text NOT NULL,
  location_type text,
  employer_type text NOT NULL DEFAULT 'npc' CHECK (employer_type IN ('npc','organization')),
  organization_id uuid,
  is_active  boolean NOT NULL DEFAULT true
);

CREATE TABLE career_levels (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id        uuid NOT NULL REFERENCES jobs(id) ON DELETE CASCADE,
  level         smallint NOT NULL,
  title         text NOT NULL,
  pay_per_shift bigint NOT NULL CHECK (pay_per_shift >= 0),
  shift_minutes integer NOT NULL CHECK (shift_minutes > 0),
  requirements  jsonb NOT NULL DEFAULT '{}',      -- skills, level, education
  UNIQUE (job_id, level)
);

CREATE TABLE player_jobs (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  character_id  uuid NOT NULL REFERENCES characters(id) ON DELETE CASCADE,
  job_id        uuid NOT NULL REFERENCES jobs(id),
  level         smallint NOT NULL DEFAULT 1,
  performance   smallint NOT NULL DEFAULT 0 CHECK (performance BETWEEN 0 AND 100),
  hired_at      timestamptz NOT NULL DEFAULT now(),
  ended_at      timestamptz
);
CREATE UNIQUE INDEX player_jobs_one_active_idx ON player_jobs(character_id) WHERE ended_at IS NULL;

CREATE TABLE shifts (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  character_id  uuid NOT NULL REFERENCES characters(id) ON DELETE CASCADE,
  player_job_id uuid NOT NULL REFERENCES player_jobs(id),
  started_at    timestamptz NOT NULL DEFAULT now(),
  ends_at       timestamptz NOT NULL,
  status        text NOT NULL DEFAULT 'active' CHECK (status IN ('active','claimed','cancelled')),
  reward        bigint NOT NULL,
  ledger_transaction_id uuid REFERENCES ledger_transactions(id)
);
CREATE UNIQUE INDEX shifts_one_active_idx ON shifts(character_id) WHERE status = 'active';
CREATE INDEX shifts_ends_idx ON shifts(ends_at) WHERE status = 'active';

-- ---------------------------------------------------------------------------
-- HUSTLE (player-to-player gigs with escrow)
-- ---------------------------------------------------------------------------
CREATE TABLE hustle_gigs (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  poster_id     uuid NOT NULL REFERENCES characters(id),
  worker_id     uuid REFERENCES characters(id),
  category      text NOT NULL,
  title         text NOT NULL CHECK (char_length(title) <= 80),
  description   text NOT NULL CHECK (char_length(description) <= 500),
  fee           bigint NOT NULL CHECK (fee > 0),
  status        text NOT NULL DEFAULT 'open'
                CHECK (status IN ('open','accepted','delivered','confirmed','paid','cancelled','disputed','resolved')),
  escrow_tx_id  uuid REFERENCES ledger_transactions(id),
  deadline_at   timestamptz,
  created_at    timestamptz NOT NULL DEFAULT now(),
  updated_at    timestamptz NOT NULL DEFAULT now(),
  CHECK (worker_id IS NULL OR worker_id <> poster_id)
);
CREATE INDEX hustle_open_idx ON hustle_gigs(category, created_at DESC) WHERE status = 'open';

CREATE TABLE hustle_applications (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  gig_id     uuid NOT NULL REFERENCES hustle_gigs(id) ON DELETE CASCADE,
  applicant_id uuid NOT NULL REFERENCES characters(id),
  message    text,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (gig_id, applicant_id)
);

CREATE TABLE hustle_ratings (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  gig_id     uuid NOT NULL REFERENCES hustle_gigs(id) ON DELETE CASCADE,
  rater_id   uuid NOT NULL REFERENCES characters(id),
  ratee_id   uuid NOT NULL REFERENCES characters(id),
  stars      smallint NOT NULL CHECK (stars BETWEEN 1 AND 5),
  comment    text,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (gig_id, rater_id)
);

-- ---------------------------------------------------------------------------
-- ITEMS, INVENTORY, SHOPS, PROPERTY
-- ---------------------------------------------------------------------------
CREATE TABLE items (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug        text NOT NULL UNIQUE,
  name        text NOT NULL,
  category    text NOT NULL,
  description text,
  base_price  bigint NOT NULL CHECK (base_price >= 0),
  stackable   boolean NOT NULL DEFAULT true,
  tradable    boolean NOT NULL DEFAULT true,
  rarity      text,
  effects     jsonb NOT NULL DEFAULT '{}',     -- e.g. {"hunger":+30}
  is_active   boolean NOT NULL DEFAULT true
);

CREATE TABLE inventory (
  character_id uuid NOT NULL REFERENCES characters(id) ON DELETE CASCADE,
  item_id      uuid NOT NULL REFERENCES items(id),
  quantity     integer NOT NULL CHECK (quantity > 0),
  acquired_at  timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (character_id, item_id)
);

CREATE TABLE shops (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  location_id uuid NOT NULL REFERENCES locations(id),
  name        text NOT NULL,
  owner_type  text NOT NULL DEFAULT 'npc' CHECK (owner_type IN ('npc','organization')),
  organization_id uuid
);

CREATE TABLE shop_stock (
  shop_id  uuid NOT NULL REFERENCES shops(id) ON DELETE CASCADE,
  item_id  uuid NOT NULL REFERENCES items(id),
  price    bigint NOT NULL CHECK (price >= 0),
  quantity integer,                               -- NULL = unlimited (NPC shops)
  PRIMARY KEY (shop_id, item_id)
);

CREATE TABLE properties (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  type        text NOT NULL,                      -- room, flat, house, mansion, land, commercial
  name        text NOT NULL,
  city_id     uuid NOT NULL REFERENCES cities(id),
  district_id uuid REFERENCES districts(id),
  price       bigint,
  weekly_rent bigint,
  capacity    integer NOT NULL DEFAULT 0,
  comfort     smallint NOT NULL DEFAULT 0,
  config      jsonb NOT NULL DEFAULT '{}'
);

CREATE TABLE leases (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  property_id  uuid NOT NULL REFERENCES properties(id),
  tenant_id    uuid NOT NULL REFERENCES characters(id),
  landlord_type text NOT NULL DEFAULT 'npc',
  landlord_id  uuid,
  weekly_rent  bigint NOT NULL,
  paid_until   timestamptz NOT NULL,
  status       text NOT NULL DEFAULT 'active' CHECK (status IN ('active','late','evicted','ended')),
  created_at   timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX leases_one_active_idx ON leases(tenant_id) WHERE status IN ('active','late');

CREATE TABLE property_ownership (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  property_id uuid NOT NULL REFERENCES properties(id),
  owner_id    uuid NOT NULL REFERENCES characters(id),
  acquired_at timestamptz NOT NULL DEFAULT now(),
  price_paid  bigint NOT NULL,
  upgrades    jsonb NOT NULL DEFAULT '[]'
);

-- ---------------------------------------------------------------------------
-- SOCIAL
-- ---------------------------------------------------------------------------
CREATE TABLE friendships (
  user_a    uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  user_b    uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  status    text NOT NULL CHECK (status IN ('pending','accepted')),
  requested_by uuid NOT NULL REFERENCES users(id),
  created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (user_a, user_b),
  CHECK (user_a < user_b)                         -- store each pair once
);

CREATE TABLE blocks (
  blocker_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  blocked_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (blocker_id, blocked_id),
  CHECK (blocker_id <> blocked_id)
);

CREATE TABLE conversations (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  kind       text NOT NULL DEFAULT 'direct' CHECK (kind IN ('direct','group')),
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE conversation_members (
  conversation_id uuid NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
  user_id         uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  last_read_at    timestamptz,
  muted           boolean NOT NULL DEFAULT false,
  PRIMARY KEY (conversation_id, user_id)
);

CREATE TABLE messages (
  id              bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  conversation_id uuid NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
  sender_id       uuid REFERENCES users(id),     -- NULL = system message
  body            text NOT NULL CHECK (char_length(body) <= 500),
  kind            text NOT NULL DEFAULT 'text',
  created_at      timestamptz NOT NULL DEFAULT now(),
  deleted_at      timestamptz
);
CREATE INDEX messages_conv_idx ON messages(conversation_id, created_at DESC);

CREATE TABLE reports (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  reporter_id  uuid NOT NULL REFERENCES users(id),
  target_type  text NOT NULL CHECK (target_type IN ('user','message','gig','group','organization')),
  target_id    text NOT NULL,
  reason       text NOT NULL,
  context      jsonb NOT NULL DEFAULT '{}',
  status       text NOT NULL DEFAULT 'open' CHECK (status IN ('open','reviewing','actioned','dismissed')),
  assigned_to  uuid REFERENCES users(id),
  created_at   timestamptz NOT NULL DEFAULT now(),
  resolved_at  timestamptz
);
CREATE INDEX reports_status_idx ON reports(status, created_at);

CREATE TABLE notifications (
  id         bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id    uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type       text NOT NULL,
  payload    jsonb NOT NULL DEFAULT '{}',
  read_at    timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX notifications_user_idx ON notifications(user_id, read_at, created_at DESC);

-- ---------------------------------------------------------------------------
-- ORGANIZATIONS (companies now; government, police, courts, parties later)
-- ---------------------------------------------------------------------------
CREATE TABLE organizations (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  type        text NOT NULL CHECK (type IN ('company','ministry','agency','police','army','court','legislature','party','media','ngo')),
  name        citext NOT NULL UNIQUE,
  owner_id    uuid REFERENCES characters(id),
  charter     jsonb NOT NULL DEFAULT '{}',
  reputation  integer NOT NULL DEFAULT 0,
  status      text NOT NULL DEFAULT 'active',
  created_at  timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE org_roles (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id uuid NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
  name            text NOT NULL,
  permissions     text[] NOT NULL DEFAULT '{}',
  UNIQUE (organization_id, name)
);

CREATE TABLE org_members (
  organization_id uuid NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
  character_id    uuid NOT NULL REFERENCES characters(id) ON DELETE CASCADE,
  role_id         uuid NOT NULL REFERENCES org_roles(id),
  joined_at       timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (organization_id, character_id)
);

ALTER TABLE jobs ADD CONSTRAINT jobs_org_fk FOREIGN KEY (organization_id) REFERENCES organizations(id);
ALTER TABLE shops ADD CONSTRAINT shops_org_fk FOREIGN KEY (organization_id) REFERENCES organizations(id);

-- ---------------------------------------------------------------------------
-- ADMIN, CONFIG, AUDIT, EVENTS
-- ---------------------------------------------------------------------------
CREATE TABLE roles (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text NOT NULL UNIQUE,
  description text
);

CREATE TABLE permissions (
  id          text PRIMARY KEY,                  -- e.g. players.suspend
  description text
);

CREATE TABLE role_permissions (
  role_id       uuid NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
  permission_id text NOT NULL REFERENCES permissions(id) ON DELETE CASCADE,
  PRIMARY KEY (role_id, permission_id)
);

CREATE TABLE user_roles (
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role_id uuid NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
  granted_by uuid REFERENCES users(id),
  granted_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, role_id)
);

CREATE TABLE config_parameters (
  key         text PRIMARY KEY,                  -- e.g. economy.tax.free_threshold
  value       jsonb NOT NULL,
  min_value   numeric,
  max_value   numeric,
  description text,
  updated_by  uuid REFERENCES users(id),
  updated_at  timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE audit_logs (
  id         bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  actor_id   uuid REFERENCES users(id),
  action     text NOT NULL,
  target_type text,
  target_id  text,
  before     jsonb,
  after      jsonb,
  reason     text,
  ip_hash    text,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX audit_logs_actor_idx ON audit_logs(actor_id, created_at DESC);
CREATE INDEX audit_logs_target_idx ON audit_logs(target_type, target_id);
CREATE TRIGGER audit_logs_immutable BEFORE UPDATE OR DELETE ON audit_logs
  FOR EACH ROW EXECUTE FUNCTION ledger_no_mutation();

CREATE TABLE fraud_flags (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    uuid REFERENCES users(id),
  signal     text NOT NULL,
  severity   smallint NOT NULL DEFAULT 1,
  details    jsonb NOT NULL DEFAULT '{}',
  status     text NOT NULL DEFAULT 'open' CHECK (status IN ('open','reviewing','confirmed','cleared')),
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE announcements (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title      text NOT NULL,
  body       text NOT NULL,
  starts_at  timestamptz NOT NULL DEFAULT now(),
  ends_at    timestamptz,
  created_by uuid REFERENCES users(id)
);

CREATE TABLE events (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text NOT NULL,
  description text,
  location_id uuid REFERENCES locations(id),
  starts_at   timestamptz NOT NULL,
  ends_at     timestamptz NOT NULL,
  eligibility jsonb NOT NULL DEFAULT '{}',
  rewards     jsonb NOT NULL DEFAULT '{}',
  created_by  uuid REFERENCES users(id),
  CHECK (ends_at > starts_at)
);

CREATE TABLE event_participants (
  event_id     uuid NOT NULL REFERENCES events(id) ON DELETE CASCADE,
  character_id uuid NOT NULL REFERENCES characters(id) ON DELETE CASCADE,
  joined_at    timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (event_id, character_id)
);

CREATE TABLE achievements (
  id          text PRIMARY KEY,
  name        text NOT NULL,
  description text,
  reward      jsonb NOT NULL DEFAULT '{}'
);

CREATE TABLE player_achievements (
  character_id   uuid NOT NULL REFERENCES characters(id) ON DELETE CASCADE,
  achievement_id text NOT NULL REFERENCES achievements(id),
  earned_at      timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (character_id, achievement_id)
);

-- Outbox for reliable domain events (publish after commit)
CREATE TABLE outbox (
  id          bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  topic       text NOT NULL,
  payload     jsonb NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now(),
  published_at timestamptz
);
CREATE INDEX outbox_unpublished_idx ON outbox(id) WHERE published_at IS NULL;

-- ---------------------------------------------------------------------------
-- SEED: required system ledger accounts (run in seed script, shown for reference)
-- ---------------------------------------------------------------------------
-- INSERT INTO ledger_accounts(owner_type, kind, code) VALUES
--  ('system','mint','SYSTEM_MINT'),
--  ('system','burn','SYSTEM_BURN'),
--  ('system','tax','SYSTEM_TAX'),
--  ('system','escrow','SYSTEM_ESCROW'),
--  ('system','reserve','SYSTEM_BANK_RESERVE'),
--  ('system','treasury','SYSTEM_TREASURY');
