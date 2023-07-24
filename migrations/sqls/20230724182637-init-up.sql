/* Replace with your SQL commands */

-- ### PART 1 - CREATE TABLES AND FUNCTIONS

--
-- TOC entry 224 (class 1255 OID 16513)
-- Name: update_last_modified(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_last_modified() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    NEW.LastModified = NOW();
    RETURN NEW;
  END;
$$;


ALTER FUNCTION public.update_last_modified() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 32847)
-- Name: credentials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credentials (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(10) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    phone character varying(15),
    last_login timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT credentials_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'operator'::character varying])::text[])))
);


ALTER TABLE public.credentials OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 32846)
-- Name: credentials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.credentials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.credentials_id_seq OWNER TO postgres;

--
-- TOC entry 3389 (class 0 OID 0)
-- Dependencies: 222
-- Name: credentials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.credentials_id_seq OWNED BY public.credentials.id;


--
-- TOC entry 215 (class 1259 OID 16426)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    customerid integer NOT NULL,
    customername character varying(256) NOT NULL,
    customeruuid character varying(8) NOT NULL,
    dateofbirth date,
    balance integer DEFAULT 0 NOT NULL,
    encryptiontype character varying(10) NOT NULL,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    lastmodified timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    isactive boolean DEFAULT false NOT NULL,
    CONSTRAINT customers_balance_check CHECK ((balance >= 0))
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16425)
-- Name: customers_customerid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_customerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_customerid_seq OWNER TO postgres;

--
-- TOC entry 3390 (class 0 OID 0)
-- Dependencies: 214
-- Name: customers_customerid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_customerid_seq OWNED BY public.customers.customerid;


--
-- TOC entry 219 (class 1259 OID 16461)
-- Name: deposits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deposits (
    depositid integer NOT NULL,
    customerid integer NOT NULL,
    amount integer NOT NULL,
    deposittimestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.deposits OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16460)
-- Name: deposits_depositid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deposits_depositid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deposits_depositid_seq OWNER TO postgres;

--
-- TOC entry 3391 (class 0 OID 0)
-- Dependencies: 218
-- Name: deposits_depositid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deposits_depositid_seq OWNED BY public.deposits.depositid;


--
-- TOC entry 221 (class 1259 OID 16492)
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    paymentid integer NOT NULL,
    customerid integer NOT NULL,
    spotid integer NOT NULL,
    paymenttimestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16491)
-- Name: payments_paymentid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_paymentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_paymentid_seq OWNER TO postgres;

--
-- TOC entry 3392 (class 0 OID 0)
-- Dependencies: 220
-- Name: payments_paymentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_paymentid_seq OWNED BY public.payments.paymentid;


--
-- TOC entry 217 (class 1259 OID 16438)
-- Name: spots; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spots (
    spotid integer NOT NULL,
    spotname character varying(256) NOT NULL,
    price integer NOT NULL,
    isactive boolean DEFAULT false NOT NULL,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    lastmodified timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.spots OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16437)
-- Name: spots_spotid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spots_spotid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spots_spotid_seq OWNER TO postgres;

--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 216
-- Name: spots_spotid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spots_spotid_seq OWNED BY public.spots.spotid;


--
-- TOC entry 3207 (class 2604 OID 32850)
-- Name: credentials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credentials ALTER COLUMN id SET DEFAULT nextval('public.credentials_id_seq'::regclass);


--
-- TOC entry 3194 (class 2604 OID 16429)
-- Name: customers customerid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN customerid SET DEFAULT nextval('public.customers_customerid_seq'::regclass);


--
-- TOC entry 3203 (class 2604 OID 16464)
-- Name: deposits depositid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposits ALTER COLUMN depositid SET DEFAULT nextval('public.deposits_depositid_seq'::regclass);


--
-- TOC entry 3205 (class 2604 OID 16495)
-- Name: payments paymentid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN paymentid SET DEFAULT nextval('public.payments_paymentid_seq'::regclass);


--
-- TOC entry 3199 (class 2604 OID 16441)
-- Name: spots spotid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spots ALTER COLUMN spotid SET DEFAULT nextval('public.spots_spotid_seq'::regclass);



-- ### PART 2 - ADD CONSTRAINTS AND TRIGGERS

--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 222
-- Name: credentials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.credentials_id_seq', 2, true);


--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 214
-- Name: customers_customerid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_customerid_seq', 14, true);


-- 
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 218
-- Name: deposits_depositid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deposits_depositid_seq', 45, true);


--
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 220
-- Name: payments_paymentid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_paymentid_seq', 82, true);


--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 216
-- Name: spots_spotid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.spots_spotid_seq', 12, true);


--
-- TOC entry 3221 (class 2606 OID 32859)
-- Name: credentials credentials_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_email_key UNIQUE (email);


--
-- TOC entry 3223 (class 2606 OID 32855)
-- Name: credentials credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_pkey PRIMARY KEY (id);


--
-- TOC entry 3225 (class 2606 OID 32857)
-- Name: credentials credentials_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_username_key UNIQUE (username);


--
-- TOC entry 3211 (class 2606 OID 16436)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customerid);


--
-- TOC entry 3213 (class 2606 OID 16512)
-- Name: customers customers_un; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_un UNIQUE (customeruuid);


--
-- TOC entry 3217 (class 2606 OID 16467)
-- Name: deposits deposits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposits
    ADD CONSTRAINT deposits_pkey PRIMARY KEY (depositid);


--
-- TOC entry 3219 (class 2606 OID 16498)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (paymentid);


--
-- TOC entry 3215 (class 2606 OID 16446)
-- Name: spots spots_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spots
    ADD CONSTRAINT spots_pkey PRIMARY KEY (spotid);


--
-- TOC entry 3229 (class 2620 OID 16514)
-- Name: customers customer_lastmodified_update_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER customer_lastmodified_update_trigger BEFORE UPDATE ON public.customers FOR EACH ROW WHEN ((((new.customername)::text IS DISTINCT FROM (old.customername)::text) OR ((new.customeruuid)::text IS DISTINCT FROM (old.customeruuid)::text) OR (new.dateofbirth <> old.dateofbirth) OR (new.balance IS DISTINCT FROM old.balance) OR ((new.encryptiontype)::text IS DISTINCT FROM (old.encryptiontype)::text) OR (new.isactive IS DISTINCT FROM old.isactive))) EXECUTE FUNCTION public.update_last_modified();


--
-- TOC entry 3230 (class 2620 OID 24590)
-- Name: spots spot_lastmodified_update_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER spot_lastmodified_update_trigger BEFORE UPDATE ON public.spots FOR EACH ROW WHEN ((((new.spotname)::text IS DISTINCT FROM (old.spotname)::text) OR (new.price IS DISTINCT FROM old.price) OR (new.isactive IS DISTINCT FROM old.isactive))) EXECUTE FUNCTION public.update_last_modified();


--
-- TOC entry 3226 (class 2606 OID 16468)
-- Name: deposits deposits_customerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposits
    ADD CONSTRAINT deposits_customerid_fkey FOREIGN KEY (customerid) REFERENCES public.customers(customerid);


--
-- TOC entry 3227 (class 2606 OID 16499)
-- Name: payments payments_customerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_customerid_fkey FOREIGN KEY (customerid) REFERENCES public.customers(customerid);


--
-- TOC entry 3228 (class 2606 OID 16504)
-- Name: payments payments_spotid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_spotid_fkey FOREIGN KEY (spotid) REFERENCES public.spots(spotid);
