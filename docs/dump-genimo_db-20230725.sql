PGDMP     9    (                 {            genimo_dashboard    15.3    15.3 2    9           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            :           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ;           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            <           1262    16398    genimo_dashboard    DATABASE     �   CREATE DATABASE genimo_dashboard WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Indonesia.1252';
     DROP DATABASE genimo_dashboard;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            =           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1255    16513    update_last_modified()    FUNCTION     �   CREATE FUNCTION public.update_last_modified() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    NEW.LastModified = NOW();
    RETURN NEW;
  END;
$$;
 -   DROP FUNCTION public.update_last_modified();
       public          postgres    false    4            �            1259    32847    credentials    TABLE     M  CREATE TABLE public.credentials (
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
    DROP TABLE public.credentials;
       public         heap    postgres    false    4            �            1259    32846    credentials_id_seq    SEQUENCE     �   CREATE SEQUENCE public.credentials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.credentials_id_seq;
       public          postgres    false    223    4            >           0    0    credentials_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.credentials_id_seq OWNED BY public.credentials.id;
          public          postgres    false    222            �            1259    16426 	   customers    TABLE     !  CREATE TABLE public.customers (
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
    DROP TABLE public.customers;
       public         heap    postgres    false    4            �            1259    16425    customers_customerid_seq    SEQUENCE     �   CREATE SEQUENCE public.customers_customerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.customers_customerid_seq;
       public          postgres    false    4    215            ?           0    0    customers_customerid_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.customers_customerid_seq OWNED BY public.customers.customerid;
          public          postgres    false    214            �            1259    16461    deposits    TABLE     �   CREATE TABLE public.deposits (
    depositid integer NOT NULL,
    customerid integer NOT NULL,
    amount integer NOT NULL,
    deposittimestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.deposits;
       public         heap    postgres    false    4            �            1259    16460    deposits_depositid_seq    SEQUENCE     �   CREATE SEQUENCE public.deposits_depositid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.deposits_depositid_seq;
       public          postgres    false    219    4            @           0    0    deposits_depositid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.deposits_depositid_seq OWNED BY public.deposits.depositid;
          public          postgres    false    218            �            1259    16492    payments    TABLE     �   CREATE TABLE public.payments (
    paymentid integer NOT NULL,
    customerid integer NOT NULL,
    spotid integer NOT NULL,
    paymenttimestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.payments;
       public         heap    postgres    false    4            �            1259    16491    payments_paymentid_seq    SEQUENCE     �   CREATE SEQUENCE public.payments_paymentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.payments_paymentid_seq;
       public          postgres    false    221    4            A           0    0    payments_paymentid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.payments_paymentid_seq OWNED BY public.payments.paymentid;
          public          postgres    false    220            �            1259    16438    spots    TABLE     Q  CREATE TABLE public.spots (
    spotid integer NOT NULL,
    spotname character varying(256) NOT NULL,
    price integer NOT NULL,
    isactive boolean DEFAULT false NOT NULL,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    lastmodified timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.spots;
       public         heap    postgres    false    4            �            1259    16437    spots_spotid_seq    SEQUENCE     �   CREATE SEQUENCE public.spots_spotid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.spots_spotid_seq;
       public          postgres    false    4    217            B           0    0    spots_spotid_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.spots_spotid_seq OWNED BY public.spots.spotid;
          public          postgres    false    216            �           2604    32850    credentials id    DEFAULT     p   ALTER TABLE ONLY public.credentials ALTER COLUMN id SET DEFAULT nextval('public.credentials_id_seq'::regclass);
 =   ALTER TABLE public.credentials ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    222    223            z           2604    16429    customers customerid    DEFAULT     |   ALTER TABLE ONLY public.customers ALTER COLUMN customerid SET DEFAULT nextval('public.customers_customerid_seq'::regclass);
 C   ALTER TABLE public.customers ALTER COLUMN customerid DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    16464    deposits depositid    DEFAULT     x   ALTER TABLE ONLY public.deposits ALTER COLUMN depositid SET DEFAULT nextval('public.deposits_depositid_seq'::regclass);
 A   ALTER TABLE public.deposits ALTER COLUMN depositid DROP DEFAULT;
       public          postgres    false    218    219    219            �           2604    16495    payments paymentid    DEFAULT     x   ALTER TABLE ONLY public.payments ALTER COLUMN paymentid SET DEFAULT nextval('public.payments_paymentid_seq'::regclass);
 A   ALTER TABLE public.payments ALTER COLUMN paymentid DROP DEFAULT;
       public          postgres    false    220    221    221                       2604    16441    spots spotid    DEFAULT     l   ALTER TABLE ONLY public.spots ALTER COLUMN spotid SET DEFAULT nextval('public.spots_spotid_seq'::regclass);
 ;   ALTER TABLE public.spots ALTER COLUMN spotid DROP DEFAULT;
       public          postgres    false    216    217    217            6          0    32847    credentials 
   TABLE DATA           �   COPY public.credentials (id, username, email, password, role, first_name, last_name, phone, last_login, created_at) FROM stdin;
    public          postgres    false    223   �?       .          0    16426 	   customers 
   TABLE DATA           �   COPY public.customers (customerid, customername, customeruuid, dateofbirth, balance, encryptiontype, createdat, lastmodified, isactive) FROM stdin;
    public          postgres    false    215   N@       2          0    16461    deposits 
   TABLE DATA           S   COPY public.deposits (depositid, customerid, amount, deposittimestamp) FROM stdin;
    public          postgres    false    219   B       4          0    16492    payments 
   TABLE DATA           S   COPY public.payments (paymentid, customerid, spotid, paymenttimestamp) FROM stdin;
    public          postgres    false    221   6C       0          0    16438    spots 
   TABLE DATA           [   COPY public.spots (spotid, spotname, price, isactive, createdat, lastmodified) FROM stdin;
    public          postgres    false    217   �E       C           0    0    credentials_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.credentials_id_seq', 2, true);
          public          postgres    false    222            D           0    0    customers_customerid_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.customers_customerid_seq', 14, true);
          public          postgres    false    214            E           0    0    deposits_depositid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.deposits_depositid_seq', 45, true);
          public          postgres    false    218            F           0    0    payments_paymentid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.payments_paymentid_seq', 82, true);
          public          postgres    false    220            G           0    0    spots_spotid_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.spots_spotid_seq', 12, true);
          public          postgres    false    216            �           2606    32859 !   credentials credentials_email_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_email_key UNIQUE (email);
 K   ALTER TABLE ONLY public.credentials DROP CONSTRAINT credentials_email_key;
       public            postgres    false    223            �           2606    32855    credentials credentials_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.credentials DROP CONSTRAINT credentials_pkey;
       public            postgres    false    223            �           2606    32857 $   credentials credentials_username_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_username_key UNIQUE (username);
 N   ALTER TABLE ONLY public.credentials DROP CONSTRAINT credentials_username_key;
       public            postgres    false    223            �           2606    16436    customers customers_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customerid);
 B   ALTER TABLE ONLY public.customers DROP CONSTRAINT customers_pkey;
       public            postgres    false    215            �           2606    16512    customers customers_un 
   CONSTRAINT     Y   ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_un UNIQUE (customeruuid);
 @   ALTER TABLE ONLY public.customers DROP CONSTRAINT customers_un;
       public            postgres    false    215            �           2606    16467    deposits deposits_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.deposits
    ADD CONSTRAINT deposits_pkey PRIMARY KEY (depositid);
 @   ALTER TABLE ONLY public.deposits DROP CONSTRAINT deposits_pkey;
       public            postgres    false    219            �           2606    16498    payments payments_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (paymentid);
 @   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_pkey;
       public            postgres    false    221            �           2606    16446    spots spots_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.spots
    ADD CONSTRAINT spots_pkey PRIMARY KEY (spotid);
 :   ALTER TABLE ONLY public.spots DROP CONSTRAINT spots_pkey;
       public            postgres    false    217            �           2620    16514 .   customers customer_lastmodified_update_trigger    TRIGGER     �  CREATE TRIGGER customer_lastmodified_update_trigger BEFORE UPDATE ON public.customers FOR EACH ROW WHEN ((((new.customername)::text IS DISTINCT FROM (old.customername)::text) OR ((new.customeruuid)::text IS DISTINCT FROM (old.customeruuid)::text) OR (new.dateofbirth <> old.dateofbirth) OR (new.balance IS DISTINCT FROM old.balance) OR ((new.encryptiontype)::text IS DISTINCT FROM (old.encryptiontype)::text) OR (new.isactive IS DISTINCT FROM old.isactive))) EXECUTE FUNCTION public.update_last_modified();
 G   DROP TRIGGER customer_lastmodified_update_trigger ON public.customers;
       public          postgres    false    215    215    215    215    215    224    215    215            �           2620    24590 &   spots spot_lastmodified_update_trigger    TRIGGER     +  CREATE TRIGGER spot_lastmodified_update_trigger BEFORE UPDATE ON public.spots FOR EACH ROW WHEN ((((new.spotname)::text IS DISTINCT FROM (old.spotname)::text) OR (new.price IS DISTINCT FROM old.price) OR (new.isactive IS DISTINCT FROM old.isactive))) EXECUTE FUNCTION public.update_last_modified();
 ?   DROP TRIGGER spot_lastmodified_update_trigger ON public.spots;
       public          postgres    false    217    224    217    217    217            �           2606    16468 !   deposits deposits_customerid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.deposits
    ADD CONSTRAINT deposits_customerid_fkey FOREIGN KEY (customerid) REFERENCES public.customers(customerid);
 K   ALTER TABLE ONLY public.deposits DROP CONSTRAINT deposits_customerid_fkey;
       public          postgres    false    219    3211    215            �           2606    16499 !   payments payments_customerid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_customerid_fkey FOREIGN KEY (customerid) REFERENCES public.customers(customerid);
 K   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_customerid_fkey;
       public          postgres    false    221    215    3211            �           2606    16504    payments payments_spotid_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_spotid_fkey FOREIGN KEY (spotid) REFERENCES public.spots(spotid);
 G   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_spotid_fkey;
       public          postgres    false    221    217    3215            6   U   x�3�LL���<�Ԋ�܂�T���\� g����Z*ZZ��Z��[Zrq� QjQbI~�IH������ w(�      .   �  x����J�@�ϕ���PU�?���"��F��^�fHC&�dP|����]���}_���c�Ծ{�+xgS@)�I�2�7-0���N�1up��Y�T������_ԟ<���:b�"�VS�^�C^�o�U�_c~ɝ����/P,0�Di����nw��`�M��nzꗢ��r���k.#,�~`!�b�Hy��s��[Ʀ��hX��'� �Ce��n(���;��m��
$j4�űt�cV15�ۚ��e-���ЉeW��:AޕX�_Ni��6\�WȍíD�6��~R��0�R������E2��6L8�!y���L�n��W�1�83�G'�EKj,雷 6H��84 w��T�3n�� ?��u6��6y"�YIC�F�������F��0 bE����k���ߺ����!      2     x���ˍC!Eצ�4��jI�u�,F�h��qd_> �IX���dy0&��V���!!?JJ�'��������}�$IPd�t�I�A� GL�:v�R��Ŗ����b�M�aN� �p�r���%c[>'�;�eKNF��e[N�ȥ9a�����c�!Y��l�m��F�XV�,�"��:ŧ��ǈ�E�����4T��"�/��n�*�-Pt|=�7"QŮ�@Ч��^[�����(&��(�_䁕da^�F�^�>˼��Q��l�k���muꋪ)�ZJ���@      4   ;  x���ݕ�0���*h`}�/۵l�u\)g��y>♑��r��� � �"�@&7䃿���1J��,	��1B���Å HP"xh�Vtd��� �0$A����ŪEe���XI� �03�r�飴�xx�SZ����Q���z�"�a�Rُ�%�8���u���NC/�
�v*Dٺ�+Uf�vz�Gm��*��H��2)+$RFVL�̬�H�jʉ�3��2*����_��{���@�T�4ڴ0x�ɛ����Gٴ�t�����݋mZtq�nlZ�pu57�\�{�z����H�3�_�Cq�,ߐ�̥ܧ1 7�7��"�`�Ͳ&|@�F��B������2:�r~�_���*�A�Cw�p������`���d6ݚن�hi�O��;��%��`�fım6�;��a5�K�@v"����=���9>�/	���  Ksz�B�>���q'�v�Π���9��Bl��%�X`���O�A�N�X��5�o���?1�!�D�\)�-���\Dw���=A��ۀ�C�BYf���]cO�Ǡ'�$��Qk��qN����pF��      0     x����N�0���S�b��ر]�D���C��ƺ�K�s����P� Գ�43;�8Ɖ_BH�f(d�M��":��Ҍ�7�D쇔�H�?�a,��Y�� �!�. Wp��p���Ք���k���^�C��܁���@}���-��n�'O����z3�TR����'��>L���zE�Tv��v$E�v�0-���(��%ϡ��\�%$k�n�l��RL1�~�_A��Ʃ�ik��?$���L�E#H���|*��_|��7��hG��JmoH�B> �T�#     