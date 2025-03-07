-- Check if column 'phone' exists before adding it
SELECT COUNT(*) INTO @column_exists 
FROM information_schema.columns 
WHERE table_name = 'users' AND column_name = 'phone';

SET @query = IF(@column_exists = 0, 
                'ALTER TABLE users ADD COLUMN phone VARCHAR(15) NULL AFTER email', 
                'SELECT ''Column already exists'' AS message');

PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;