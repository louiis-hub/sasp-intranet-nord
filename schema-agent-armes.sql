CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS agent_armes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  agent_id UUID NOT NULL REFERENCES agents(id) ON DELETE CASCADE,
  nom TEXT NOT NULL,
  serie TEXT,
  ppa_niveau INTEGER NOT NULL DEFAULT 1,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS agent_armes_agent_id_idx
ON agent_armes(agent_id);

ALTER TABLE agent_armes ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "auth_all" ON agent_armes;
CREATE POLICY "auth_all"
ON agent_armes
FOR ALL
TO authenticated
USING (true)
WITH CHECK (true);
