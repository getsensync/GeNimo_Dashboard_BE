--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-07-24 05:34:30

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
    created_at timestamp without time zone NOT NULL,
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
-- TOC entry 3388 (class 0 OID 0)
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
-- TOC entry 3389 (class 0 OID 0)
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
-- TOC entry 3390 (class 0 OID 0)
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
-- TOC entry 3391 (class 0 OID 0)
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
-- TOC entry 3392 (class 0 OID 0)
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


--
-- TOC entry 3382 (class 0 OID 32847)
-- Dependencies: 223
-- Data for Name: credentials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credentials (id, username, email, password, role, first_name, last_name, phone, last_login, created_at) FROM stdin;
1	ad	admin@example.com	ad	admin	\N	\N	\N	\N	2023-07-19 19:55:35.339901
2	op	operator@example.com	op	operator	\N	\N	\N	\N	2023-07-19 19:55:35.339901
\.


--
-- TOC entry 3374 (class 0 OID 16426)
-- Dependencies: 215
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (customerid, customername, customeruuid, dateofbirth, balance, encryptiontype, createdat, lastmodified, isactive) FROM stdin;
6	Emily Davis	65432187	1993-09-05	135	DES	2023-07-02 00:29:33.757675	2023-07-02 00:29:33.757675	t
7	Christopher Wilson	34567891	1991-04-18	306	Twofish	2023-07-02 00:29:33.757675	2023-07-02 00:29:33.757675	f
8	Olivia Miller	78912345	1987-08-12	251	RSA	2023-07-02 00:29:33.757675	2023-07-02 00:29:33.757675	t
9	Daniel Anderson	23456789	1994-06-25	204	AES	2023-07-02 00:29:33.757675	2023-07-02 00:29:33.757675	t
10	Sophia Thompson	56789123	1989-02-08	191	DES	2023-07-02 00:29:33.757675	2023-07-02 00:29:33.757675	f
4	Sarah Williams	54321678	1988-03-22	291	RSA	2023-07-02 00:29:33.757675	2023-07-04 21:22:24.194218	t
5	Michael Brown	87651234	1995-11-30	247	AES	2023-07-02 00:29:33.757675	2023-07-06 02:50:33.710575	t
3	David Johnson	98765432	1992-07-15	228	Twofish	2023-07-02 00:29:33.757675	2023-07-06 03:13:18.756987	f
2	Jane Smith	87654321	1985-05-10	210	DES	2023-07-02 00:29:33.757675	2023-07-06 08:01:06.129703	f
13	Leo	32345678	2005-05-01	0	RSA	2023-07-06 08:10:43.496114	2023-07-06 08:10:43.496114	f
1	John Doe	12345678	2023-07-12	332	AES	2023-07-02 00:29:33.757675	2023-07-12 12:25:22.687428	t
\.


