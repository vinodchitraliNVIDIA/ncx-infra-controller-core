-- Add a first-class location column (VARCHAR 256) to switches and power_shelves,
-- migrating the value out of the config JSONB.
ALTER TABLE
    switches
ADD COLUMN IF NOT EXISTS location VARCHAR(256);

UPDATE
    switches
SET
    location = config ->> 'location'
WHERE
    config ->> 'location' IS NOT NULL;

ALTER TABLE
    power_shelves
ADD COLUMN IF NOT EXISTS location VARCHAR(256);

UPDATE
    power_shelves
SET
    location = config ->> 'location'
WHERE
    config ->> 'location' IS NOT NULL;

ALTER TABLE
    machines
ADD COLUMN IF NOT EXISTS location VARCHAR(256);