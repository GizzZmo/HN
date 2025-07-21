-- harmonia_nexus/src/database/schema.sql

-- Table for storing all anonymized Echoes
-- Each Echo is a unique narrative fragment.
CREATE TABLE Echoes (
    echo_id VARCHAR(255) PRIMARY KEY,
    -- Content is stored, but never directly linked to a user in public views.
    -- Anonymization ensures no personal identifiers are stored here.
    content TEXT NOT NULL,
    -- A timestamp helps with chronological analysis or trending.
    submission_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for storing the Emotional Signatures derived from Echoes.
-- This links Echoes to their core emotional essence.
CREATE TABLE EmotionalSignatures (
    signature_id VARCHAR(255) PRIMARY KEY,
    echo_id VARCHAR(255) NOT NULL,
    core_feeling VARCHAR(100) NOT NULL, -- e.g., 'Joy', 'Sorrow', 'Hope', 'Fear'
    intensity DECIMAL(3,2) NOT NULL,    -- e.g., 0.00 to 1.00
    FOREIGN KEY (echo_id) REFERENCES Echoes(echo_id) ON DELETE CASCADE
);

-- Table for storing the Context Tags associated with each Echo.
-- An Echo can have multiple tags (e.g., 'loss', 'urban', 'economic').
CREATE TABLE ContextTags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    echo_id VARCHAR(255) NOT NULL,
    tag_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (echo_id) REFERENCES Echoes(echo_id) ON DELETE CASCADE,
    UNIQUE (echo_id, tag_name) -- An Echo cannot have the same tag twice
);

-- Table for storing the established Resonance Paths.
-- These are the validated connections between two Echoes.
CREATE TABLE ResonancePaths (
    path_id VARCHAR(255) PRIMARY KEY,
    echo_a_id VARCHAR(255) NOT NULL,
    echo_b_id VARCHAR(255) NOT NULL,
    shared_core_feeling VARCHAR(100) NOT NULL,
    connection_score DECIMAL(3,2) NOT NULL,
    creation_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (echo_a_id) REFERENCES Echoes(echo_id) ON DELETE CASCADE,
    FOREIGN KEY (echo_b_id) REFERENCES Echoes(echo_id) ON DELETE CASCADE,
    -- Ensure a path is unique regardless of A/B order
    UNIQUE (echo_a_id, echo_b_id)
);

-- Table for storing user interactions with Resonance Paths (Reflections).
-- This is how we track which paths users have explored and their personal insights.
CREATE TABLE UserReflections (
    reflection_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL, -- Pseudonym ID, not real user ID
    path_id VARCHAR(255) NOT NULL,
    reflection_text TEXT NOT NULL,
    reflection_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (path_id) REFERENCES ResonancePaths(path_id) ON DELETE CASCADE,
    -- A user can only submit one reflection per path (or update it)
    UNIQUE (user_id, path_id)
);

-- Indexing for performance on common lookups
CREATE INDEX idx_echo_content ON Echoes(content(255)); -- Index first 255 chars for search
CREATE INDEX idx_signature_feeling ON EmotionalSignatures(core_feeling);
CREATE INDEX idx_tag_name ON ContextTags(tag_name);
CREATE INDEX idx_path_feeling ON ResonancePaths(shared_core_feeling);
CREATE INDEX idx_reflection_user_path ON UserReflections(user_id, path_id);
