/* Replace with your SQL commands */
/* Replace with your SQL commands */
--
-- TOC entry 227 (class 1259 OID 57401)
-- Name: requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.requests (
    requestid integer NOT NULL,
    userid integer NOT NULL,
    status boolean DEFAULT false NOT NULL,
    request_timestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    approveby integer,
    approved_timestamp timestamp without time zone
);


ALTER TABLE public.requests OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 57400)
-- Name: requests_requestid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.requests_requestid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.requests_requestid_seq OWNER TO postgres;

--
-- TOC entry 3354 (class 0 OID 0)
-- Dependencies: 226
-- Name: requests_requestid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.requests_requestid_seq OWNED BY public.requests.requestid;


--
-- TOC entry 3197 (class 2604 OID 57404)
-- Name: requests requestid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests ALTER COLUMN requestid SET DEFAULT nextval('public.requests_requestid_seq'::regclass);


--
-- TOC entry 3355 (class 0 OID 0)
-- Dependencies: 226
-- Name: requests_requestid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.requests_requestid_seq', 2, true);


--
-- TOC entry 3201 (class 2606 OID 57408)
-- Name: requests requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (requestid);


--
-- TOC entry 3202 (class 2606 OID 57414)
-- Name: requests requests_approveby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_approveby_fkey FOREIGN KEY (approveby) REFERENCES public.credentials(id);


--
-- TOC entry 3203 (class 2606 OID 57409)
-- Name: requests requests_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_userid_fkey FOREIGN KEY (userid) REFERENCES public.credentials(id);


-- Completed on 2023-08-02 05:36:41

--
-- PostgreSQL database dump complete
--
