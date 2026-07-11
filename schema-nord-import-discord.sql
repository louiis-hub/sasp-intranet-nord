-- A executer dans Supabase Nord > SQL Editor
-- Ajoute les colonnes utilisees par l'import Discord et les fiches agents.

ALTER TABLE agents ADD COLUMN IF NOT EXISTS discord_id TEXT;
ALTER TABLE agents ADD COLUMN IF NOT EXISTS iban TEXT;
ALTER TABLE agents ADD COLUMN IF NOT EXISTS is_formateur BOOLEAN DEFAULT FALSE;
ALTER TABLE agents ADD COLUMN IF NOT EXISTS formateur_id UUID REFERENCES agents(id) ON DELETE SET NULL;
