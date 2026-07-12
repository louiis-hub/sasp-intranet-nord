CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS wiki_sections (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  slug TEXT NOT NULL UNIQUE,
  titre TEXT NOT NULL,
  sous_titre TEXT,
  icon TEXT DEFAULT '📄',
  ordre INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS wiki_sections_ordre_idx
ON wiki_sections(ordre);

ALTER TABLE wiki_sections ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "auth_all" ON wiki_sections;
CREATE POLICY "auth_all"
ON wiki_sections
FOR ALL
TO authenticated
USING (true)
WITH CHECK (true);

CREATE TABLE IF NOT EXISTS ceremonie_votes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  agent_id UUID NOT NULL REFERENCES agents(id) ON DELETE CASCADE,
  voter_discord_id TEXT NOT NULL,
  voter_name TEXT,
  decision TEXT NOT NULL,
  commentaire TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE (agent_id, voter_discord_id)
);

CREATE INDEX IF NOT EXISTS ceremonie_votes_agent_id_idx
ON ceremonie_votes(agent_id);

ALTER TABLE ceremonie_votes ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "auth_all" ON ceremonie_votes;
CREATE POLICY "auth_all"
ON ceremonie_votes
FOR ALL
TO authenticated
USING (true)
WITH CHECK (true);

CREATE TABLE IF NOT EXISTS ftf_dossiers (
  id TEXT PRIMARY KEY,
  data JSONB NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ftf_dossiers_updated_at_idx
ON ftf_dossiers(updated_at DESC);

ALTER TABLE ftf_dossiers ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "auth_all" ON ftf_dossiers;
CREATE POLICY "auth_all"
ON ftf_dossiers
FOR ALL
TO authenticated
USING (true)
WITH CHECK (true);
