--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6 (Debian 12.6-1.pgdg100+1)
-- Dumped by pg_dump version 12.6 (Ubuntu 12.6-0ubuntu0.20.04.1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: kuronia
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO kuronia;

--
-- Name: journals; Type: TABLE; Schema: public; Owner: kuronia
--

CREATE TABLE public.journals (
    id integer NOT NULL,
    nendo character varying(4) NOT NULL,
    date character varying(8) NOT NULL,
    karikata_cd character varying(5) NOT NULL,
    karikata_value integer NOT NULL,
    kasikata_cd character varying(5) NOT NULL,
    kasikata_value integer NOT NULL,
    note text,
    checked character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.journals OWNER TO kuronia;

--
-- Name: journals_id_seq; Type: SEQUENCE; Schema: public; Owner: kuronia
--

CREATE SEQUENCE public.journals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.journals_id_seq OWNER TO kuronia;

--
-- Name: journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kuronia
--

ALTER SEQUENCE public.journals_id_seq OWNED BY public.journals.id;


--
-- Name: kamoku_masters; Type: TABLE; Schema: public; Owner: kuronia
--

CREATE TABLE public.kamoku_masters (
    id integer NOT NULL,
    kamoku_cd character varying(2) NOT NULL,
    kamoku_full_name text NOT NULL,
    kamoku_ryaku_name text NOT NULL,
    kamoku_kana_name text NOT NULL,
    kamoku_bunrui_cd character varying(1) NOT NULL,
    kamoku_type character varying(1) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.kamoku_masters OWNER TO kuronia;

--
-- Name: kamoku_masters_id_seq; Type: SEQUENCE; Schema: public; Owner: kuronia
--

CREATE SEQUENCE public.kamoku_masters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kamoku_masters_id_seq OWNER TO kuronia;

--
-- Name: kamoku_masters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kuronia
--

ALTER SEQUENCE public.kamoku_masters_id_seq OWNED BY public.kamoku_masters.id;


--
-- Name: nendo_masters; Type: TABLE; Schema: public; Owner: kuronia
--

CREATE TABLE public.nendo_masters (
    id integer NOT NULL,
    nendo character varying(4) NOT NULL,
    start_date character varying(8) NOT NULL,
    end_date character varying(8) NOT NULL,
    fixed character varying(1) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.nendo_masters OWNER TO kuronia;

--
-- Name: nendo_masters_id_seq; Type: SEQUENCE; Schema: public; Owner: kuronia
--

CREATE SEQUENCE public.nendo_masters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nendo_masters_id_seq OWNER TO kuronia;

--
-- Name: nendo_masters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kuronia
--

ALTER SEQUENCE public.nendo_masters_id_seq OWNED BY public.nendo_masters.id;


--
-- Name: saimoku_masters; Type: TABLE; Schema: public; Owner: kuronia
--

CREATE TABLE public.saimoku_masters (
    id integer NOT NULL,
    saimoku_cd character varying(5) NOT NULL,
    kamoku_cd character varying(5) NOT NULL,
    saimoku_full_name text NOT NULL,
    saimoku_ryaku_name text NOT NULL,
    saimoku_kana_name text NOT NULL
);


ALTER TABLE public.saimoku_masters OWNER TO kuronia;

--
-- Name: saimoku_masters_id_seq; Type: SEQUENCE; Schema: public; Owner: kuronia
--

CREATE SEQUENCE public.saimoku_masters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.saimoku_masters_id_seq OWNER TO kuronia;

--
-- Name: saimoku_masters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kuronia
--

ALTER SEQUENCE public.saimoku_masters_id_seq OWNED BY public.saimoku_masters.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: kuronia
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO kuronia;

--
-- Name: journals id; Type: DEFAULT; Schema: public; Owner: kuronia
--

ALTER TABLE ONLY public.journals ALTER COLUMN id SET DEFAULT nextval('public.journals_id_seq'::regclass);


--
-- Name: kamoku_masters id; Type: DEFAULT; Schema: public; Owner: kuronia
--

ALTER TABLE ONLY public.kamoku_masters ALTER COLUMN id SET DEFAULT nextval('public.kamoku_masters_id_seq'::regclass);


--
-- Name: nendo_masters id; Type: DEFAULT; Schema: public; Owner: kuronia
--

ALTER TABLE ONLY public.nendo_masters ALTER COLUMN id SET DEFAULT nextval('public.nendo_masters_id_seq'::regclass);


--
-- Name: saimoku_masters id; Type: DEFAULT; Schema: public; Owner: kuronia
--

ALTER TABLE ONLY public.saimoku_masters ALTER COLUMN id SET DEFAULT nextval('public.saimoku_masters_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: kuronia
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: journals journals_pkey; Type: CONSTRAINT; Schema: public; Owner: kuronia
--

ALTER TABLE ONLY public.journals
    ADD CONSTRAINT journals_pkey PRIMARY KEY (id);


--
-- Name: kamoku_masters kamoku_masters_pkey; Type: CONSTRAINT; Schema: public; Owner: kuronia
--

ALTER TABLE ONLY public.kamoku_masters
    ADD CONSTRAINT kamoku_masters_pkey PRIMARY KEY (id);


--
-- Name: nendo_masters nendo_masters_pkey; Type: CONSTRAINT; Schema: public; Owner: kuronia
--

ALTER TABLE ONLY public.nendo_masters
    ADD CONSTRAINT nendo_masters_pkey PRIMARY KEY (id);


--
-- Name: saimoku_masters saimoku_masters_pkey; Type: CONSTRAINT; Schema: public; Owner: kuronia
--

ALTER TABLE ONLY public.saimoku_masters
    ADD CONSTRAINT saimoku_masters_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: kuronia
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: journals_checked_index; Type: INDEX; Schema: public; Owner: kuronia
--

CREATE INDEX journals_checked_index ON public.journals USING btree (nendo, checked, date);


--
-- Name: journals_code_index; Type: INDEX; Schema: public; Owner: kuronia
--

CREATE INDEX journals_code_index ON public.journals USING btree (nendo, karikata_cd, kasikata_cd, date);


--
-- Name: journals_default_index; Type: INDEX; Schema: public; Owner: kuronia
--

CREATE INDEX journals_default_index ON public.journals USING btree (nendo, date);


--
-- PostgreSQL database dump complete
--

