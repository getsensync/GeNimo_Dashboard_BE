/* Replace with your SQL commands */
---- Add the column without NOT NULL constraint and DEFAULT value
ALTER TABLE ONLY public.credentials
ADD gender character varying(6) DEFAULT 'male'::character varying;
--

-- ADD Constraint
ALTER TABLE ONLY public.credentials
ADD CONSTRAINT credentials_gender_check CHECK (((gender)::text = ANY ((ARRAY['male'::character varying, 'female'::character varying])::text[])));

-- Alter the column to set it as NOT NULL
ALTER TABLE ONLY public.credentials
ALTER COLUMN gender SET NOT NULL;