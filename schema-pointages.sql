CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS pointages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  agent_id UUID NOT NULL REFERENCES agents(id) ON DELETE CASCADE,
  clock_in TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  clock_out TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS pointages_agent_id_idx
ON pointages(agent_id);

CREATE INDEX IF NOT EXISTS pointages_clock_in_idx
ON pointages(clock_in);

CREATE INDEX IF NOT EXISTS pointages_active_idx
ON pointages(agent_id)
WHERE clock_out IS NULL;

ALTER TABLE pointages ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "auth_all" ON pointages;
CREATE POLICY "auth_all"
ON pointages
FOR ALL
TO authenticated
USING (true)
WITH CHECK (true);
