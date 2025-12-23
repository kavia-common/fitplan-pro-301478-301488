--
-- PostgreSQL database dump
--

\restrict E2bWmTUgTudf6iKXTeS7DRzSuoergKrFqkCC6UiXwV0d337ua1aQfl3316acf8m

-- Dumped from database version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS myapp;
--
-- Name: myapp; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE myapp WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';


ALTER DATABASE myapp OWNER TO postgres;

\unrestrict E2bWmTUgTudf6iKXTeS7DRzSuoergKrFqkCC6UiXwV0d337ua1aQfl3316acf8m
\connect myapp
\restrict E2bWmTUgTudf6iKXTeS7DRzSuoergKrFqkCC6UiXwV0d337ua1aQfl3316acf8m

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: equipment; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public.equipment (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.equipment OWNER TO appuser;

--
-- Name: equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: appuser
--

CREATE SEQUENCE public.equipment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.equipment_id_seq OWNER TO appuser;

--
-- Name: equipment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: appuser
--

ALTER SEQUENCE public.equipment_id_seq OWNED BY public.equipment.id;


--
-- Name: exercise_sets; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public.exercise_sets (
    id integer NOT NULL,
    workout_log_id uuid,
    exercise_id integer,
    set_number integer,
    reps integer,
    weight_kg numeric(10,2) DEFAULT 0,
    rpe numeric(4,1)
);


ALTER TABLE public.exercise_sets OWNER TO appuser;

--
-- Name: exercise_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: appuser
--

CREATE SEQUENCE public.exercise_sets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exercise_sets_id_seq OWNER TO appuser;

--
-- Name: exercise_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: appuser
--

ALTER SEQUENCE public.exercise_sets_id_seq OWNED BY public.exercise_sets.id;


--
-- Name: exercises; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public.exercises (
    id integer NOT NULL,
    name text NOT NULL,
    primary_muscle text,
    secondary_muscle text,
    equipment_id integer,
    calories_per_min numeric(10,2) DEFAULT 5.00
);


ALTER TABLE public.exercises OWNER TO appuser;

--
-- Name: exercises_id_seq; Type: SEQUENCE; Schema: public; Owner: appuser
--

CREATE SEQUENCE public.exercises_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exercises_id_seq OWNER TO appuser;

--
-- Name: exercises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: appuser
--

ALTER SEQUENCE public.exercises_id_seq OWNED BY public.exercises.id;


--
-- Name: goals; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public.goals (
    id integer NOT NULL,
    user_id uuid,
    goal_type text,
    target_value numeric(10,2),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.goals OWNER TO appuser;

--
-- Name: goals_id_seq; Type: SEQUENCE; Schema: public; Owner: appuser
--

CREATE SEQUENCE public.goals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.goals_id_seq OWNER TO appuser;

--
-- Name: goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: appuser
--

ALTER SEQUENCE public.goals_id_seq OWNED BY public.goals.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email text NOT NULL,
    name text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO appuser;

--
-- Name: workout_exercises; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public.workout_exercises (
    id integer NOT NULL,
    workout_id uuid,
    exercise_id integer,
    target_sets integer,
    target_reps integer,
    rest_seconds integer DEFAULT 90
);


ALTER TABLE public.workout_exercises OWNER TO appuser;

--
-- Name: workout_exercises_id_seq; Type: SEQUENCE; Schema: public; Owner: appuser
--

CREATE SEQUENCE public.workout_exercises_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workout_exercises_id_seq OWNER TO appuser;

--
-- Name: workout_exercises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: appuser
--

ALTER SEQUENCE public.workout_exercises_id_seq OWNED BY public.workout_exercises.id;


--
-- Name: workout_logs; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public.workout_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    workout_id uuid,
    performed_at timestamp with time zone DEFAULT now(),
    duration_minutes integer DEFAULT 0
);


ALTER TABLE public.workout_logs OWNER TO appuser;

--
-- Name: workouts; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public.workouts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    goal text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.workouts OWNER TO appuser;

--
-- Name: equipment id; Type: DEFAULT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.equipment ALTER COLUMN id SET DEFAULT nextval('public.equipment_id_seq'::regclass);


--
-- Name: exercise_sets id; Type: DEFAULT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.exercise_sets ALTER COLUMN id SET DEFAULT nextval('public.exercise_sets_id_seq'::regclass);


--
-- Name: exercises id; Type: DEFAULT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.exercises ALTER COLUMN id SET DEFAULT nextval('public.exercises_id_seq'::regclass);


--
-- Name: goals id; Type: DEFAULT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.goals ALTER COLUMN id SET DEFAULT nextval('public.goals_id_seq'::regclass);


--
-- Name: workout_exercises id; Type: DEFAULT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.workout_exercises ALTER COLUMN id SET DEFAULT nextval('public.workout_exercises_id_seq'::regclass);


--
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public.equipment (id, name) FROM stdin;
1	None
2	Dumbbell
3	Barbell
4	Machine
5	Resistance Band
6	Kettlebell
7	Cable
8	Pull-up Bar
\.


--
-- Data for Name: exercise_sets; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public.exercise_sets (id, workout_log_id, exercise_id, set_number, reps, weight_kg, rpe) FROM stdin;
\.


--
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public.exercises (id, name, primary_muscle, secondary_muscle, equipment_id, calories_per_min) FROM stdin;
1	Push-up	Chest	Triceps	1	6.00
2	Squat	Quadriceps	Glutes	3	8.00
3	Bench Press	Chest	Triceps	3	7.50
4	Dumbbell Row	Back	Biceps	2	6.50
5	Lat Pulldown	Back	Biceps	4	7.00
6	Pull-ups	Back	Biceps	8	8.00
7	Deadlift	Back	Hamstrings	3	9.00
8	Lunges	Quadriceps	Glutes	1	7.00
9	Overhead Press	Shoulders	Triceps	3	7.50
10	Bicep Curls	Biceps	Forearms	2	5.00
11	Tricep Dips	Triceps	Chest	1	6.50
12	Plank	Core	Shoulders	1	4.00
13	Russian Twists	Core	Obliques	1	5.50
14	Leg Press	Quadriceps	Glutes	4	8.00
15	Leg Curls	Hamstrings	Calves	4	6.00
16	Calf Raises	Calves	Soleus	1	4.50
17	Lateral Raises	Shoulders	Trapezius	2	5.00
18	Kettlebell Swings	Glutes	Hamstrings	6	9.50
19	Cable Chest Fly	Chest	Shoulders	7	6.50
20	Face Pulls	Shoulders	Upper Back	7	5.50
21	Burpees	Full Body	Cardio	1	10.00
22	Mountain Climbers	Core	Cardio	1	8.50
\.


--
-- Data for Name: goals; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public.goals (id, user_id, goal_type, target_value, created_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public.users (id, email, name, created_at) FROM stdin;
\.


--
-- Data for Name: workout_exercises; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public.workout_exercises (id, workout_id, exercise_id, target_sets, target_reps, rest_seconds) FROM stdin;
\.


--
-- Data for Name: workout_logs; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public.workout_logs (id, workout_id, performed_at, duration_minutes) FROM stdin;
\.


--
-- Data for Name: workouts; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public.workouts (id, user_id, goal, created_at) FROM stdin;
\.


--
-- Name: equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: appuser
--

SELECT pg_catalog.setval('public.equipment_id_seq', 8, true);


--
-- Name: exercise_sets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: appuser
--

SELECT pg_catalog.setval('public.exercise_sets_id_seq', 1, false);


--
-- Name: exercises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: appuser
--

SELECT pg_catalog.setval('public.exercises_id_seq', 22, true);


--
-- Name: goals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: appuser
--

SELECT pg_catalog.setval('public.goals_id_seq', 1, false);


--
-- Name: workout_exercises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: appuser
--

SELECT pg_catalog.setval('public.workout_exercises_id_seq', 1, false);


--
-- Name: equipment equipment_name_key; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_name_key UNIQUE (name);


--
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (id);


--
-- Name: exercise_sets exercise_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.exercise_sets
    ADD CONSTRAINT exercise_sets_pkey PRIMARY KEY (id);


--
-- Name: exercises exercises_name_key; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_name_key UNIQUE (name);


--
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (id);


--
-- Name: goals goals_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: workout_exercises workout_exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.workout_exercises
    ADD CONSTRAINT workout_exercises_pkey PRIMARY KEY (id);


--
-- Name: workout_logs workout_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.workout_logs
    ADD CONSTRAINT workout_logs_pkey PRIMARY KEY (id);


--
-- Name: workouts workouts_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.workouts
    ADD CONSTRAINT workouts_pkey PRIMARY KEY (id);


--
-- Name: idx_exercise_sets_workout_log_id; Type: INDEX; Schema: public; Owner: appuser
--

CREATE INDEX idx_exercise_sets_workout_log_id ON public.exercise_sets USING btree (workout_log_id);


--
-- Name: idx_exercises_name; Type: INDEX; Schema: public; Owner: appuser
--

CREATE INDEX idx_exercises_name ON public.exercises USING btree (name);


--
-- Name: idx_exercises_primary_muscle; Type: INDEX; Schema: public; Owner: appuser
--

CREATE INDEX idx_exercises_primary_muscle ON public.exercises USING btree (primary_muscle);


--
-- Name: idx_goals_user_id; Type: INDEX; Schema: public; Owner: appuser
--

CREATE INDEX idx_goals_user_id ON public.goals USING btree (user_id);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: appuser
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: idx_workout_exercises_workout_id; Type: INDEX; Schema: public; Owner: appuser
--

CREATE INDEX idx_workout_exercises_workout_id ON public.workout_exercises USING btree (workout_id);


--
-- Name: idx_workout_logs_workout_id; Type: INDEX; Schema: public; Owner: appuser
--

CREATE INDEX idx_workout_logs_workout_id ON public.workout_logs USING btree (workout_id);


--
-- Name: idx_workouts_user_id; Type: INDEX; Schema: public; Owner: appuser
--

CREATE INDEX idx_workouts_user_id ON public.workouts USING btree (user_id);


--
-- Name: exercise_sets exercise_sets_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.exercise_sets
    ADD CONSTRAINT exercise_sets_exercise_id_fkey FOREIGN KEY (exercise_id) REFERENCES public.exercises(id) ON DELETE CASCADE;


--
-- Name: exercise_sets exercise_sets_workout_log_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.exercise_sets
    ADD CONSTRAINT exercise_sets_workout_log_id_fkey FOREIGN KEY (workout_log_id) REFERENCES public.workout_logs(id) ON DELETE CASCADE;


--
-- Name: exercises exercises_equipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_equipment_id_fkey FOREIGN KEY (equipment_id) REFERENCES public.equipment(id) ON DELETE SET NULL;


--
-- Name: goals goals_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: workout_exercises workout_exercises_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.workout_exercises
    ADD CONSTRAINT workout_exercises_exercise_id_fkey FOREIGN KEY (exercise_id) REFERENCES public.exercises(id) ON DELETE CASCADE;


--
-- Name: workout_exercises workout_exercises_workout_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.workout_exercises
    ADD CONSTRAINT workout_exercises_workout_id_fkey FOREIGN KEY (workout_id) REFERENCES public.workouts(id) ON DELETE CASCADE;


--
-- Name: workout_logs workout_logs_workout_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.workout_logs
    ADD CONSTRAINT workout_logs_workout_id_fkey FOREIGN KEY (workout_id) REFERENCES public.workouts(id) ON DELETE CASCADE;


--
-- Name: workouts workouts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public.workouts
    ADD CONSTRAINT workouts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: DATABASE myapp; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE myapp TO appuser;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO appuser;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.armor(bytea) TO appuser;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.armor(bytea, text[], text[]) TO appuser;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.crypt(text, text) TO appuser;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.dearmor(text) TO appuser;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.decrypt(bytea, bytea, text) TO appuser;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.decrypt_iv(bytea, bytea, bytea, text) TO appuser;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.digest(bytea, text) TO appuser;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.digest(text, text) TO appuser;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.encrypt(bytea, bytea, text) TO appuser;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.encrypt_iv(bytea, bytea, bytea, text) TO appuser;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gen_random_bytes(integer) TO appuser;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gen_random_uuid() TO appuser;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gen_salt(text) TO appuser;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gen_salt(text, integer) TO appuser;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hmac(bytea, bytea, text) TO appuser;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hmac(text, text, text) TO appuser;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_armor_headers(text, OUT key text, OUT value text) TO appuser;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_key_id(bytea) TO appuser;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_decrypt(bytea, bytea) TO appuser;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_decrypt(bytea, bytea, text) TO appuser;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_decrypt(bytea, bytea, text, text) TO appuser;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea) TO appuser;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea, text) TO appuser;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO appuser;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_encrypt(text, bytea) TO appuser;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_encrypt(text, bytea, text) TO appuser;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_encrypt_bytea(bytea, bytea) TO appuser;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_encrypt_bytea(bytea, bytea, text) TO appuser;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_decrypt(bytea, text) TO appuser;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_decrypt(bytea, text, text) TO appuser;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_decrypt_bytea(bytea, text) TO appuser;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_decrypt_bytea(bytea, text, text) TO appuser;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_encrypt(text, text) TO appuser;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_encrypt(text, text, text) TO appuser;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_encrypt_bytea(bytea, text) TO appuser;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_encrypt_bytea(bytea, text, text) TO appuser;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO appuser;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TYPES TO appuser;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO appuser;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO appuser;


--
-- PostgreSQL database dump complete
--

\unrestrict E2bWmTUgTudf6iKXTeS7DRzSuoergKrFqkCC6UiXwV0d337ua1aQfl3316acf8m

