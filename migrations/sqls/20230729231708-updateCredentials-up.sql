/* Replace with your SQL commands */
---- Add the column without NOT NULL constraint and DEFAULT value
ALTER TABLE ONLY public.credentials
ADD gender VARCHAR(6) default 'male' CHECK (gender IN ('male', 'female'));
--
-- Alter the column to set it as NOT NULL
ALTER TABLE ONLY public.credentials
ALTER COLUMN gender SET NOT NULL;