--
-- TOC entry 3378 (class 0 OID 16461)
-- Dependencies: 219
-- Data for Name: deposits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deposits (depositid, customerid, amount, deposittimestamp) FROM stdin;
1	1	100	2023-07-02 01:05:36.783534
2	2	50	2023-07-02 01:05:36.783534
3	3	75	2023-07-02 01:05:36.783534
4	4	200	2023-07-02 01:05:36.783534
5	5	150	2023-07-02 01:05:36.783534
6	6	50	2023-07-02 01:05:36.783534
7	7	100	2023-07-02 01:05:36.783534
8	8	75	2023-07-02 01:05:36.783534
9	9	125	2023-07-02 01:05:36.783534
10	10	100	2023-07-02 01:05:36.783534
11	1	50	2023-07-02 01:05:36.783534
12	2	100	2023-07-02 01:05:36.783534
13	3	75	2023-07-02 01:05:36.783534
14	4	150	2023-07-02 01:05:36.783534
15	5	200	2023-07-02 01:05:36.783534
16	6	100	2023-07-02 01:05:36.783534
17	7	125	2023-07-02 01:05:36.783534
18	8	75	2023-07-02 01:05:36.783534
19	9	50	2023-07-02 01:05:36.783534
20	10	100	2023-07-02 01:05:36.783534
21	1	150	2023-07-02 01:05:36.783534
22	2	100	2023-07-02 01:05:36.783534
23	3	200	2023-07-02 01:05:36.783534
24	4	100	2023-07-02 01:05:36.783534
25	5	75	2023-07-02 01:05:36.783534
26	6	50	2023-07-02 01:05:36.783534
27	7	125	2023-07-02 01:05:36.783534
28	8	150	2023-07-02 01:05:36.783534
29	9	75	2023-07-02 01:05:36.783534
30	10	100	2023-07-02 01:05:36.783534
34	1	15	2023-07-06 03:25:56.899785
35	2	10	2023-07-06 03:27:41.11855
37	2	10	2023-07-06 08:01:06.120471
39	1	50	2023-07-06 08:02:17.019107
41	1	10	2023-07-06 18:43:38.669355
42	1	10	2023-07-06 18:43:41.429639
43	1	100	2023-07-12 11:08:45.837608
44	1	10	2023-07-12 11:21:59.153644
45	1	10	2023-07-24 01:35:21.57012
\.


--
-- TOC entry 3380 (class 0 OID 16492)
-- Dependencies: 221
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (paymentid, customerid, spotid, paymenttimestamp) FROM stdin;
7	2	4	2023-07-02 01:30:24.800493
13	3	4	2023-07-02 01:30:24.800493
14	3	7	2023-07-02 01:30:24.800493
15	3	8	2023-07-02 01:30:24.800493
16	4	1	2023-07-02 01:30:24.800493
17	4	4	2023-07-02 01:30:24.800493
18	4	6	2023-07-02 01:30:24.800493
19	4	9	2023-07-02 01:30:24.800493
20	4	10	2023-07-02 01:30:24.800493
21	5	2	2023-07-02 01:30:24.800493
22	5	3	2023-07-02 01:30:24.800493
23	5	4	2023-07-02 01:30:24.800493
24	5	7	2023-07-02 01:30:24.800493
25	5	10	2023-07-02 01:30:24.800493
26	6	1	2023-07-02 01:30:24.800493
27	6	2	2023-07-02 01:30:24.800493
28	6	3	2023-07-02 01:30:24.800493
29	6	8	2023-07-02 01:30:24.800493
30	6	10	2023-07-02 01:30:24.800493
31	7	4	2023-07-02 01:30:24.800493
32	7	5	2023-07-02 01:30:24.800493
33	7	6	2023-07-02 01:30:24.800493
34	7	7	2023-07-02 01:30:24.800493
35	7	9	2023-07-02 01:30:24.800493
36	8	1	2023-07-02 01:30:24.800493
37	8	4	2023-07-02 01:30:24.800493
38	8	6	2023-07-02 01:30:24.800493
39	8	8	2023-07-02 01:30:24.800493
40	8	9	2023-07-02 01:30:24.800493
41	9	1	2023-07-02 01:30:24.800493
42	9	4	2023-07-02 01:30:24.800493
43	9	5	2023-07-02 01:30:24.800493
44	9	6	2023-07-02 01:30:24.800493
45	9	9	2023-07-02 01:30:24.800493
46	10	1	2023-07-02 01:30:24.800493
47	10	2	2023-07-02 01:30:24.800493
48	10	3	2023-07-02 01:30:24.800493
49	10	4	2023-07-02 01:30:24.800493
50	10	5	2023-07-02 01:30:24.800493
51	10	6	2023-07-02 01:30:24.800493
52	10	7	2023-07-02 01:30:24.800493
53	10	8	2023-07-02 01:30:24.800493
54	10	9	2023-07-02 01:30:24.800493
55	10	10	2023-07-02 01:30:24.800493
1	1	1	2023-01-02 01:30:24.8
2	1	2	2023-02-02 01:30:24.8
3	1	3	2023-03-02 01:30:24.8
4	1	4	2023-04-02 01:30:24.8
5	1	5	2023-05-02 01:30:24.8
6	2	1	2023-06-02 01:30:24.8
8	2	5	2023-08-02 01:30:24.8
9	2	8	2023-09-02 01:30:24.8
10	2	10	2023-10-02 01:30:24.8
11	3	2	2023-11-02 01:30:24.8
12	3	3	2023-12-02 01:30:24.8
59	1	1	2023-07-03 13:49:53.963013
60	1	1	2023-07-03 13:51:21.100641
61	4	11	2023-07-04 21:22:12.432757
62	4	11	2023-07-04 21:22:18.145037
63	4	2	2023-07-04 21:22:24.154517
64	5	5	2023-07-04 21:23:03.081654
65	5	11	2023-07-04 21:23:08.266976
66	5	11	2023-07-06 02:50:23.044329
67	5	1	2023-07-06 02:50:33.662393
68	1	1	2023-07-06 02:50:36.750382
69	2	1	2023-07-06 02:50:41.488017
70	3	2	2023-07-06 02:50:46.769578
71	3	4	2023-07-06 03:10:36.00034
72	3	4	2023-07-06 03:11:17.781071
73	3	1	2023-07-06 03:12:10.730529
74	3	1	2023-07-06 03:13:18.750236
75	1	1	2023-07-06 08:06:25.379796
76	1	1	2023-07-06 18:45:35.436333
77	1	1	2023-07-06 18:45:38.184641
78	1	1	2023-07-12 11:12:13.967765
79	1	1	2023-07-12 11:12:20.314153
80	1	1	2023-07-12 11:12:30.957349
81	1	1	2023-07-12 11:12:39.575741
82	1	1	2023-07-24 01:59:11.007141
\.


--
-- TOC entry 3376 (class 0 OID 16438)
-- Dependencies: 217
-- Data for Name: spots; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spots (spotid, spotname, price, isactive, createdat, lastmodified) FROM stdin;
1	Ferris Wheel	10	t	2023-07-02 00:35:56.147185	2023-07-02 00:35:56.147185
2	Roller Coaster	20	t	2023-07-02 00:35:56.147185	2023-07-02 00:35:56.147185
3	Water Slide	15	f	2023-07-02 00:35:56.147185	2023-07-02 00:35:56.147185
6	Bumper Cars	10	t	2023-07-02 00:35:56.147185	2023-07-02 00:35:56.147185
7	Merry-Go-Round	8	f	2023-07-02 00:35:56.147185	2023-07-02 00:35:56.147185
8	Giant Swing	15	t	2023-07-02 00:35:56.147185	2023-07-02 00:35:56.147185
9	Teacups	6	t	2023-07-02 00:35:56.147185	2023-07-02 00:35:56.147185
10	Carnival Games	5	f	2023-07-02 00:35:56.147185	2023-07-02 00:35:56.147185
4	Carousel	8	f	2023-07-02 00:35:56.147185	2023-07-03 01:16:07.620439
5	Haunted House	12	f	2023-07-02 00:35:56.147185	2023-07-03 01:16:23.796785
11	Halilintar	50	f	2023-07-03 01:18:54.699659	2023-07-03 01:25:39.509082
12	mancing naga	100	f	2023-07-06 08:10:52.952869	2023-07-06 08:10:52.952869
\.


--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 222
-- Name: credentials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.credentials_id_seq', 2, true);


--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 214
-- Name: customers_customerid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_customerid_seq', 14, true);


--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 218
-- Name: deposits_depositid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deposits_depositid_seq', 45, true);


--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 220
-- Name: payments_paymentid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_paymentid_seq', 82, true);


--
-- TOC entry 3397 (class 0 OID 0)
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


-- Completed on 2023-07-24 05:34:30

--
-- PostgreSQL database dump complete
--

