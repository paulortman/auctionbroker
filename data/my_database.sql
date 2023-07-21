--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Ubuntu 10.4-2.pgdg14.04+1)
-- Dumped by pg_dump version 10.4 (Ubuntu 10.4-2.pgdg16.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auction_auctionitem; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.auction_auctionitem (
    id integer NOT NULL,
    ctime timestamp with time zone NOT NULL,
    mtime timestamp with time zone NOT NULL,
    name character varying(50) NOT NULL,
    long_desc text NOT NULL,
    sale_time timestamp with time zone,
    fair_market_value numeric(15,2) NOT NULL,
    is_purchased boolean NOT NULL,
    item_number integer NOT NULL,
    scheduled_sale_time timestamp with time zone,
    donor_display character varying(50),
    booth_id integer,
    donor_id integer,
    purchase_id integer,
    category character varying(8) NOT NULL,
    CONSTRAINT auction_auctionitem_item_number_check CHECK ((item_number >= 0))
);


ALTER TABLE public.auction_auctionitem OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_auctionitem_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.auction_auctionitem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auction_auctionitem_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_auctionitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.auction_auctionitem_id_seq OWNED BY public.auction_auctionitem.id;


--
-- Name: auction_auctionitemimage; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.auction_auctionitemimage (
    id integer NOT NULL,
    image character varying(100) NOT NULL,
    sort_order integer NOT NULL,
    item_id integer NOT NULL,
    CONSTRAINT auction_auctionitemimage_sort_order_check CHECK ((sort_order >= 0))
);


ALTER TABLE public.auction_auctionitemimage OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_auctionitemimage_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.auction_auctionitemimage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auction_auctionitemimage_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_auctionitemimage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.auction_auctionitemimage_id_seq OWNED BY public.auction_auctionitemimage.id;


--
-- Name: auction_booth; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.auction_booth (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL
);


ALTER TABLE public.auction_booth OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_booth_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.auction_booth_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auction_booth_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_booth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.auction_booth_id_seq OWNED BY public.auction_booth.id;


--
-- Name: auction_fee; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.auction_fee (
    id integer NOT NULL,
    ctime timestamp with time zone NOT NULL,
    mtime timestamp with time zone NOT NULL,
    amount numeric(15,2) NOT NULL,
    description character varying(100) NOT NULL,
    patron_id integer NOT NULL
);


ALTER TABLE public.auction_fee OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_fee_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.auction_fee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auction_fee_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_fee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.auction_fee_id_seq OWNED BY public.auction_fee.id;


--
-- Name: auction_patron; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.auction_patron (
    id integer NOT NULL,
    ctime timestamp with time zone NOT NULL,
    mtime timestamp with time zone NOT NULL,
    buyer_num character varying(8),
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    address_line1 character varying(50) NOT NULL,
    address_line2 character varying(50) NOT NULL,
    address_line3 character varying(50) NOT NULL,
    phone1 character varying(20) NOT NULL
);


ALTER TABLE public.auction_patron OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_patron_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.auction_patron_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auction_patron_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_patron_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.auction_patron_id_seq OWNED BY public.auction_patron.id;


--
-- Name: auction_payment; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.auction_payment (
    id integer NOT NULL,
    ctime timestamp with time zone NOT NULL,
    mtime timestamp with time zone NOT NULL,
    amount numeric(15,2) NOT NULL,
    method character varying(6) NOT NULL,
    transaction_time timestamp with time zone,
    note text NOT NULL,
    patron_id integer NOT NULL
);


ALTER TABLE public.auction_payment OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.auction_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auction_payment_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.auction_payment_id_seq OWNED BY public.auction_payment.id;


--
-- Name: auction_priceditem; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.auction_priceditem (
    id integer NOT NULL,
    ctime timestamp with time zone NOT NULL,
    mtime timestamp with time zone NOT NULL,
    name character varying(50) NOT NULL,
    long_desc text NOT NULL,
    sale_time timestamp with time zone,
    fair_market_value numeric(15,2) NOT NULL,
    is_purchased boolean NOT NULL,
    booth_id integer,
    purchase_id integer
);


ALTER TABLE public.auction_priceditem OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_priceditem_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.auction_priceditem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auction_priceditem_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_priceditem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.auction_priceditem_id_seq OWNED BY public.auction_priceditem.id;


--
-- Name: auction_purchase; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.auction_purchase (
    id integer NOT NULL,
    ctime timestamp with time zone NOT NULL,
    mtime timestamp with time zone NOT NULL,
    amount numeric(15,2) NOT NULL,
    transaction_time timestamp with time zone,
    patron_id integer NOT NULL
);


ALTER TABLE public.auction_purchase OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.auction_purchase_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auction_purchase_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_purchase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.auction_purchase_id_seq OWNED BY public.auction_purchase.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO ysoautxkgdqrjc;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO ysoautxkgdqrjc;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO ysoautxkgdqrjc;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO ysoautxkgdqrjc;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO ysoautxkgdqrjc;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO ysoautxkgdqrjc;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO ysoautxkgdqrjc;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO ysoautxkgdqrjc;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO ysoautxkgdqrjc;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO ysoautxkgdqrjc;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO ysoautxkgdqrjc;

--
-- Name: auction_auctionitem id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_auctionitem ALTER COLUMN id SET DEFAULT nextval('public.auction_auctionitem_id_seq'::regclass);


--
-- Name: auction_auctionitemimage id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_auctionitemimage ALTER COLUMN id SET DEFAULT nextval('public.auction_auctionitemimage_id_seq'::regclass);


--
-- Name: auction_booth id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_booth ALTER COLUMN id SET DEFAULT nextval('public.auction_booth_id_seq'::regclass);


--
-- Name: auction_fee id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_fee ALTER COLUMN id SET DEFAULT nextval('public.auction_fee_id_seq'::regclass);


--
-- Name: auction_patron id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_patron ALTER COLUMN id SET DEFAULT nextval('public.auction_patron_id_seq'::regclass);


--
-- Name: auction_payment id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_payment ALTER COLUMN id SET DEFAULT nextval('public.auction_payment_id_seq'::regclass);


--
-- Name: auction_priceditem id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_priceditem ALTER COLUMN id SET DEFAULT nextval('public.auction_priceditem_id_seq'::regclass);


--
-- Name: auction_purchase id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_purchase ALTER COLUMN id SET DEFAULT nextval('public.auction_purchase_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: auction_auctionitem; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.auction_auctionitem (id, ctime, mtime, name, long_desc, sale_time, fair_market_value, is_purchased, item_number, scheduled_sale_time, donor_display, booth_id, donor_id, purchase_id, category) FROM stdin;
33	2018-07-28 04:00:54.115008+00	2018-07-28 19:03:14.149925+00	Barn Quilt	24”x24”, painted wood, various colors Anonymous donor	2018-07-28 19:03:14.14965+00	0.00	t	1344	2018-08-28 18:44:00+00	\N	6	\N	635	MAIN
64	2018-07-28 15:36:22.819894+00	2018-07-28 20:09:45.752069+00	1 dozen cheese pockets (Boni Hofer) #1		2018-07-28 20:09:45.751767+00	0.00	t	1710	2018-08-28 20:10:00+00	\N	6	49	731	MAIN
15	2018-07-28 04:00:53.980286+00	2018-07-28 19:04:48.168019+00	Homemade Ice Cream	1 gallon, strawberry, pasteurized, home grown strawberries Donated by Larry Eisenbeis, Marion, SD	2018-07-28 19:04:48.167755+00	0.00	t	1308	2018-08-28 18:08:00+00	\N	6	208	638	MAIN
101	2018-07-28 20:19:23.663558+00	2018-07-28 20:19:39.761993+00	North cheese pockets 1 doz		2018-07-28 20:19:39.761718+00	0.00	t	1767	2018-08-28 19:34:00+00	\N	6	\N	743	MAIN
88	2018-07-28 19:08:14.182078+00	2018-07-28 19:08:55.848545+00	Quilting Supplies		2018-07-28 19:08:27+00	0.00	t	1754	2018-08-28 19:08:00+00	\N	6	\N	643	SILENT
106	2018-07-28 20:31:23.97769+00	2018-07-28 20:32:50.291453+00	Kitty package		2018-07-28 20:32:50.291189+00	0.00	t	1772	2018-08-28 19:44:00+00	\N	6	\N	763	MAIN
93	2018-07-28 19:13:06.676854+00	2018-07-28 19:13:06.677146+00	Sioux Ag Nation		\N	0.00	f	1759	2018-08-28 19:18:00+00	\N	6	\N	\N	SILENT
30	2018-07-28 04:00:54.086885+00	2018-07-28 19:15:56.117482+00	Jam Sampler	6 different fruit combinations, Made and donated by Arlyss Brockmueller, Freeman, SD	2018-07-28 18:58:01+00	0.00	t	1338	2018-08-28 18:38:00+00	\N	6	9	630	MAIN
32	2018-07-28 04:00:54.106356+00	2018-07-28 19:17:22.784479+00	Pair of Feather Pillows	Queen size, feathers washed and new ticking Donated by Joyce Hofer, Freeman,SD	2018-07-28 19:01:53+00	0.00	t	1342	2018-08-28 18:42:00+00	\N	6	53	634	MAIN
35	2018-07-28 04:00:54.148823+00	2018-07-28 19:18:24.263231+00	Wooden Bowl	4” x 10”, Walnut and Maple, varnished Made & donated by Peter Preheim, Marion, SD	2018-07-28 19:06:00+00	0.00	t	1348	2018-08-28 18:48:00+00	\N	6	103	641	MAIN
36	2018-07-28 04:00:54.159957+00	2018-07-28 19:18:58.270755+00	“Farmall” 460 Pedal Tractor	Donated by Larry Tschetter, Freeman, SD	2018-07-28 19:09:05+00	0.00	t	1350	2018-08-28 18:50:00+00	\N	6	123	644	MAIN
37	2018-07-28 04:00:54.191431+00	2018-07-28 19:20:18.972811+00	Amish Wall Hanging	45” x 36” Donated by Marilyn Wipf, Freeman, SD	2018-07-28 19:10:14+00	0.00	t	1352	2018-08-28 18:52:00+00	\N	6	201	646	MAIN
38	2018-07-28 04:00:54.199383+00	2018-07-28 19:22:18.637847+00	Toy Wagon	Wooden, Donated by JoAnn Stahl, Bridgewater, SD	2018-07-28 19:11:24+00	0.00	t	1354	2018-08-28 18:54:00+00	\N	6	116	650	MAIN
40	2018-07-28 04:00:54.226802+00	2018-07-28 19:24:36.410487+00	Antique Quilt	73” x 90”, pieced Hand made by Helena (John) Unruh when she was 96 years old Donated by Larry Tschetter, Freeman, SD	2018-07-28 19:18:57+00	0.00	t	1358	2018-08-28 18:58:00+00	\N	6	123	662	MAIN
34	2018-07-28 04:00:54.135329+00	2018-07-28 04:00:54.135405+00	Homemade Ice Cream	1 gallon, chocolate, pasteurized Donated by Larry Eisenbeis, Marion, SD	\N	0.00	f	1346	2018-08-28 18:46:00+00	\N	6	\N	\N	MAIN
2	2018-07-28 04:00:53.871767+00	2018-07-28 17:36:27.672453+00	Barn Quilt	48”x48”, painted wood, gold, brown, & purple Made locally, Anonymous donor	2018-07-28 17:36:27.671698+00	0.00	t	1236	2018-08-28 17:36:00+00	\N	6	\N	426	MAIN
4	2018-07-28 04:00:53.887681+00	2018-07-28 17:38:44.035837+00	Goliath Arc Lamp	Satin steel finish, adjustable natural linen shade New Donated by Et Cetera Shoppe, Freeman, SD	2018-07-28 17:38:44.035416+00	0.00	t	1240	2018-08-28 17:40:00+00	\N	6	200	431	MAIN
5	2018-07-28 04:00:53.896567+00	2018-07-28 17:39:53.936117+00	Table Runner	66” x 20”. beige Donated by Marilyn Wipf. Freeman, SD	2018-07-28 17:39:53.93556+00	0.00	t	1242	2018-08-28 17:42:00+00	\N	6	201	434	MAIN
7	2018-07-28 04:00:53.909521+00	2018-07-28 17:43:22.047284+00	Necktie Artwork	made from neckties from the Et Cetera Shoppe Unique piece, can be used as a throw or rug Made by Lerace Graber Donated by the Et Cetera Shoppe and Lerace Graber Freeman, SD	2018-07-28 17:43:21.992829+00	0.00	t	1246	2018-08-28 17:46:00+00	\N	6	200	439	MAIN
8	2018-07-28 04:00:53.91508+00	2018-07-28 17:46:43.257718+00	Modern Christmas Tree	25” x 60”, cedar, unfinished with stars Made and donated by Duane & Marlys Tieszen, Marion, SD	2018-07-28 17:46:43.25663+00	0.00	t	1248	2018-08-28 17:48:00+00	\N	6	119	451	MAIN
6	2018-07-28 04:00:53.902531+00	2018-07-28 17:47:49.660666+00	One Live Oak Tree	Donated by Lyle Preheim, Freeman, SD	2018-07-28 17:47:49.660386+00	0.00	t	1244	2018-08-28 17:44:00+00	\N	6	196	454	MAIN
9	2018-07-28 04:00:53.922345+00	2018-07-28 17:49:28.671642+00	“Star Garden” Quilt	45” x 60”, youth, pieced and hand quilted Made and donated by Kathleen Miller, Marion, SD	2018-07-28 17:49:28.671388+00	0.00	t	1250	2018-08-28 17:50:00+00	\N	6	203	461	MAIN
10	2018-07-28 04:00:53.935176+00	2018-07-28 17:51:12.317828+00	“Farm”  Wall Hanging	11” x 14”, varnished wood, burnt edge look Made by P. Graham Dunn, Kidron, OH Donated by Larry & Edie Tschetter, Freeman, SD	2018-07-28 17:51:12.31754+00	0.00	t	1252	2018-08-28 17:52:00+00	\N	6	123	464	MAIN
11	2018-07-28 04:00:53.948795+00	2018-07-28 17:54:04.413001+00	Mountain Man Nut & Fruit Basket	Mixed nut and fruit combinations Donated by Arlyss Brockmueller, Freeman, SD	2018-07-28 17:54:04.412732+00	0.00	t	1254	2018-08-28 17:54:00+00	\N	6	9	472	MAIN
12	2018-07-28 04:00:53.956317+00	2018-07-28 17:56:41.373404+00	Memory Box	13”x11”x7”, Walnut & Oak, varnished Made and donated by Duane & Marlys Teiszen, Marion, SD	2018-07-28 17:56:41.373166+00	0.00	t	1256	2018-08-28 17:56:00+00	\N	6	119	476	MAIN
13	2018-07-28 04:00:53.965127+00	2018-07-28 17:58:17.081137+00	“Cross Stitched” Quilt	79” x 95”, yellow & brown, embroidered, hand quilted.  Made by Nita Engbrecht & Rosella Schwartz Donated by Nita Engbrecht, Marion, SD	2018-07-28 17:58:17.080873+00	0.00	t	1258	2018-08-28 17:58:00+00	\N	6	205	478	MAIN
14	2018-07-28 04:00:53.972877+00	2018-07-28 18:15:06.243318+00	Blessing Bids	In honor of Gary Wieman and his many years of volunteering his services to the MCC Relief Sales	2018-07-28 18:15:06.243036+00	0.00	t	1300	2018-08-28 18:00:00+00	\N	6	\N	497	MAIN
16	2018-07-28 04:00:53.986027+00	2018-07-28 18:22:53.434149+00	Framed Wall Art	52” x 52”, from the Patrick Allen Gallery, Norcross, GA.  Donated by the Et Cetera Shoppe, Freeman, SD	2018-07-28 18:22:53.432921+00	0.00	t	1310	2018-08-28 18:10:00+00	\N	6	200	531	MAIN
17	2018-07-28 04:00:53.992155+00	2018-07-28 18:25:14.346087+00	“Lincoln Logs”	186 pieces in various sizes, hardwood, unfinished Made and donated by Peter Preheim, Marion, SD	2018-07-28 18:25:14.34581+00	0.00	t	1312	2018-08-28 18:12:00+00	\N	6	103	539	MAIN
19	2018-07-28 04:00:54.007921+00	2018-07-28 18:26:52.726174+00	Wooden Hay Rack with Bales	Made by William Stahl Donated by JoAnn Stahl, Bridgewater, SD	2018-07-28 18:26:52.725906+00	0.00	t	1316	2018-08-28 18:16:00+00	\N	6	116	544	MAIN
20	2018-07-28 04:00:54.01408+00	2018-07-28 18:32:10.738136+00	TV	36”, Vizio Digital Television Set Donated by the Et Cetera Shoppe, Freeman, SD	2018-07-28 18:32:10.737899+00	0.00	t	1318	2018-08-28 18:18:00+00	\N	6	200	559	MAIN
21	2018-07-28 04:00:54.024862+00	2018-07-28 18:34:10.925024+00	Amish Cedar Chest	Oak exterior , cedar interior, “Bless This House” on front Donated by Matthew Ingersoll by way of Phillip Eisenbeis, Marion, SD	2018-07-28 18:34:10.924665+00	0.00	t	1320	2018-08-28 18:20:00+00	\N	6	\N	571	MAIN
22	2018-07-28 04:00:54.032482+00	2018-07-28 18:37:46.087767+00	“Barn Quilt”	48” x48”, painted wood, various colors Anonymous donor 	2018-07-28 18:37:46.087493+00	0.00	t	1322	2018-08-28 18:22:00+00	\N	6	\N	580	MAIN
23	2018-07-28 04:00:54.040626+00	2018-07-28 18:41:44.135467+00	“A Pie a Month”	12 total, 1 every month for a year, local only Made & donated by the Freeman Network for Justice and Peace, Freeman, SD	2018-07-28 18:41:44.135258+00	0.00	t	1324	2018-08-28 18:24:00+00	\N	6	\N	590	MAIN
25	2018-07-28 04:00:54.052531+00	2018-07-28 18:46:48.628927+00	“John Deere” Socket Set	20 pieces in carrying case Donated by C & B Operation, Freeman, SD	2018-07-28 18:46:48.627754+00	0.00	t	1328	2018-08-28 18:28:00+00	\N	6	\N	610	MAIN
29	2018-07-28 04:00:54.079668+00	2018-07-28 18:56:39.734444+00	Unnamed Quilt	Youth size, pieced, unknown crafter Purchased at MCC Sale 4 years ago Anonymous donor	2018-07-28 18:56:39.734206+00	0.00	t	1336	2018-08-28 18:36:00+00	\N	6	\N	627	MAIN
24	2018-07-28 04:00:54.046523+00	2018-07-28 18:59:08.886737+00	Wooden Game Board	28” x28”, made by Vern Dvorak Donated by Edie Tschetter, Freeman, SD	2018-07-28 18:45:48+00	0.00	t	1326	2018-08-28 18:26:00+00	\N	6	123	607	MAIN
26	2018-07-28 04:00:54.058133+00	2018-07-28 18:59:37.756549+00	“Samsonite” Luggage	5 piece set Donated by Et Cetera Shoppe, Freeman, SD	2018-07-28 18:48:39+00	0.00	t	1330	2018-08-28 18:30:00+00	\N	6	200	614	MAIN
27	2018-07-28 04:00:54.063903+00	2018-07-28 19:02:26.455151+00	Oak Shelf with Mirrors	Made by Alvin Ortman Donated by Arlyss Ortman, Freeman, SD	2018-07-28 18:50:52+00	0.00	t	1332	2018-08-28 18:32:00+00	\N	6	356	618	MAIN
98	2018-07-28 20:07:02.055732+00	2018-07-28 20:08:39.264535+00	Lacey meal for 4		2018-07-28 20:08:39.264265+00	0.00	t	1764	2018-08-28 19:28:00+00	\N	6	\N	729	MAIN
53	2018-07-28 04:00:54.323197+00	2018-07-28 20:11:05.504722+00	“John Deere” 9400 T	Diecast toy tractor, collector edition Donated by Myles Brockmueller, Freeman, SD	2018-07-28 20:11:05.50204+00	0.00	t	1448	2018-08-28 19:48:00+00	\N	6	10	734	MAIN
74	2018-07-28 15:41:00.489442+00	2018-07-28 20:17:46.884301+00	Skyla's Rug Gray Stripes		2018-07-28 20:17:46.883972+00	0.00	t	1730	2018-08-28 20:30:00+00	\N	6	200	740	MAIN
58	2018-07-28 04:00:54.378063+00	2018-07-28 20:20:48.481054+00	2 Person Glider	58” x 27” x 38”, cedar, varnished Mate to previous item Made & donated by Duane & Marlys Tieszen, Marion, SD	2018-07-28 20:20:48.480788+00	0.00	t	1458	2018-08-28 19:58:00+00	\N	6	119	744	MAIN
57	2018-07-28 04:00:54.363379+00	2018-07-28 20:22:00.445944+00	Patio Side Table	20” x 24”x 23”, cedar, varnished Mate to the following item Made  & donated by Duane & Marlys Tieszen, Marion, SD	2018-07-28 20:22:00.44566+00	0.00	t	1456	2018-08-28 19:56:00+00	\N	6	119	745	MAIN
77	2018-07-28 15:42:25.936051+00	2018-07-28 20:23:36.024364+00	Skyla's Rug White		2018-07-28 20:23:36.024122+00	0.00	t	1736	2018-08-28 20:36:00+00	\N	6	200	746	MAIN
73	2018-07-28 15:40:19.86824+00	2018-07-28 20:24:36.099861+00	Skyla's Rug Rainbow		2018-07-28 20:24:36.099599+00	0.00	t	1728	2018-08-28 20:28:00+00	\N	6	200	749	MAIN
48	2018-07-28 04:00:54.291541+00	2018-07-28 04:00:54.291622+00	MCC Blessing Donations	If you want to contribute to the work of MCC but you do not want to take any more “stuff” home with you today, this is your opportunity to contribute.	\N	0.00	f	1432	2018-08-28 19:32:00+00	\N	6	\N	\N	MAIN
102	2018-07-28 20:26:24.945705+00	2018-07-28 20:26:41.055698+00	1 gal soup		2018-07-28 20:26:41.055473+00	0.00	t	1768	2018-08-28 19:36:00+00	\N	6	\N	754	MAIN
103	2018-07-28 20:27:21.828982+00	2018-07-28 20:27:36.219173+00	Shield hanging		2018-07-28 20:27:36.218054+00	0.00	t	1769	2018-08-28 19:38:00+00	\N	6	\N	755	MAIN
105	2018-07-28 20:29:40.040469+00	2018-07-28 20:30:34.819515+00	Racing game phone		2018-07-28 20:30:34.819217+00	0.00	t	1771	2018-08-28 19:42:00+00	\N	6	\N	759	MAIN
97	2018-07-28 20:03:16.312885+00	2018-07-28 21:57:48.228165+00	2 doz cheese pockets alma		2018-07-28 21:57:48.226388+00	0.00	t	1763	2018-08-28 19:26:00+00	\N	6	\N	785	MAIN
80	2018-07-28 15:44:19.388044+00	2018-07-28 19:04:13.680615+00	35th Schmeckfest plate and 2 cups		2018-07-28 19:04:13.680315+00	0.00	t	1742	2018-08-28 20:42:00+00	\N	6	53	636	MAIN
78	2018-07-28 15:42:47.827889+00	2018-07-28 19:12:17.499746+00	Skyla's Rug Blue and Green		2018-07-28 19:12:17.499523+00	0.00	t	1738	2018-08-28 20:38:00+00	\N	6	200	652	MAIN
59	2018-07-28 15:28:46.78641+00	2018-07-28 15:35:49.632095+00	1 dozen cheese pockets (Boni Hofer) #2		\N	0.00	f	1700	2018-08-28 20:00:00+00	\N	6	49	\N	MAIN
41	2018-07-28 04:00:54.234945+00	2018-07-28 19:20:31.16493+00	Vanilla	1 quart Donated by Fensel’s Greenhouse, Freeman, SD 	2018-07-28 19:20:31.16466+00	0.00	t	1400	2018-08-28 19:00:00+00	\N	6	\N	664	MAIN
61	2018-07-28 15:30:07.982001+00	2018-07-28 15:37:21.500658+00	1 dozen cheeze pockets (Alma Wollman) #2		\N	0.00	f	1704	2018-08-28 20:04:00+00	\N	6	192	\N	MAIN
42	2018-07-28 04:00:54.240727+00	2018-07-28 19:30:01.187689+00	“Pie Guys” Contest NIck	Local guys will present a pie that they made to be auctioned, with highest bidder having their choice of pie.  Participating are:  Nick Detweiler-Stoddard, Corey Miller, Nathan Schrag, and defending champion Steve Schmeichel	2018-07-28 19:30:01.186928+00	0.00	t	1402	2018-08-28 19:02:00+00	\N	6	\N	671	MAIN
85	2018-07-28 17:33:33.543948+00	2018-07-28 19:31:59.201972+00	Pie guys #2 Steve		2018-07-28 19:31:59.201706+00	0.00	t	1751	2018-08-28 19:02:00+00	\N	6	\N	672	MAIN
54	2018-07-28 04:00:54.338096+00	2018-07-28 19:33:37.566265+00	Wooden Bench Chest	35” x45” x 19, oak , cedar lined, stained & varnished Made by Ted Hofer, Bridgewater, SD Donated by Mike & Loretta Tschetter, Sioux Falls, SD	\N	0.00	f	1450	2018-08-28 19:50:00+00	\N	6	245	\N	MAIN
1	2018-07-28 04:00:53.864542+00	2018-07-28 17:34:38.349199+00	One Live Oak Tree	Donated by Lyle Preheim, Freeman, SD	2018-07-28 17:34:38.348922+00	0.00	t	1234	2018-08-28 17:34:00+00	\N	6	196	422	MAIN
81	2018-07-28 15:44:43.849077+00	2018-07-28 17:41:13.250449+00	1 quart honey #1		2018-07-28 17:41:13.242442+00	0.00	t	1744	2018-08-28 20:44:00+00	\N	6	19	436	MAIN
72	2018-07-28 15:40:00.431718+00	2018-07-28 17:44:44.049431+00	Skyla's Rug Orange		2018-07-28 17:44:44.049084+00	0.00	t	1726	2018-08-28 20:26:00+00	\N	6	200	443	MAIN
76	2018-07-28 15:42:11.448467+00	2018-07-28 17:52:19.130169+00	Skyla's Rug  Gray		2018-07-28 17:52:19.129895+00	0.00	t	1734	2018-08-28 20:34:00+00	\N	6	200	469	MAIN
63	2018-07-28 15:34:14.94752+00	2018-07-28 18:17:00.951678+00	MCC Hats #1		2018-07-28 18:17:00.951194+00	0.00	t	1708	2018-08-28 20:08:00+00	\N	6	\N	502	MAIN
65	2018-07-28 15:37:49.79566+00	2018-07-28 18:18:11.922852+00	MCC Hats #2		2018-07-28 18:18:11.922559+00	0.00	t	1711	2018-08-28 20:12:00+00	\N	6	\N	505	MAIN
66	2018-07-28 15:38:09.04447+00	2018-07-28 18:19:27.635542+00	MCC Hats #3		2018-07-28 18:19:27.635268+00	0.00	t	1714	2018-08-28 20:14:00+00	\N	6	\N	511	MAIN
67	2018-07-28 15:38:23.442215+00	2018-07-28 18:19:52.975934+00	MCC Hats #4		2018-07-28 18:19:52.974646+00	0.00	t	1716	2018-08-28 20:16:00+00	\N	6	\N	513	MAIN
68	2018-07-28 15:38:37.338132+00	2018-07-28 18:21:34.54876+00	MCC Hats #5		2018-07-28 18:21:34.548397+00	0.00	t	1718	2018-08-28 20:18:00+00	\N	6	\N	523	MAIN
70	2018-07-28 15:39:00.021164+00	2018-07-28 18:23:28.400306+00	MCC Hats #7		2018-07-28 18:23:28.399937+00	0.00	t	1722	2018-08-28 20:22:00+00	\N	6	\N	535	MAIN
69	2018-07-28 15:38:48.11394+00	2018-07-28 18:22:02.717665+00	MCC Hats #6		2018-07-28 18:22:02.717402+00	0.00	t	1720	2018-08-28 20:20:00+00	\N	6	\N	527	MAIN
83	2018-07-28 15:48:31.585878+00	2018-07-28 18:35:54.907853+00	Moses Glanzer rug black		2018-07-28 18:35:54.907587+00	0.00	t	1748	2018-08-28 20:48:00+00	\N	6	31	577	MAIN
71	2018-07-28 15:39:12.458672+00	2018-07-28 18:24:21.915542+00	MCC Hats #8 no logo		2018-07-28 18:24:21.915183+00	0.00	t	1724	2018-08-28 20:24:00+00	\N	6	\N	536	MAIN
75	2018-07-28 15:41:24.421581+00	2018-07-28 18:39:07.369608+00	Skyla's Rug Maroon & Black		2018-07-28 18:39:07.369344+00	0.00	t	1732	2018-08-28 20:32:00+00	\N	6	200	584	MAIN
84	2018-07-28 15:49:09.984117+00	2018-07-28 18:43:44.219283+00	Moses Glanzer rug blue stripe		2018-07-28 18:43:44.219091+00	0.00	t	1750	2018-08-28 20:50:00+00	\N	6	31	598	MAIN
43	2018-07-28 04:00:54.246723+00	2018-07-28 19:36:04.114141+00	Quilt Stand	Oak, stained & varnished, holds 3 quilts, locally made Donated by Mike & Loretta Tschetter, Sioux Falls, SD	2018-07-28 19:36:04.113727+00	0.00	t	1422	2018-08-28 19:22:00+00	\N	6	245	678	MAIN
44	2018-07-28 04:00:54.255594+00	2018-07-28 19:39:18.730588+00	“International Harvester” 1486	ERTL 1/16 Diecast Metal Replica Donated by Case-International Harvester Impl. Freeman, SD	2018-07-28 19:39:18.730329+00	0.00	t	1424	2018-08-28 19:24:00+00	\N	6	\N	680	MAIN
95	2018-07-28 19:38:05.829751+00	2018-07-28 19:39:47.449601+00	Kitchen sink quilt		2018-07-28 19:39:47.449049+00	0.00	t	1761	2018-08-28 19:22:00+00	\N	6	\N	681	MAIN
45	2018-07-28 04:00:54.269162+00	2018-07-28 19:40:16.24626+00	One Live Oak Tree	Donated by Lyle Preheim, Freeman, SD	2018-07-28 19:40:16.245579+00	0.00	t	1426	2018-08-28 19:26:00+00	\N	6	196	682	MAIN
46	2018-07-28 04:00:54.275985+00	2018-07-28 19:42:29.873029+00	Amish Buggy with Horse	Donated by JoAnn Stahl, Bridgewater, SD	2018-07-28 19:42:29.87278+00	0.00	t	1428	2018-08-28 19:28:00+00	\N	6	116	683	MAIN
62	2018-07-28 15:30:46.355823+00	2018-07-28 19:43:34.839536+00	2 plates and 2 mugs from "Minnekota Sale"		2018-07-28 19:43:34.839235+00	0.00	t	1706	2018-08-28 20:06:00+00	\N	6	\N	685	MAIN
96	2018-07-28 19:53:36.808657+00	2018-07-28 19:55:17.556418+00	Oak trees 2		2018-07-28 19:55:17.554888+00	0.00	t	1762	2018-08-28 19:24:00+00	\N	6	\N	702	MAIN
89	2018-07-28 19:09:16.735096+00	2018-07-28 19:56:15.524354+00	Prayer Shawl		2018-07-28 19:56:15.524105+00	0.00	t	1755	2018-08-28 19:10:00+00	\N	6	\N	705	SILENT
51	2018-07-28 04:00:54.308553+00	2018-07-28 20:02:36.711535+00	Toy Barn	28” x 30” x24”, wood, gently used Made by Ted Hofer, Bridgewater, SD Donated by Norma Hofer, Freeman, SD	2018-07-28 20:02:36.711238+00	0.00	t	1444	2018-08-28 19:44:00+00	\N	6	\N	717	MAIN
82	2018-07-28 15:47:54.863938+00	2018-07-28 20:02:08.462099+00	1 quart honey #2		2018-07-28 20:02:08.461804+00	0.00	t	1746	2018-08-28 20:46:00+00	\N	6	19	715	MAIN
60	2018-07-28 15:29:44.651796+00	2018-07-28 20:03:39.995578+00	1 dozen cheeze pockets (Alma Wollman) #1		2018-07-28 20:03:39.995253+00	0.00	t	1702	2018-08-28 20:02:00+00	\N	6	192	719	MAIN
55	2018-07-28 04:00:54.343584+00	2018-07-28 20:05:02.622153+00	Homemade Barn Wood Picture Frame	Your last name will be added; varnished Donated by Liz Graber, Freeman, SD	2018-07-28 20:05:02.621867+00	0.00	t	1452	2018-08-28 19:52:00+00	\N	6	322	721	MAIN
52	2018-07-28 04:00:54.317172+00	2018-07-28 20:06:06.301645+00	Table Runner	72” x 19”, green Donated by Marilyn Wipf, Freeman, SD	2018-07-28 20:06:06.301393+00	0.00	t	1446	2018-08-28 19:46:00+00	\N	6	201	725	MAIN
3	2018-07-28 04:00:53.877815+00	2018-07-28 17:37:43.055481+00	Mexican Vanilla	1 qt..  Donated by JoAnn & Lefty Ries, Freeman, SD	2018-07-28 17:37:43.05519+00	0.00	t	1238	2018-08-28 17:38:00+00	\N	6	107	430	MAIN
56	2018-07-28 04:00:54.352295+00	2018-07-28 20:13:12.327682+00	“Nova” Quilt	99” x 85”, design by Gudrun Erla, navy batik and white fabrics pieced by Monica Clem, Freeman, SD Machine quilted by Monica Hofer, Freeman,SD Donated by Hutterthal Mennonite Church, Freeman, SD	2018-07-28 20:13:12.327209+00	0.00	t	1454	2018-08-28 19:54:00+00	\N	6	\N	738	MAIN
18	2018-07-28 04:00:54.000251+00	2018-07-28 18:30:34.896422+00	“Ancestor” Quilt	68” x80”, twin, antique blocks in white and pastel blue Embroidered, pieced and hand quilted Made in 1932 by mostly women from the Bethany Mennonite Freeman, SD, was finished much later.  Donated by Larry Tschetter, Freeman, SD	2018-07-28 18:30:34.896186+00	0.00	t	1314	2018-08-28 18:14:00+00	\N	6	123	553	MAIN
28	2018-07-28 04:00:54.069657+00	2018-07-28 19:04:14.385037+00	Denim Rug	This is last rug made by our local rug crafter, Moses Glanzer Donated by the Et Cetera Shoppe, Freeman,SD	2018-07-28 18:54:43+00	0.00	t	1334	2018-08-28 18:34:00+00	\N	6	200	626	MAIN
99	2018-07-28 20:14:05.931924+00	2018-07-28 20:17:26.876666+00	Cheese pockets north church 3 doz		2018-07-28 20:17:26.876075+00	0.00	t	1765	2018-08-28 19:30:00+00	\N	6	\N	739	MAIN
90	2018-07-28 19:10:21.233904+00	2018-07-28 19:10:38.524214+00	A box of sunshine		2018-07-28 19:10:38.523943+00	0.00	t	1756	2018-08-28 19:12:00+00	\N	6	\N	647	SILENT
91	2018-07-28 19:11:24.916455+00	2018-07-28 19:11:46.903463+00	Lemonade		2018-07-28 19:11:46.9032+00	0.00	t	1757	2018-08-28 19:14:00+00	\N	6	\N	651	SILENT
92	2018-07-28 19:12:28.748231+00	2018-07-28 19:12:41.999+00	Breakfast Items		2018-07-28 19:12:41.998581+00	0.00	t	1758	2018-08-28 19:16:00+00	\N	6	\N	654	SILENT
100	2018-07-28 20:18:27.173886+00	2018-07-28 20:18:46.827168+00	North cheese pockets 1 doz		2018-07-28 20:18:46.826836+00	0.00	t	1766	2018-08-28 19:32:00+00	\N	6	\N	742	MAIN
94	2018-07-28 19:13:58.423855+00	2018-07-28 19:14:07.755001+00	Tea Time Breakfast		2018-07-28 19:14:07.753852+00	0.00	t	1760	2018-08-28 19:20:00+00	\N	6	\N	657	SILENT
79	2018-07-28 15:43:20.789256+00	2018-07-28 19:15:18.943545+00	Skyla's Rug Brown and Green		2018-07-28 19:15:18.943241+00	0.00	t	1740	2018-08-28 20:40:00+00	\N	6	200	661	MAIN
31	2018-07-28 04:00:54.098329+00	2018-07-28 19:16:47.35007+00	Wooden Tractor	18” x 10”, oak & walnut Made by Vern Huebert, Vern’s Crafts, Windom, MN Purchased at Minn-Kota MCC Sale about 15 years ago Donated by LeRoy Epp, Marion, SD	2018-07-28 18:59:45+00	0.00	t	1340	2018-08-28 18:40:00+00	\N	6	20	631	MAIN
39	2018-07-28 04:00:54.212423+00	2018-07-28 19:23:45.885245+00	“Cynthia” Storage Bench	50” x 31” X17.5”.New Donated by Et Cetera Shoppe, Freeman, SD	2018-07-28 19:14:26+00	0.00	t	1356	2018-08-28 18:56:00+00	\N	6	200	659	MAIN
104	2018-07-28 20:27:48.987739+00	2018-07-28 20:29:04.184732+00	2 paintings		2018-07-28 20:29:04.18449+00	0.00	t	1770	2018-08-28 19:40:00+00	\N	6	\N	756	MAIN
86	2018-07-28 17:45:30.219787+00	2018-07-28 19:33:59.944004+00	Pie guys #3 Cory		2018-07-28 19:33:59.942494+00	0.00	t	1752	2018-08-28 19:04:00+00	\N	6	\N	674	MAIN
107	2018-07-28 20:33:32.44038+00	2018-07-28 20:33:49.688953+00	Boy’s bike		2018-07-28 20:33:49.688689+00	0.00	t	1773	2018-08-28 19:46:00+00	\N	6	\N	767	MAIN
87	2018-07-28 17:46:05.322309+00	2018-07-28 19:34:58.044625+00	Pie guys #4 Nathan		2018-07-28 19:34:58.044342+00	0.00	t	1753	2018-08-28 19:06:00+00	\N	6	\N	675	MAIN
47	2018-07-28 04:00:54.285781+00	2018-07-28 19:45:11.235604+00	Teddy Bears	Mr & Mrs. Menno Simons, purchased years ago at MCC sale Donated by Alvina Hofer, Freeman, SD	2018-07-28 19:45:11.235319+00	0.00	t	1430	2018-08-28 19:30:00+00	\N	6	229	690	MAIN
50	2018-07-28 04:00:54.302979+00	2018-07-28 19:55:54.713368+00	“Chrysalis Star” Quilt	95” x 105”, tans & greens, pieced and hand quilted Pieced by Amish and quilted by Freeman Academy Aux.  Donated by Larry & Edie Tschetter, Freeman, SD	2018-07-28 19:55:54.713057+00	0.00	t	1442	2018-08-28 19:42:00+00	\N	6	123	703	MAIN
108	2018-07-28 20:34:21.837549+00	2018-07-28 20:34:56.428672+00	Vanilla Steve		2018-07-28 20:34:56.428388+00	0.00	t	1774	2018-08-28 19:48:00+00	\N	6	\N	768	MAIN
109	2018-07-28 20:35:39.958082+00	2018-07-28 20:36:20.316523+00	Basket		2018-07-28 20:36:20.316072+00	0.00	t	1775	2018-08-28 19:50:00+00	\N	6	\N	770	MAIN
110	2018-07-28 20:37:07.891414+00	2018-07-28 20:37:27.654628+00	North cheese pockets 2 doz		2018-07-28 20:37:27.654408+00	0.00	t	1776	2018-08-28 19:52:00+00	\N	6	\N	772	MAIN
111	2018-07-28 20:37:43.282502+00	2018-07-28 20:37:59.599508+00	NOrth cheese pockets 1 doz		2018-07-28 20:37:59.599221+00	0.00	t	1777	2018-08-28 19:54:00+00	\N	6	\N	773	MAIN
49	2018-07-28 04:00:54.297322+00	2018-07-28 20:05:27.979505+00	Wooden Eggs	12 grade A large eggs made of 12 different woods from Turner County in a display case.  Made & donated by Peter Preheim, Marion, SD	2018-07-28 20:05:27.979232+00	0.00	t	1440	2018-08-28 19:40:00+00	\N	6	103	\N	MAIN
\.


--
-- Data for Name: auction_auctionitemimage; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.auction_auctionitemimage (id, image, sort_order, item_id) FROM stdin;
\.


--
-- Data for Name: auction_booth; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.auction_booth (id, name, slug) FROM stdin;
1	Baked Goods	baked-goods
2	Produce	produce
3	Crafts	crafts
4	Etc Shoppe	etc-shoppe
5	Tickets	tickets
6	Auction	auction
\.


--
-- Data for Name: auction_fee; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.auction_fee (id, ctime, mtime, amount, description, patron_id) FROM stdin;
1	2018-07-28 17:11:13.670058+00	2018-07-28 17:11:13.670118+00	0.66	Credit Card Fee (3.0%)	285
2	2018-07-28 17:23:51.350307+00	2018-07-28 17:23:51.350362+00	1.50	Credit Card Fee (3.0%)	257
3	2018-07-28 17:28:17.793196+00	2018-07-28 17:28:17.793324+00	0.42	Credit Card Fee (3.0%)	250
4	2018-07-28 17:28:49.512641+00	2018-07-28 17:28:49.512692+00	1.71	Credit Card Fee (3.0%)	255
5	2018-07-28 17:29:45.120372+00	2018-07-28 17:29:45.120441+00	0.30	Credit Card Fee (3.0%)	159
6	2018-07-28 17:52:17.636244+00	2018-07-28 17:52:17.63631+00	3.30	Credit Card Fee (3.0%)	245
7	2018-07-28 18:26:45.556308+00	2018-07-28 18:26:45.556366+00	0.38	Credit Card Fee (3.0%)	309
8	2018-07-28 18:37:15.340584+00	2018-07-28 18:37:15.340687+00	3.45	Credit Card Fee (3.0%)	253
9	2018-07-28 18:43:08.228459+00	2018-07-28 18:43:08.228509+00	0.99	Credit Card Fee (3.0%)	113
10	2018-07-28 19:07:52.917715+00	2018-07-28 19:07:52.917782+00	2.16	Credit Card Fee (3.0%)	140
11	2018-07-28 19:27:15.775088+00	2018-07-28 19:27:15.775147+00	1.38	Credit Card Fee (3.0%)	32
12	2018-07-28 19:38:38.009078+00	2018-07-28 19:38:38.009143+00	1.05	Credit Card Fee (3.0%)	246
13	2018-07-28 19:52:11.106919+00	2018-07-28 19:52:11.107202+00	0.24	Credit Card Fee (3.0%)	334
14	2018-07-28 19:53:11.984091+00	2018-07-28 19:53:11.984178+00	3.66	Credit Card Fee (3.0%)	20
15	2018-07-28 19:54:24.269075+00	2018-07-28 19:54:24.269125+00	9.66	Credit Card Fee (3.0%)	229
16	2018-07-28 19:57:43.816904+00	2018-07-28 19:57:43.816966+00	8.42	Credit Card Fee (3.0%)	174
17	2018-07-28 20:03:43.701809+00	2018-07-28 20:03:43.701869+00	0.48	Credit Card Fee (3.0%)	222
18	2018-07-28 20:05:14.95214+00	2018-07-28 20:05:14.952203+00	0.66	Credit Card Fee (3.0%)	343
19	2018-07-28 20:05:54.166726+00	2018-07-28 20:05:54.16678+00	4.62	Credit Card Fee (3.0%)	273
20	2018-07-28 20:08:15.657357+00	2018-07-28 20:08:15.657413+00	3.56	Credit Card Fee (3.0%)	220
21	2018-07-28 20:09:11.604415+00	2018-07-28 20:09:11.604475+00	81.50	Credit Card Fee (3.0%)	4
22	2018-07-28 20:10:10.506203+00	2018-07-28 20:10:10.506249+00	0.75	Credit Card Fee (3.0%)	327
23	2018-07-28 20:11:04.886832+00	2018-07-28 20:11:04.886889+00	0.36	Credit Card Fee (3.0%)	226
24	2018-07-28 20:13:18.000567+00	2018-07-28 20:13:18.000633+00	0.90	Credit Card Fee (3.0%)	70
25	2018-07-28 20:15:01.791051+00	2018-07-28 20:15:01.79112+00	3.45	Credit Card Fee (3.0%)	158
26	2018-07-28 20:15:33.298071+00	2018-07-28 20:15:33.298138+00	9.84	Credit Card Fee (3.0%)	96
27	2018-07-28 20:15:48.31523+00	2018-07-28 20:15:48.315284+00	2.16	Credit Card Fee (3.0%)	156
28	2018-07-28 20:18:18.040699+00	2018-07-28 20:18:18.040764+00	2.73	Credit Card Fee (3.0%)	144
29	2018-07-28 20:22:31.125739+00	2018-07-28 20:22:31.125798+00	3.81	Credit Card Fee (3.0%)	13
30	2018-07-28 20:25:40.16098+00	2018-07-28 20:25:40.161036+00	4.65	Credit Card Fee (3.0%)	230
31	2018-07-28 20:28:31.411861+00	2018-07-28 20:28:31.411926+00	16.08	Credit Card Fee (3.0%)	38
32	2018-07-28 20:29:56.671791+00	2018-07-28 20:29:56.671853+00	1.50	Credit Card Fee (3.0%)	215
33	2018-07-28 20:40:02.351121+00	2018-07-28 20:40:02.351307+00	19.95	Credit Card Fee (3.0%)	260
34	2018-07-28 20:42:10.302464+00	2018-07-28 20:42:10.302524+00	1.20	Credit Card Fee (3.0%)	178
35	2018-07-28 20:46:14.542897+00	2018-07-28 20:46:14.542951+00	1.45	Credit Card Fee (3.0%)	95
36	2018-07-28 20:46:33.141539+00	2018-07-28 20:46:33.141597+00	0.48	Credit Card Fee (3.0%)	37
37	2018-07-28 20:48:10.162921+00	2018-07-28 20:48:10.16298+00	1.65	Credit Card Fee (3.0%)	354
38	2018-07-28 20:48:49.366115+00	2018-07-28 20:48:49.36617+00	4.02	Credit Card Fee (3.0%)	193
39	2018-07-28 20:49:22.005045+00	2018-07-28 20:49:22.005106+00	0.33	Credit Card Fee (3.0%)	195
40	2018-07-28 20:50:22.868723+00	2018-07-28 20:50:22.868785+00	2.13	Credit Card Fee (3.0%)	355
41	2018-07-28 20:51:34.152075+00	2018-07-28 20:51:34.152136+00	0.97	Credit Card Fee (3.0%)	345
42	2018-07-28 20:53:58.668294+00	2018-07-28 20:53:58.668353+00	16.91	Credit Card Fee (3.0%)	29
43	2018-07-28 20:55:23.574558+00	2018-07-28 20:55:23.574614+00	10.86	Credit Card Fee (3.0%)	81
44	2018-07-28 20:56:21.538914+00	2018-07-28 20:56:21.538972+00	6.36	Credit Card Fee (3.0%)	1
45	2018-07-28 20:58:02.911084+00	2018-07-28 20:58:02.911136+00	20.85	Credit Card Fee (3.0%)	62
46	2018-07-28 20:59:39.587418+00	2018-07-28 20:59:39.587478+00	21.75	Credit Card Fee (3.0%)	133
47	2018-07-28 21:00:48.772789+00	2018-07-28 21:00:48.772849+00	0.57	Credit Card Fee (3.0%)	333
48	2018-07-28 21:02:12.080779+00	2018-07-28 21:02:12.08084+00	2.85	Credit Card Fee (3.0%)	289
49	2018-07-28 21:08:17.876398+00	2018-07-28 21:08:17.876458+00	0.60	Credit Card Fee (3.0%)	326
50	2018-07-28 21:09:09.918061+00	2018-07-28 21:09:09.918115+00	2.27	Credit Card Fee (3.0%)	143
\.


--
-- Data for Name: auction_patron; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.auction_patron (id, ctime, mtime, buyer_num, first_name, last_name, email, address_line1, address_line2, address_line3, phone1) FROM stdin;
5	2018-07-28 04:01:05.240598+00	2018-07-28 04:01:05.24065+00	\N	Geraldine	Berg	egberg@gwtc.net				605-648-3507
6	2018-07-28 04:01:05.24571+00	2018-07-28 04:01:05.245751+00	\N	Vicki	Biggerstaff	vickibiggerstaff@gmail.com	1109 W 13th St	Sioux Falls, SD	57104	605-367-8996
7	2018-07-28 04:01:05.250753+00	2018-07-28 04:01:05.25083+00	\N	Judy	Bittner	bittnerjz@yahoo.com	530 N Menlo Ave	Sioux Falls, SD		605-339-2196
10	2018-07-28 04:01:05.270276+00	2018-07-28 04:01:05.270353+00	\N	Myles	Brockmueller		27372 437th Ave	Freeman, SD	57029	605-925-4881
15	2018-07-28 04:01:05.318801+00	2018-07-28 04:01:05.31885+00	\N	Anita	Eisenbeis	ateisen@gwtc.net	44373 280th St	Marion, SD	57043	605-925-4661
16	2018-07-28 04:01:05.333735+00	2018-07-28 04:01:05.3338+00	\N	Chris & Carol	Eisenbeis	ceisenbeis @iw.net	44566 285th St	Hurley, SD	57036	605-925-4619
17	2018-07-28 04:01:05.338902+00	2018-07-28 04:01:05.338962+00	\N	Philip	Eisenbeis	philipeisenbeis@gmail.com	44438 280th St	Marion, SD	57043	312-809-6280
18	2018-07-28 04:01:05.344083+00	2018-07-28 04:01:05.344144+00	\N	Ben H.	Engbrecht	bvengbrecht@sio.midco.net	3408 W Ralph Rogers Rd	Sioux Falls, SD	57108	605-929-7938
19	2018-07-28 04:01:05.353671+00	2018-07-28 04:01:05.353743+00	\N	Robert	Engbrecht		26959 443rd Ave	Marion, SD	57043	605-648-3017
21	2018-07-28 04:01:05.374236+00	2018-07-28 04:01:05.374305+00	\N	Vivian	Epp	vepp208@gmail.com	1480 Applewood Ct #311	Roseville, MN		612-819-6430
22	2018-07-28 04:01:05.384987+00	2018-07-28 04:01:05.385033+00	\N	Lynette	Erickson	lmwe57@gmail.com	812 Grandview Cir	Yankton, SD 	57078	605-661-1806
23	2018-07-28 04:01:05.394997+00	2018-07-28 04:01:05.395096+00	\N	Terry	Eyler	noaircau@msn.com	9923 S 170th Circle	Omaha, NE	68136	402-895-0386
31	2018-07-28 04:01:05.491553+00	2018-07-28 04:01:05.49162+00	\N	Moses	Glanzer			Freeman, SD	57029	
33	2018-07-28 04:01:05.514857+00	2018-07-28 04:01:05.514928+00	\N	Alice	Graber			Freeman, SD	57029	605-925-4648
41	2018-07-28 04:01:05.614034+00	2018-07-28 04:01:05.614103+00	\N	Rachel	Graber		44797 281st St	Parker, SD	57043	605-925-4688
43	2018-07-28 04:01:05.634741+00	2018-07-28 04:01:05.634792+00	\N	Tim	Graber	timjgraber@gmail.com	44750 282nd St	Hurley, SD	57036	605-660-0152
44	2018-07-28 04:01:05.645184+00	2018-07-28 04:01:05.645253+00	\N	Elmer	Gross		306 N Dewald #18	Freeman, SD	57029	605-925-7442
46	2018-07-28 04:01:05.662786+00	2018-07-28 04:01:05.662862+00	\N	Laurie	Hamm	lauries88ivories@hotmail.com	4378 Illinois Ave	Huron, SD	57350	605-354-7654
47	2018-07-28 04:01:05.672251+00	2018-07-28 04:01:05.672315+00	\N	Steve	Heeg		28111 441st	Freeman, SD	57029	972-746-6865
48	2018-07-28 04:01:05.694162+00	2018-07-28 04:01:05.694377+00	\N	Marlene	Herman	meherman1@goldenwest.net	521 E 3rd, Box 361	Freeman, SD	57029	605-925-7191
49	2018-07-28 04:01:05.700966+00	2018-07-28 04:01:05.70102+00	\N	Boni	Hofer		P.O. Box 149	Freeman, SD	57029	605-925-7099
50	2018-07-28 04:01:05.71117+00	2018-07-28 04:01:05.711248+00	\N	Chantel	Hofer		1300 W 17th	Yankton, SD	57078	605-689-0308
51	2018-07-28 04:01:05.72124+00	2018-07-28 04:01:05.721304+00	\N	Cindy	Hofer		P.O. Box 399	Freeman, SD	57029	605-925-4446
52	2018-07-28 04:01:05.730893+00	2018-07-28 04:01:05.730966+00	\N	Genevieve	Hofer		27816 443rd Ave	Freeman, SD	57029	605-925-7498
53	2018-07-28 04:01:05.741441+00	2018-07-28 04:01:05.742072+00	\N	Joyce	Hofer		P.O. Box 548	Freeman, SD	57029	605-925-7988
54	2018-07-28 04:01:05.748292+00	2018-07-28 04:01:05.748387+00	\N	K.C.	Hofer	jmsmith@ellijay.com	44540 272nd St	Marion, SD	57043	605-660-7719
57	2018-07-28 04:01:05.776044+00	2018-07-28 04:01:05.776106+00	\N	Monica	Hofer	monicakhofer@gmail.com	27304 436th Ave	Freeman, SD	57029	605-421-0366
61	2018-07-28 04:01:05.801291+00	2018-07-28 04:01:05.801346+00	\N	Vernon J.	Hofer		1027 S Walnut St	Freeman, SD	57029	
42	2018-07-28 04:01:05.627649+00	2018-07-28 13:14:51.805771+00	112	Rita F.	Graber		600 S Dewald #10	Freeman, SD	57029	605-201-6590
1	2018-07-28 04:01:05.202899+00	2018-07-28 13:15:21.70757+00	115	Betty	Albrecht		44565 277th St	Marion, SD	57043	605-925-4659
36	2018-07-28 04:01:05.556577+00	2018-07-28 13:20:50.162261+00	119	Gary	Graber		904 E South County Rd	Freeman, SD	57029	605-925-4045
58	2018-07-28 04:01:05.78694+00	2018-07-28 13:31:45.383339+00	141	Norman/Darlene	Hofer		43439 279th St	Freeman, SD	57029	605-925-7466
25	2018-07-28 04:01:05.40689+00	2018-07-28 13:32:38.731192+00	121	Gerald	Friesen		Box 362	Henderson, NE	68371	402-723-4635
8	2018-07-28 04:01:05.256569+00	2018-07-28 13:38:59.012036+00	124	Joan	Brauen	bjbrauen@msn.com	6954 105th Ave NE	Foley, MN	56329	320-968-7761
27	2018-07-28 04:01:05.427147+00	2018-07-28 13:39:59.406884+00	104	Cheryle	Gering		P.O. Box 66	Freeman, SD	57029	605-925-4667
39	2018-07-28 04:01:05.595683+00	2018-07-28 13:41:39.627637+00	103	LaVerne	Graber	ljg@gwtc.net	744 S Dewald St	Freeman, SD	57029	605-925-7782
60	2018-07-28 04:01:05.796356+00	2018-07-28 13:41:58.174372+00	126	Twyla	Hofer		P.O. Box 688	Freeman, SD	57029	605-925-7550
12	2018-07-28 04:01:05.285613+00	2018-07-28 13:54:44.591788+00	130	Brad	Carlson		28218 448th Ave	Hurley, SD	57036	605-648-3910
38	2018-07-28 04:01:05.584115+00	2018-07-28 13:59:52.335781+00	135	Johnny J.	Graber		P.O. Box 336	Freeman, SD	57029	605-925-7571
24	2018-07-28 04:01:05.399652+00	2018-07-28 14:03:38.464933+00	137	Nancy	Fischer	njgfischer@gmail.com	7525 Hamann Meadows Pl	Lincoln, NE	68506	402-219-1831
9	2018-07-28 04:01:05.261234+00	2018-07-28 14:05:00.23416+00	145	Arlyss	Brockmueller		44322 US 18	Freeman, SD	57029	605-327-3458
34	2018-07-28 04:01:05.526939+00	2018-07-28 14:12:36.006428+00	171	Clara	Graber	clara_graber@goldenwest.net	P.O. Box 164	Freeman, SD	57029	605-925-7131
14	2018-07-28 04:01:05.306883+00	2018-07-28 14:12:40.518907+00	157	Lorraine	Deckert	deckertl@goldenwest.net	Box 636	Freeman, SD	57029	605-925-7425
26	2018-07-28 04:01:05.418243+00	2018-07-28 14:18:56.79292+00	179	Vivian	Friesen		P.O. Box 29	Freeman, SD	57029	605-925-7780
29	2018-07-28 04:01:05.450818+00	2018-07-28 14:22:23.667452+00	4	Marcella	Glanzer		P.O. Box 640	Freeman, SD	57029	605-925-4843
2	2018-07-28 04:01:05.210976+00	2018-07-28 14:42:50.060853+00	190	Michelle	Armster	michellearmster@mcc.org	2132 S Ridgewood Dr	Wichita, KS	67218	717-572-2167
45	2018-07-28 04:01:05.654702+00	2018-07-28 14:46:39.977412+00	191	Nancy	Halvorson	n.halvorson@hotmail.com	45116 293rd St	Viborg, SD	57070	605-360-4088
4	2018-07-28 04:01:05.230767+00	2018-07-28 15:04:03.696012+00	189	Clellan	Becker		800 N Broadway	Marion, SD	57043	605-648-3487
55	2018-07-28 04:01:05.758693+00	2018-07-28 15:06:51.110931+00	201	Karol J.	Hofer		44076 273rd St	Marion, SD	57043	605-648-3290
56	2018-07-28 04:01:05.770346+00	2018-07-28 15:17:03.315612+00	209	LeRoy D.	Hofer		120 W 7th St	Freeman, SD	57029	605-925-7204
40	2018-07-28 04:01:05.604211+00	2018-07-28 15:24:38.263293+00	105	Joey/Patti	Graber	jpg@goldenwest.net	27725 441st Ave	Marion, SD	57043	605-595-5812
32	2018-07-28 04:01:05.502877+00	2018-07-28 15:51:56.473123+00	231	Phil	Glanzer	glanzerpj@gmail.com	3422 S Harmony Dr	Sioux Falls, SD	57110	605-370-4337
13	2018-07-28 04:01:05.292927+00	2018-07-28 16:02:46.410601+00	255	Monica	Clem	monicasclem@yahoo.com	P.O. Box 493	Freeman, SD	57029	605-595-3543
37	2018-07-28 04:01:05.568076+00	2018-07-28 16:03:53.395396+00	9	Gertie	Graber		609 S Walnut	Freeman, SD	57029	605-925-7750
28	2018-07-28 04:01:05.438313+00	2018-07-28 16:10:19.49115+00	240	Marian	Gering		609 S Walnut	Freeman, SD	57029	605-925-7330
30	2018-07-28 04:01:05.480359+00	2018-07-28 16:36:52.828004+00	284	Mark	Glanzer		44205 261 St	Canistota, SD	57012	605-296-3358
35	2018-07-28 04:01:05.54299+00	2018-07-28 16:38:18.135536+00	293	Daniel	Graber	graber.dan@gmail.com	27877 443rd Ave	Freeman, SD	57029	605-929-0461
20	2018-07-28 04:01:05.367177+00	2018-07-28 16:56:14.980762+00	215	Janette	Epp	ljepp@hotmail.com	27740 444th Ave	Marion, SD	57043	605-925-7635
3	2018-07-28 04:01:05.219459+00	2018-07-28 17:07:34.752983+00	287	Paul	Balzer		44733 284th St	Hurley, SD	57036	605-648-3822
11	2018-07-28 04:01:05.280703+00	2018-07-28 17:46:23.319635+00	351	Jeri	Butkus	john_butkus@hotmail.com	28317 443rd Ave	Freeman, SD	57029	605-925-4437
63	2018-07-28 04:01:05.817169+00	2018-07-28 04:01:05.817268+00	\N	Audrey	Ihnen	walkinltimtoo@gmail.com	2308 Nicasio Pl	Leand, TX	78641	512-789-0770
64	2018-07-28 04:01:05.823535+00	2018-07-28 04:01:05.823587+00	\N	Paul	Kaldjian	megs1528@yahoo.com	1528 Fenwick Ave	Eau Claire, WI	54701	715-833-8484
65	2018-07-28 04:01:05.828822+00	2018-07-28 04:01:05.828959+00	\N	Chris	Kauffman	luv2spa4U@gmail.com	27362 630th St	Manson, IA	50563	712-469-3099
66	2018-07-28 04:01:05.834298+00	2018-07-28 04:01:05.834404+00	\N	Arnetta	Kaufman		1811 Chateau Ave	Fonda, IA	50540	712-288-6674
67	2018-07-28 04:01:05.845054+00	2018-07-28 04:01:05.845127+00	\N	Jon	Kaufman		756 S Cherry St	Freeman, SD	57029	605-630-4045
68	2018-07-28 04:01:05.858225+00	2018-07-28 04:01:05.860022+00	\N	Kenton	Kaufman	kgkaufman2@yahoo.com	10435 S Highland Circle	Olathe, KS	66061	913-221-5186
69	2018-07-28 04:01:05.871048+00	2018-07-28 04:01:05.871101+00	\N	Kevin	Kaufman	kevinkauf@gmail.com	43 Helen	Milford, IA	51351	712-338-2530
71	2018-07-28 04:01:05.893535+00	2018-07-28 04:01:05.89361+00	\N	Marlan	Kaufman		45134 Quail Dr	Canistota, SD	57012	605-296-3098
73	2018-07-28 04:01:05.911721+00	2018-07-28 04:01:05.911783+00	\N	Rose	Kelly		P.O. Box 427	Freeman, SD	57029	605-941-5132
74	2018-07-28 04:01:05.92195+00	2018-07-28 04:01:05.922392+00	\N	Zach	Kempf	zach_141516@hotmail.com	7852 S Townsley Ave, #7	Sioux Falls, SD	57108	419-591-6091
75	2018-07-28 04:01:05.927681+00	2018-07-28 04:01:05.927748+00	\N	Ken/Tonda	Kirton		620 W Wynken Dr	Freeman, SD	57029	605-925-4725
76	2018-07-28 04:01:05.933054+00	2018-07-28 04:01:05.933124+00	\N	Phyllis	Knittel		P.O. Box 22	Freeman, SD	57029	605-925-4560
77	2018-07-28 04:01:05.940876+00	2018-07-28 04:01:05.940984+00	\N	Shirley	Knodel	sknodel@goldenwest.net	Box 337	Freeman, SD	57029	605-925-4113
78	2018-07-28 04:01:05.94707+00	2018-07-28 04:01:05.94714+00	\N	Linda	Kotzea	lkotzea@gwtc.net	425 S Walnut	Freeman, SD	57029	605-925-7002
79	2018-07-28 04:01:05.953309+00	2018-07-28 04:01:05.953377+00	\N	LaRuth	Kramer	wkramer@gwtc.net	44147 280th St	Freeman, SD	57029	605-366-9632
82	2018-07-28 04:01:05.976787+00	2018-07-28 04:01:05.976896+00	\N	Dennis	Lehmann		27855 441st Ave	Freeman, SD	57026	605-925-4081
84	2018-07-28 04:01:05.988733+00	2018-07-28 04:01:05.988839+00	\N	Donna	Lehmann	dlehmann@gwtc.net	1020 S Dewald	Freeman, SD	57029	605-214-6041
85	2018-07-28 04:01:05.994312+00	2018-07-28 04:01:05.994381+00	\N	Delon & Joretta	Martens	delonmartens@gmail.com	10 Stadium	Haven, KS	67543	620-960-9471
86	2018-07-28 04:01:05.999727+00	2018-07-28 04:01:05.999827+00	\N	David	Mendel	dsm6205@yahoo.com	125 W Doral Ct	Sioux Falls, SD	57108	605-338-3583
87	2018-07-28 04:01:06.00628+00	2018-07-28 04:01:06.006334+00	\N	Janice	Mendel		609 S Walnut St	Freeman, SD	57029	605-925-4680
88	2018-07-28 04:01:06.011188+00	2018-07-28 04:01:06.011243+00	\N	Stephen	Mendel		27507 436th Ave	Freeman, SD	57029	605-925-4291
89	2018-07-28 04:01:06.01881+00	2018-07-28 04:01:06.018877+00	\N	Corey	Miller	corey.miller@gwtc.net	27944 443rd	Freeman, SD	57029	319-930-7320
94	2018-07-28 04:01:06.044864+00	2018-07-28 04:01:06.044933+00	\N	Don	Orth		421 Green Meadow Lane	Freeman, SD	57029	605-464-7039
97	2018-07-28 04:01:06.060917+00	2018-07-28 04:01:06.060981+00	\N	Mavis	Ortman		28223 446th Ave	Marion, SD	57043	605-925-4693
100	2018-07-28 04:01:06.079969+00	2018-07-28 04:01:06.080013+00	\N	Nichelle	Palmateer	nichellepalm@gmail.com	4714 NE Meriden Rd	Topeka, KS	66617	785-249-5067
102	2018-07-28 04:01:06.091007+00	2018-07-28 04:01:06.091062+00	\N	LaVonne	Preheim		421 S Cherry, Box 625	Freeman, SD	57029	605-925-4951
104	2018-07-28 04:01:06.104889+00	2018-07-28 04:01:06.104949+00	\N	Steve	Priest	ethical@aol.com	1000 E Jenny Cir	Sioux Falls, SD	57108	312-799-9586
107	2018-07-28 04:01:06.130673+00	2018-07-28 04:01:06.130725+00	\N	Joann	Ries		Box 429	Freeman, SD	57029	605-254-5408
109	2018-07-28 04:01:06.145011+00	2018-07-28 04:01:06.14506+00	\N	Bryan	Saner	bsanerb@gmail.com	4870 N Hermitage	Chicago, IL	60640	773-412-9268
110	2018-07-28 04:01:06.150599+00	2018-07-28 04:01:06.150645+00	\N	John	Schrag		420 E 4th St	Freeman, SD	57029	813-469-8485
111	2018-07-28 04:01:06.155497+00	2018-07-28 04:01:06.155584+00	\N	Linda	Schrag	dlschrag@svtv.com	44133 283rd St	Freeman, SD	57029	605-925-7482
112	2018-07-28 04:01:06.163932+00	2018-07-28 04:01:06.163997+00	\N	Charlotte	Schreur		719 20th St	Hawarden, IA	51023	712-212-1841
114	2018-07-28 04:01:06.176904+00	2018-07-28 04:01:06.177003+00	\N	Marcia	Schrock		817 S Albert St	Freeman, SD	57029	605-925-4791
121	2018-07-28 04:01:06.227197+00	2018-07-28 04:01:06.227247+00	\N	Gary	Tschetter	gltschetter@hotmail.com	Box 326	Freeman, SD	57029	605-660-9472
118	2018-07-28 04:01:06.21111+00	2018-07-28 13:07:55.016654+00	106	Janver	Stucky	jstucky@gwtc.net	211 E 4th St, Box 525	Freeman, SD	57029	605-925-7021
83	2018-07-28 04:01:05.983206+00	2018-07-28 13:19:50.025868+00	117	Donavon	Lehmann		44943 282nd St	Hurley, SD	57036	605-660-4772
98	2018-07-28 04:01:06.065599+00	2018-07-28 13:56:56.94214+00	1	Paul	Ortman	paul.ortman@gmail.com	44529 280th St	Marion, SD	57043	574-202-2631
103	2018-07-28 04:01:06.097898+00	2018-07-28 13:59:22.557638+00	134	Peter	Preheim	lpreheim@gwtc.net	Box 25	Marion, SD	57043	605-648-3254
115	2018-07-28 04:01:06.182012+00	2018-07-28 14:07:29.070408+00	140	Rosella	Schwartz	jrs@gwtc.net	402 Tieszen Drive	Marion, SD	57043	605-648-3705
99	2018-07-28 04:01:06.074718+00	2018-07-28 14:13:37.701479+00	172	Joyce	Palmateer	joyce@joycesoven.com	4714 NE Meriden Rd	Topeka, KS	66617	785-207-0711
70	2018-07-28 04:01:05.877192+00	2018-07-28 14:15:35.494403+00	174	Marie	Kaufman		605 E 8th St	Freeman, SD	57029	605-925-4334
116	2018-07-28 04:01:06.195121+00	2018-07-28 14:15:54.828565+00	175	Joann	Stahl		511 N Cherry, Box 20	Bridgewater, SD	57319	605-729-2459
93	2018-07-28 04:01:06.039192+00	2018-07-28 14:19:28.87408+00	180	Ray	Neufeld		44760 283rd St	Hurley, SD	57036	605-648-3734
96	2018-07-28 04:01:06.054807+00	2018-07-28 14:23:39.655592+00	164	Janelle/Orville	Ortman	ojortman@gmail.com	28033 445th Ave	Marion, SD	57043	605-925-7437
101	2018-07-28 04:01:06.085253+00	2018-07-28 14:47:48.717848+00	170	Carolyn	Preheim		28533 441st Ave	Freeman, SD	57029	605-327-3462
92	2018-07-28 04:01:06.032966+00	2018-07-28 14:53:30.695615+00	185	Crystal Gering	Nelson	mscgn@hotmail.com	29193 451st Ave	Viborg, SD	57070	605-661-4807
119	2018-07-28 04:01:06.216345+00	2018-07-28 15:11:52.77443+00	200	Duane	Tieszen		Box 431	Marion, SD	57043	605-648-3226
117	2018-07-28 04:01:06.204995+00	2018-07-28 15:41:16.423779+00	243	Judy	Stahl		27908 435th Ave	Freeman, SD	57029	605-925-7463
95	2018-07-28 04:01:06.050226+00	2018-07-28 15:46:41.851647+00	229	Gwen	Ortman		44574 280th St	Marion, SD	57043	605-925-4955
120	2018-07-28 04:01:06.222597+00	2018-07-28 15:46:46.647834+00	245	Karl and Bonita	Tieszen	tieszenkb@gmail.com	203 Olive Dr, Box 303	Freeman, SD	57029	605-925-7690
80	2018-07-28 04:01:05.958992+00	2018-07-28 15:48:50.69013+00	246	Marya	Leber	momleber@yahoo.com	1708 A Annway Dr	Sioux Falls, SD	57103	605-941-8864
81	2018-07-28 04:01:05.968956+00	2018-07-28 15:52:52.671625+00	249	Cheryl	Lehmann	cherylalehmann@q.com	4405 E Pepper Ridge Cir	Sioux Falls, SD	57103	605-371-3682
108	2018-07-28 04:01:06.139698+00	2018-07-28 16:02:33.048949+00	234	Shirley	Ries	dsdsr@goldenwest.net	800 S Albert St	Freeman, SD	57029	605-925-7788
91	2018-07-28 04:01:06.028312+00	2018-07-28 16:18:08.671836+00	261	James	Miller		28343 444th Ave	Marion, SD	57043	605-925-7417
72	2018-07-28 04:01:05.904511+00	2018-07-28 16:27:10.312257+00	270	Phyllis	Kaufman		P.O. Box 606	Freeman, SD	57029	605-925-4521
106	2018-07-28 04:01:06.122001+00	2018-07-28 16:34:03.768136+00	155	Emily	Ries	aggiemom09@hotmail.com	27838 450th Ave	Parker, SD	57053	316-650-7884
62	2018-07-28 04:01:05.806646+00	2018-07-28 16:59:27.683922+00	315	Steve and Susan	Hopkins		Parker, SD	Parker, SD		605-321-7590
90	2018-07-28 04:01:06.023487+00	2018-07-28 17:24:23.412711+00	310	Florence/Dennis	Miller		28343 445th Ave	Marion, SD	57043	605-925-4647
113	2018-07-28 04:01:06.170879+00	2018-07-28 17:25:53.904733+00	333	Dennis	Schrock		817 S Albert St	Freeman, SD	57029	605-750-0319
122	2018-07-28 04:01:06.238881+00	2018-07-28 04:01:06.238958+00	\N	Jennifer	Tschetter		605 S Cherry St	Freeman, SD	57029	605-661-5096
124	2018-07-28 04:01:06.256038+00	2018-07-28 04:01:06.256109+00	\N	Robert	Tschetter		27074 431st	Bridgewater, SD	57319	605-729-2720
125	2018-07-28 04:01:06.269841+00	2018-07-28 04:01:06.269909+00	\N	Janet	Vargas	janvarlar@yahoo.com	712 S Main	Freeman, SD	57029	605-925-4007
127	2018-07-28 04:01:06.285137+00	2018-07-28 04:01:06.285189+00	\N	Gordon	Waltner	waltners@gwtc.net	43624 276th St	Freeman, SD	57029	605-925-7955
128	2018-07-28 04:01:06.29259+00	2018-07-28 04:01:06.292654+00	\N	Ladonna	Waltner		27740 443rd Ave	Marion, SD	57043	605-925-4136
129	2018-07-28 04:01:06.300286+00	2018-07-28 04:01:06.300342+00	\N	Lawrence	Waltner		27740 443rd Ave	Marion, SD	57043	605-925-4136
131	2018-07-28 04:01:06.317817+00	2018-07-28 04:01:06.317878+00	\N	Peggy	Waltner		P.O. Box 633	Freeman, SD	57029	605-925-7647
135	2018-07-28 04:15:29.059544+00	2018-07-28 04:15:29.059571+00	10000	Test	Person		Freman, SD	57029		
59	2018-07-28 04:01:05.791738+00	2018-07-28 12:56:16.494843+00	101	Paul K., Jr.	Hofer		1000 East 4th St	Freeman, SD	57029	605-925-4026
105	2018-07-28 04:01:06.115039+00	2018-07-28 13:07:13.832895+00	102	Donna	Ries		27879 441st Ave	Freeman, SD	57029	605-925-4404
137	2018-07-28 13:09:01.195326+00	2018-07-28 13:09:01.195358+00	107	Merton	Schmidt		540 S. Poplar		Freeman, SD 57029	321-7495
138	2018-07-28 13:10:10.892845+00	2018-07-28 13:10:10.892889+00	108	Alan	Ries		306 N. Dewald	Freeman, SD 57029		605-925-4502
139	2018-07-28 13:13:46.959349+00	2018-07-28 13:13:46.959409+00	111	Rachel	Graber		44797 281st St.		Parker	925-4688
140	2018-07-28 13:14:39.236059+00	2018-07-28 13:14:39.236092+00	110	Lacey	Friesen	laceyjane83@gmail.com	27473 442nd Ave	Marion, SD	57043	
141	2018-07-28 13:17:00.191862+00	2018-07-28 13:17:00.191918+00	\N	Alan	Ries		306 N. Dewald	Freeman, SD	57029	6059254502
142	2018-07-28 13:17:57.716194+00	2018-07-28 13:17:57.716237+00	113	Loren	Tschetter		618 S. Cherry		Freeman	660-1001
143	2018-07-28 13:19:01.115029+00	2018-07-28 13:19:01.115121+00	116	Eldon	Berg		404 S. Juniper Ave	Freeman, SD	57029	605-648-3507
144	2018-07-28 13:19:29.655657+00	2018-07-28 13:19:29.655717+00	114	Rebekka	Kramer		44147 280th		Freeman	605-400-3249
145	2018-07-28 13:21:16.428293+00	2018-07-28 13:21:16.428356+00	118	Amy	Waltner		44630 285th St.	Hurley, SD	57036	605-648-3772
146	2018-07-28 13:23:36.405378+00	2018-07-28 13:23:36.405415+00	120	Brian	Roesler		303 S. Randall Ave	Marion, SD	57043	605-520-4199
147	2018-07-28 13:34:37.161034+00	2018-07-28 13:34:37.161071+00	142	Ruth	Preheim		609 S. Walnut St., Apt. 7	Freeman, SD	57029	605-925-4414
149	2018-07-28 13:37:54.435714+00	2018-07-28 13:37:54.435767+00	143	LeAnne	Gross		612 W. High St.	Roanoke, IL	61561	309-921-1012
150	2018-07-28 13:38:21.43162+00	2018-07-28 13:38:21.431674+00	123	LaVonne	Tschetter		818 S. Albert St.		Freeman	605- 925-7394
151	2018-07-28 13:39:06.133938+00	2018-07-28 13:39:06.133998+00	144	Jerod	Gross		506 W. Prairie St.	Roanoke, IL	60561	309-258-5115
152	2018-07-28 13:40:59.834351+00	2018-07-28 13:40:59.834415+00	125	Mary	Brauen		6954 105th Ave		Foley, MN 56329	320-309-8559
153	2018-07-28 13:48:46.373747+00	2018-07-28 13:48:46.373807+00	127	Brigitta	Hofer		43805 268th St.		Bridgewater, SD 57319	605-366-9216
154	2018-07-28 13:49:20.770052+00	2018-07-28 13:49:20.770111+00	146	Derold	Waltner		Box 633	Freeman, SD	57029	605-925-7647
155	2018-07-28 13:49:45.143656+00	2018-07-28 13:49:45.143703+00	\N	Derrold	Waltner		Box 633	Freeman, SD	57029	6059257647
156	2018-07-28 13:51:58.481627+00	2018-07-28 13:51:58.48168+00	147	Julie	Schmeichel	webster8600@outlook.com	PO Box 3	Hitchcock, SD	57348	605-350-2929
157	2018-07-28 13:53:04.747007+00	2018-07-28 13:53:04.747059+00	128	Delmer	Hofer		609 S. Walnut Apt. 1		Freeman, SD 57029	605-925-4638
158	2018-07-28 13:53:21.485942+00	2018-07-28 13:53:21.486+00	148	Gary	Schmeichel	webster8600@outlook.com	PO Box 3	Hitchcock, SD	57348	605-350-2032
159	2018-07-28 13:54:16.785447+00	2018-07-28 13:54:16.785506+00	129	Cindy	Bartell		1939 Chisholm Rd	Galva, KS 67443		316-284-1601
160	2018-07-28 13:54:59.715459+00	2018-07-28 13:54:59.715515+00	149	Roy	Becker	roypattyrbecker@hotmail.com	2511 Robbie Dr.	Aberdeen, SD	57401	605-229-2790
161	2018-07-28 13:55:36.14857+00	2018-07-28 13:55:36.148628+00	131	Shirley	Delk		PO Box 113	Sedgwick, KS 67135		316-215-2667
123	2018-07-28 04:01:06.243827+00	2018-07-28 13:57:46.820407+00	150	Larry	Tschetter		28020 US Hwy 81	Freeman, SD	57029	605-925-7009
162	2018-07-28 13:58:02.117871+00	2018-07-28 13:58:02.117931+00	132	Ida	Gross		2904 W. 33rd St.#130	Sioux Falls, SD 57105		334-9703
164	2018-07-28 13:59:07.602222+00	2018-07-28 13:59:07.60228+00	151	Vicki	Graber	vikagraber@gmail.com	909 N. Greene Road	Goshen, IN	46526	574-215-1150
165	2018-07-28 13:59:53.923639+00	2018-07-28 13:59:53.923696+00	152	Virginia	Graber		600 S. Dewald, Apt. 9	Freeman, SD	57029	605-925-7569
167	2018-07-28 14:02:13.216761+00	2018-07-28 14:02:13.216807+00	136	Carol	Schnabel		206 South Pine		Menno, SD 57045	387-5291
163	2018-07-28 13:59:03.77249+00	2018-07-28 14:04:54.637686+00	133	Celia	Gross		203 East A	Hillsboro, KS 67063		620-947-5450133
168	2018-07-28 14:06:50.093011+00	2018-07-28 14:06:50.093072+00	139	Mildred	Hofer		300 West North County Rd		Freeman, SD 57029	925-7277
169	2018-07-28 14:07:56.397757+00	2018-07-28 14:07:56.39779+00	2	lerace	graber		PO Box 159	Freeman, SD		605-925-7499
170	2018-07-28 14:11:21.767702+00	2018-07-28 14:11:21.767763+00	156	Mike	Kempf	mdkempf@roadrunner.com	PO Box 53186	Pettisville, OH	43553	419-445-2728
171	2018-07-28 14:14:13.660206+00	2018-07-28 14:14:13.660265+00	158	Michelle	Palmateer		700 Mulberry St.	Valley Falls, KS	66088	785-249-5067
172	2018-07-28 14:15:09.5144+00	2018-07-28 14:15:09.514432+00	173	Belle	Graber		431 Green Meadow Lane		Freeman, SD 57029	605-925-7365
173	2018-07-28 14:15:48.410518+00	2018-07-28 14:15:48.410572+00	159	Les	Gustafson-Zook		1608 S. 8th St.	Goshen, IN	46526	574-238-3579
174	2018-07-28 14:16:45.635934+00	2018-07-28 14:16:45.635966+00	176	Carol	Meyer		4050 N. Riverside Dr.		Colombus, IN 47203	812-371-5087
175	2018-07-28 14:16:49.404422+00	2018-07-28 14:16:49.404455+00	160	Marjorie	Tieszen		600 S. Main Ave.	Marion, SD	57043	605-648-2558
176	2018-07-28 14:17:53.57007+00	2018-07-28 14:17:53.570124+00	3	maria	Ries		810 6th St	Freeman, SD  57029		605-925-7317
177	2018-07-28 14:17:54.507169+00	2018-07-28 14:17:54.507227+00	161	Ronald	Glanzer		815 N. Sherman St.	Newton, KS	67114	316-303-2530
178	2018-07-28 14:18:13.924934+00	2018-07-28 14:18:13.924992+00	178	Marcia	Hellevang		30 Meadowlark Lane		Fargo, ND 58102	701-361-3534
179	2018-07-28 14:19:05.801839+00	2018-07-28 14:19:05.801891+00	162	KC	Hofer		44540 272nd. St.	Marion, SD	57043	605-660-7719
181	2018-07-28 14:20:39.095656+00	2018-07-28 14:20:39.095713+00	163	Janine	Addis	janine.addis@gmail.com	321 N. Dean	Mt. Hope, KS	67108	316-204-8766
182	2018-07-28 14:23:04.722398+00	2018-07-28 14:23:04.722458+00	165	Kristi	Stahl		801 Wynken Dr.		Freeman, SD 57029	605-941-3795
130	2018-07-28 04:01:06.304868+00	2018-07-28 14:30:11.3236+00	181	Margie	Waltner	margiewaltner@gmail.com	43960 278th St	Freeman, SD	57029	605-925-7766
183	2018-07-28 14:30:54.013802+00	2018-07-28 14:30:54.013863+00	166	Shirley	Pollman		951 N. Main		Bridgewater, SD 57319	729-2460
126	2018-07-28 04:01:06.278818+00	2018-07-28 15:26:13.268392+00	216	Judy	Walter		P.O. Box 204	Freeman, SD	57029	605-925-4578
184	2018-07-28 14:31:23.845374+00	2018-07-28 16:27:57.231496+00	282	Karen	Wollman		118 S. Pearl St.	Menno, SD	57045	605-387-5463
166	2018-07-28 14:01:56.683096+00	2018-07-28 16:40:31.837667+00	153	Jackie	Stucky		2114 Jane Dr.	Rapid City, SD	57702	605-343-0710
180	2018-07-28 14:20:25.019444+00	2018-07-28 16:58:00.895128+00	177	Cheryl	Wollman		28059 444th Ave		Marion, SD 57043	605-254-5407
148	2018-07-28 13:37:18.373661+00	2018-07-28 17:15:34.095584+00	122	Evelyn	Wallmann		1980 Meadowlark Lane #205	Huron, SD 57350		605-352-2238
133	2018-07-28 04:01:06.330382+00	2018-07-28 17:25:39.167449+00	331	Rich	Wieman		123	Marion, SD	57043	605-660-0341
134	2018-07-28 04:01:06.33534+00	2018-07-28 17:40:03.592694+00	340	Beth	Yoder	beniyo32189@gmail.com	815 S Prairie Ave	Sioux Falls, SD	57104	937-844-9175
185	2018-07-28 14:34:19.405384+00	2018-07-28 14:34:19.405435+00	183	Zach/Brittney	Kempf		7852 S. Townsley Ave., #7	Sioux Falls, SD	57108	605-610-7669
186	2018-07-28 14:35:09.467685+00	2018-07-28 14:35:09.467742+00	167	Melvin	Koehn		200 Deerview Ave.		Tea, SD 57064	368-2245
187	2018-07-28 14:36:59.649178+00	2018-07-28 14:36:59.649236+00	168	Kathy	Kleinsasser		43639 277th St.		Freeman, SD 57029	92-7952
188	2018-07-28 14:37:19.541508+00	2018-07-28 14:37:19.541571+00	184	Linda	Schrag		44133 283rd St.	Freeman, SD	57029	605-212-7621
189	2018-07-28 14:39:53.695649+00	2018-07-28 14:39:53.695707+00	169	Carol	Wollman		501 s. Juniper St.		Freeman, SD 57029	605-925-7534
191	2018-07-28 14:50:52.007618+00	2018-07-28 14:50:52.007679+00	194	Erna	Schmidt		600 S. Kiwanis Ave., #120	Sioux Falls, SD	57104	605-339-3098
192	2018-07-28 14:54:32.779695+00	2018-07-28 14:54:32.779767+00	186	Alma	Wollman		825 S. Albert		Freeman, SD 57029	925-4950
193	2018-07-28 14:55:07.781237+00	2018-07-28 14:55:07.781426+00	195	Karen	Venables		1404 W. Thompson Dr.	Sioux Falls, SD	57105	605-339-0502
195	2018-07-28 14:56:42.423685+00	2018-07-28 14:56:42.423751+00	196	Judy	Rehurek		2011 Kennedy Dr.	Sioux City, IA	51104	712-252-4631
196	2018-07-28 14:56:54.230713+00	2018-07-28 14:56:54.230764+00	\N	Lyle	Preheim		Freeman, SD			
199	2018-07-28 14:58:24.36759+00	2018-07-28 14:58:24.36765+00	188	Rodney	Mettler		28156 431st Ave.	Menno, SD 57045		605-351-9414
197	2018-07-28 14:57:41.907669+00	2018-07-28 14:58:24.990471+00	197	Jim & Bernette	Ensz		27015 Split Creek Ct.	Sioux Falls, SD	57108	605-743-5855
200	2018-07-28 14:59:36.884591+00	2018-07-28 14:59:36.884655+00	\N	Etc	Shoppe		Freeman, SD	57029		
201	2018-07-28 15:00:40.139969+00	2018-07-28 15:00:40.140026+00	\N	Marilyn	Wipf		Freeman, SD	57029		
202	2018-07-28 15:01:35.108447+00	2018-07-28 15:04:45.645509+00	193	Judy	Kaufman		420 S. County Rd.	Freeman, SD	57029	605-925-7607
203	2018-07-28 15:04:50.676652+00	2018-07-28 15:04:50.676714+00	\N	Kathleen	Miller		Marion, SD	57043		
204	2018-07-28 15:06:35.458591+00	2018-07-28 15:06:35.458645+00	198	Lincoln	Waltner		1700 Locust Apt 203	Yankton, SD	57078	605-653-3630
205	2018-07-28 15:06:54.062077+00	2018-07-28 15:06:54.062141+00	\N	Nita	Engbrecht		Marion, SD	57043		
206	2018-07-28 15:07:54.166508+00	2018-07-28 15:07:54.166563+00	202	Sherryl	Friesen		PO Box 46	Freeman, SD 57029		925-7835
207	2018-07-28 15:07:57.11804+00	2018-07-28 15:07:57.118105+00	199	Arlan	Miller		710 SW Wynken Dr.	Freeman, SD	57029	605-925-7458
208	2018-07-28 15:08:15.544658+00	2018-07-28 15:08:15.544717+00	\N	Larry	Eisenbeis		Marion, SD	57043		
210	2018-07-28 15:10:22.070302+00	2018-07-28 15:10:22.070368+00	204	Emma	Hofer		600 S. Dewald Apt. 5		Freeman, SD 57029	
209	2018-07-28 15:09:42.684645+00	2018-07-28 15:10:47.095681+00	203	Melvin L.	Hofer		600 S. Dewald Apt. 5		Freeman, SD 57029	925-4732
211	2018-07-28 15:11:27.5663+00	2018-07-28 15:11:27.566596+00	205	Judy	Gross		306 N. Dewald		Freeman, SD 57029	605-925-7442
212	2018-07-28 15:12:13.893747+00	2018-07-28 15:12:13.893859+00	206	Bonita	Hofer		PO Box 149	Freeman, SD 57029		605-661-8112
213	2018-07-28 15:14:09.743284+00	2018-07-28 15:14:09.743416+00	211	Carol	Smith		301 N. Main St., Apt. 106	Freeman, SD	57029	605-925-7391
214	2018-07-28 15:14:16.594061+00	2018-07-28 15:14:16.594113+00	207	Donna	Petersen		PO 426		Freeman, SD 57029	605-925-7189
215	2018-07-28 15:15:49.618002+00	2018-07-28 15:15:49.618061+00	208	Sandi	Baty		552 Sherwood Rd	Shoreview, MN 55126		651-398-6127
216	2018-07-28 15:16:09.108886+00	2018-07-28 15:16:09.109282+00	212	Jake	Gross		Box 250	Freeman, SD	57029	605-925-7488
217	2018-07-28 15:19:00.539667+00	2018-07-28 15:19:00.539728+00	213	Derrold	Hofer		2605 W. 34th	Sioux Falls, SD	57105	605-366-0319
218	2018-07-28 15:20:30.800681+00	2018-07-28 15:20:30.80074+00	210	Harold	Loewen		18653 408th Ave.		Carpenter, SD 57322	354-4058
219	2018-07-28 15:21:14.114084+00	2018-07-28 15:21:14.114141+00	214	Darla	Loewen		18653 408th Ave.		Carpenter, SD 57322	605-354-1152
220	2018-07-28 15:25:02.307617+00	2018-07-28 15:25:02.30767+00	221	Angie	VanDiepen		622 S. Walnut	Freeman, SD	57029	605-670-0380
221	2018-07-28 15:26:50.239194+00	2018-07-28 15:26:50.239257+00	222	Roine	Klassen		47174 275th Ave	Harrisburg, SD		605-368-2652
222	2018-07-28 15:27:09.307119+00	2018-07-28 15:27:09.307179+00	217	Karen	McBrady		23739 County Hwy 73	Hewitt, MN 56453		218-639-4767
223	2018-07-28 15:30:00.307258+00	2018-07-28 15:30:00.307369+00	218	Corey and Nancy	Miller		27944 433rd Ave		Freeman, SD 57029	319-930-7323
225	2018-07-28 15:32:43.387597+00	2018-07-28 15:32:43.387658+00	223	Deb	Beier		PO Box 618	Freeman, SD	57029	605-351-4747
226	2018-07-28 15:34:16.056252+00	2018-07-28 15:34:16.0563+00	224	Charlene	Friesen		103 N. Cedar St.	Freeman, SD	57029	605-925-7970
227	2018-07-28 15:35:16.192194+00	2018-07-28 15:35:16.192241+00	220	Allen and Ardella	Schrag		502 Tieszen Dr.	Marion, SD 57043		605-648-3924
228	2018-07-28 15:35:18.203717+00	2018-07-28 15:35:18.203781+00	225	Larry	Schrag		2320 Westwind Dr.	Ames, IA	50010	515-337-1713
229	2018-07-28 15:37:45.372873+00	2018-07-28 15:37:45.372947+00	226	Alvina	Hofer		432 E. 2nd St., Box 432	Freeman, SD	57029	605-925-4556
230	2018-07-28 15:38:16.907821+00	2018-07-28 15:38:16.90789+00	241	Tim and Anita	Eisenbeis		44373 280th St.	Marion, SD 57043		605-925-4661
231	2018-07-28 15:39:16.419762+00	2018-07-28 15:39:16.41982+00	227	Rebecca	Hofer		27163 US HWY 81	Bridgewater, SD	57319	605-261-5514
232	2018-07-28 15:40:34.325349+00	2018-07-28 15:40:34.325399+00	242	Dee	Miller		301 N. Main Apt. 109	Freeman, SD 57029		605-655-4960
233	2018-07-28 15:42:56.685718+00	2018-07-28 15:42:56.68583+00	244	Arlen	Hofer		811 East Walnut St.	Canton, SD 57013		605-987-5332
234	2018-07-28 15:44:48.573804+00	2018-07-28 15:44:48.573856+00	228	Jerry	Eyley		4902 N. 205th	Elkhorn, NE	68022	402-895-0386
235	2018-07-28 15:49:41.06563+00	2018-07-28 15:49:41.065694+00	247	Chelsey	Levene		300 East Kevin Dr.	Tea, SD 57064		605-496-4375
236	2018-07-28 15:49:54.525554+00	2018-07-28 15:49:54.525614+00	230	Wendy	Miller		44690 282nd St.	Hurlery, SD	57036	605-925-7211
237	2018-07-28 15:50:20.348959+00	2018-07-28 15:50:20.349012+00	248	Holly	Wilgers		120 Lisa Ct.	Tea, SD 57064		605-413-8737
238	2018-07-28 15:51:47.199545+00	2018-07-28 15:51:47.199604+00	6	Priscilla	Walter		26865 433 Ave	Bridgewater, SD  57319		605-351-7478
240	2018-07-28 15:54:03.860264+00	2018-07-28 15:54:03.860366+00	7	Heather	Haggerty		43804 278th St	Freeman, SD  57029		605-925-7549
241	2018-07-28 15:54:31.407212+00	2018-07-28 15:54:31.407269+00	250	Allen	Hofer		43950 269th St.	Bridgewater, SD 57319		759-0372
243	2018-07-28 16:02:07.866921+00	2018-07-28 16:02:07.866988+00	254	Herman and Inez	Wipf		621 Relanto St.	Freeman, SD 57029		605-925-7261
239	2018-07-28 15:53:28.213845+00	2018-07-28 16:58:42.826878+00	232	Arden	Dewald		311 2nd St.	Freeman, SD	57029	605-925-4912
244	2018-07-28 16:02:49.228168+00	2018-07-28 16:02:49.228229+00	8	Ted	Takasaki		2501 S Camden Ave	Sioux Falls, SD  57106		612-799-7481
245	2018-07-28 16:03:44.385485+00	2018-07-28 16:03:44.385541+00	256	Mike	Tschetter		5801 S. John Ave.		Sioux Falls, SD 57106	605-660-3347
248	2018-07-28 16:06:10.700285+00	2018-07-28 16:06:10.700343+00	257	claudia	Cope		11869 W Calgary Dr.	Casa Grande, AZ	85122	6027993999
251	2018-07-28 16:07:39.242149+00	2018-07-28 16:07:39.242211+00	238	Muriel	Schamber		604 S 5th St	Menno, SD	57045	605-661-1801
250	2018-07-28 16:07:11.558655+00	2018-07-28 16:07:45.051891+00	258	Sawnya	Sherwood		1681 E Fontana Dr	Casa Grande, AZ	85122	4802016289
252	2018-07-28 16:09:06.767632+00	2018-07-28 16:09:06.767691+00	259	Elaine	Silvers		1125 N Lalley Ln	Sioux Falls, SD 57107		6053809831
246	2018-07-28 16:04:06.639377+00	2018-07-28 16:23:17.47105+00	235	Ruby	Waltner		PO Box 266	Freeman, SD	57029	605-925-4622
249	2018-07-28 16:06:19.627412+00	2018-07-28 16:24:16.904341+00	236	Yvonne	Mast		209 S Walnut St, Apt 10	Freeman, SD	57029	612-202-0621
198	2018-07-28 14:57:57.03239+00	2018-07-28 16:31:27.886659+00	5	Cathy	Roesler		303 S Randall	Marion, SD		605-648-2913
190	2018-07-28 14:47:52.539793+00	2018-07-28 16:37:42.61979+00	192	Sharon	Waltner		43624 276th St.	Freeman, SD	57029	605-925-7955
242	2018-07-28 16:01:38.052835+00	2018-07-28 16:51:27.225572+00	233	Jeremy	Waltner		Box 777	Freeman, SD	57029	605-351-6097
224	2018-07-28 15:31:35.279613+00	2018-07-28 17:06:08.883949+00	219	Joyce	Gross		528 S. Poplar		Freeman, SD 57029	925-7756
253	2018-07-28 16:09:43.874499+00	2018-07-28 16:09:43.874737+00	239	Beverly	Klassen		4550 E 49th St	Sioux Falls, SD	57110	605-339-9122
254	2018-07-28 16:09:53.92143+00	2018-07-28 16:09:53.921488+00	260	Susi	McCabe		1100 N Palm St	Gilbert, AZ85234		4804330224
255	2018-07-28 16:10:56.81074+00	2018-07-28 16:10:56.81129+00	251	Shelli	Brinkley		1772 E Toledo St	Gilbert, AZ 85295		4806959603
257	2018-07-28 16:13:21.883885+00	2018-07-28 16:13:21.883943+00	253	Harry	Waltner		810 N Cole Ave	Tea SD 57064		6053518851
261	2018-07-28 16:15:27.220331+00	2018-07-28 16:15:27.220639+00	279	Jeff	Kaufman		4936 S Kalen Pl	Sioux Falls, SD 57108		6053597289
264	2018-07-28 16:17:24.732521+00	2018-07-28 16:17:24.7328+00	265	Elizabeth	Janssen		27781 443rd	Freeman, SD	57029	605-925-4780
256	2018-07-28 16:12:16.718036+00	2018-07-28 16:12:16.718157+00	252	Mike	Waldner		1855 S Sertoma aVE uNIT 101	Sioux Falls, SD 57106		6059062497
258	2018-07-28 16:13:23.026399+00	2018-07-28 16:13:23.02659+00	262	Carmelle	Miller		28345 44th Ave	Marion, SD	57043	605-925-7472
259	2018-07-28 16:14:06.500504+00	2018-07-28 16:14:06.500564+00	280	Jacob	Stahl		829 Walnut St	Freeman, SD 57029		6059297078
260	2018-07-28 16:15:20.780476+00	2018-07-28 16:15:20.780534+00	263	Scott	Glanzer		26904 435th Ave	Bridgewater, SD	57319	605-940-8544
262	2018-07-28 16:16:16.185095+00	2018-07-28 16:16:16.185399+00	264	Elizabeth	Anderson		PO Box 188	Freeman, SD	57029	605-925-4175
263	2018-07-28 16:16:28.84089+00	2018-07-28 16:16:28.84096+00	278	Robert	Tschetter		27074 431st Ave	Bridgewater, SD 57319		6057292720
265	2018-07-28 16:19:24.625096+00	2018-07-28 16:19:24.625154+00	266	LuAnn	Glanzer		3605 Ralph Roger Rd	Sioux Falls, SD	57108	605-271-4699
266	2018-07-28 16:20:30.082423+00	2018-07-28 16:20:30.082477+00	277	Sheila	Epp		27868 444th Ave	Marion, SD 57043		6059512327
194	2018-07-28 14:56:17.149404+00	2018-07-28 16:20:42.439359+00	187	Phyllis	Reimer		718 S. Poplar		Freeman, SD 57029	605-925-7789
267	2018-07-28 16:21:36.19707+00	2018-07-28 16:21:36.197124+00	276	Josie	Epp		27077 445th Ave	Marion, SD 57043		6056483455
268	2018-07-28 16:22:27.458975+00	2018-07-28 16:22:27.459063+00	267	Anne	Waltner		12	Marion, SD	57043	216-820-7042
269	2018-07-28 16:25:08.098926+00	2018-07-28 16:25:08.098986+00	275	Edna	Otten		600 S Dewald Apt 8		Freeman, SD 57029	6054845254
270	2018-07-28 16:25:31.600141+00	2018-07-28 16:25:31.600199+00	237	Dorothy	Preheim		600 S Dewald, Apt 6	Freeman, SD	57029	605-925-7347
271	2018-07-28 16:26:45.972847+00	2018-07-28 16:26:45.972909+00	269	Marilyn	Brockmueller		28440 442nd Ave	Freeman, SD	57029	605-925-4632
272	2018-07-28 16:27:32.479943+00	2018-07-28 16:27:32.480123+00	274	Kevin	Hofer		7257 Wembley Ter W	Toledo, OH 43617		7178814161
273	2018-07-28 16:28:15.510804+00	2018-07-28 16:28:15.510855+00	273	Andre	Eisenbeis		43845 282nd St	Freeman, SD 57029		6057449610
274	2018-07-28 16:29:35.176439+00	2018-07-28 16:29:35.176497+00	283	Curtis	Fast		308 E Washington St	Marion, SD 57043		6056483338
275	2018-07-28 16:32:14.428074+00	2018-07-28 16:32:14.428135+00	281	Colleen	Permann		PO Box 73	Pickstown, SD		605-487-7970
276	2018-07-28 16:34:07.771892+00	2018-07-28 16:34:07.771948+00	272	Herb	Schroeder		916 S Cloubas Ave	Sioux Falls, SD 57103		6053393429
277	2018-07-28 16:36:12.517194+00	2018-07-28 16:36:12.517258+00	268	Tracie	Nice		1403 University Avenue	Wichita, KS	67213	316-204-8795
278	2018-07-28 16:36:16.492357+00	2018-07-28 16:36:16.49243+00	271	Alice	Graber		600 S. Dewald Apt. 3	Freeman, SD 57029		605-9254648
279	2018-07-28 16:38:57.714055+00	2018-07-28 16:38:57.714109+00	285	Sharon	Waltner		28142 448th Ave	Parker, SD	57053	605-648-3224
280	2018-07-28 16:40:06.817648+00	2018-07-28 16:40:06.817706+00	294	Larry	Waltner		44656 283rd St	Hurley SD 57036		6059402051
281	2018-07-28 16:42:21.576001+00	2018-07-28 16:42:21.576057+00	286	Allison	Smith		732 S Lowell Ave	Sioux Falls, SD	57103	605-929-7864
282	2018-07-28 16:42:27.475779+00	2018-07-28 16:42:27.475842+00	295	Lois	Wollman		42943 282nd St	Menno, SD 57045		6053875600
283	2018-07-28 16:43:06.547835+00	2018-07-28 16:43:06.547898+00	296	Kelsey	Ortman		633 W Lincoln Dr	Freeman, SD 57029		6054211318
284	2018-07-28 16:44:06.224742+00	2018-07-28 16:44:06.224801+00	297	Cal	Graber		45486 282nd St	Hurley SD 57036		6059413726
285	2018-07-28 16:45:03.298238+00	2018-07-28 16:45:03.29829+00	288	Lorraine	Ensz		43946 272nd St	Bridgewater, SD	57319	904-742-3758
286	2018-07-28 16:45:10.615686+00	2018-07-28 16:45:10.615744+00	298	Andrea	Voorhees		44328 267th St	Marion, SD 57043		6056451501
287	2018-07-28 16:45:46.71968+00	2018-07-28 16:45:46.719738+00	289	LaVonne	Tieszen		319 S Albert	Freeman, SD	57029	605-925-4644
289	2018-07-28 16:49:47.85718+00	2018-07-28 16:49:47.857238+00	299	Carol	Eisenbeis		44566 285th St	Hurley SD 57036		6056616299
290	2018-07-28 16:52:10.024065+00	2018-07-28 16:52:10.024127+00	300	Sheryl	Ewert		4505 S Plains Dr	Sioux Falls, SD 57106		6059414516
291	2018-07-28 16:53:35.563726+00	2018-07-28 16:53:35.563789+00	291	Larry	Wittmeir		42 Oakwood Shoreline Dr	Bruce, SD	57220	605-627-5466
292	2018-07-28 16:54:38.367528+00	2018-07-28 16:54:38.369167+00	301	Lois	Janzen-Preheim		44229 281st St	Freeman, SD 57029		605-310-9849
293	2018-07-28 16:55:14.021951+00	2018-07-28 16:55:14.022013+00	292	Cindy	Herlyn		44678 269th St	Marion, SD	57043	605-648-3122
294	2018-07-28 16:55:52.725254+00	2018-07-28 16:55:52.725315+00	312	Aprille	Hofer		PO Box 634	Freeman, SD 57029		6057609622
295	2018-07-28 16:56:47.399568+00	2018-07-28 16:56:47.399623+00	302	LeRoy	Epp	ljepp@hotmail.com	27740 444th Ave	Marion, SD	57043	6059257635
296	2018-07-28 16:57:29.184947+00	2018-07-28 16:57:29.185007+00	313	Rodney  and Vernetta	Waltner		44159 274th St	Marion, SD 57043		6059257620
297	2018-07-28 16:58:33.123602+00	2018-07-28 16:58:33.123664+00	314	Ron	Wuertz		705 N Teal Pl	Sioux Falls, SD 57107		6057281735
298	2018-07-28 17:00:51.055501+00	2018-07-28 17:00:51.05555+00	316	S Roy	Kaufman		PO Box 58	Freeman, SD 57029		605-9257430
299	2018-07-28 17:03:27.09156+00	2018-07-28 17:03:27.091626+00	321	Juli	Anderson		400 Mary Ln	Hartford, SD	57033	6055953063
300	2018-07-28 17:04:21.903816+00	2018-07-28 17:04:21.903876+00	317	Sherilyn	Ortman		44578 280th St	Marion, SD 57043		605-925-7038
301	2018-07-28 17:07:26.037534+00	2018-07-28 17:07:26.037593+00	318	Vernon and Norma	Hofer		Po Box 657	Freeman, SD 57029		605-359-8569
302	2018-07-28 17:09:09.003832+00	2018-07-28 17:09:09.003891+00	303	Mary	Waltner		741 S Cherry	Freeman, SD	57029	605-366-1243
303	2018-07-28 17:11:56.31172+00	2018-07-28 17:11:56.311787+00	319	Cheryl	Hoffman		1303 3rd Ave	Mountain Lake, MN	56159	5078222607
304	2018-07-28 17:13:29.219814+00	2018-07-28 17:13:29.219875+00	320	Jim and Judy	Neu		3706 Staci Ln	Yankton, SD	57078	6056605654
305	2018-07-28 17:13:39.360947+00	2018-07-28 17:13:39.361009+00	304	Nancy	Haas		2307 Western Ave	Yankton, SD	57078	
306	2018-07-28 17:14:31.299754+00	2018-07-28 17:14:31.299812+00	322	Shirley	Magstadt		40978 Harding Pl	Mitchell, SD	57301	6057700412
307	2018-07-28 17:15:34.120381+00	2018-07-28 17:15:34.120505+00	323	Cindi	Mutchelknaus		44461 282nd St	Marion, SD 57043		6059254652
308	2018-07-28 17:16:37.755699+00	2018-07-28 17:16:37.755767+00	324	Bert	Schroeder		3423 W 80th Pl	Sioux Falls, SD 57108		6053665920
309	2018-07-28 17:16:53.781626+00	2018-07-28 17:16:53.781686+00	305	Judy	Rechnagel		PO Box 245	Freeman, SD	57029	605-925-4611
310	2018-07-28 17:17:22.743522+00	2018-07-28 17:17:22.743576+00	325	Leroy	Spomer		5000 S Nevada Ave	Sioux Falls, SD 57108		6052714025
311	2018-07-28 17:18:22.531659+00	2018-07-28 17:18:22.531719+00	326	Jane	Hohm		216 E 4th St	Freeman, SD 57029		4024690892
312	2018-07-28 17:19:12.693992+00	2018-07-28 17:19:12.694045+00	327	Sue	Lowe		611 Stafford St	Scotland, SD	57059	6128752967
313	2018-07-28 17:19:50.960484+00	2018-07-28 17:19:50.960538+00	306	Genevieve	Hofer		27815 443rd Ave	Freeman, SD	57029	605-925-7498
314	2018-07-28 17:21:24.641807+00	2018-07-28 17:21:24.641863+00	307	Donna	Preheim	dpreheim@yahoo.com	PO Box 157	Freeman, SD	57029	
315	2018-07-28 17:21:42.556633+00	2018-07-28 17:21:42.556696+00	308	Mary	Schoenfish		43065 283rd St	Menno, SD	57045	605-387-5772
316	2018-07-28 17:21:49.797967+00	2018-07-28 17:21:49.798047+00	328	Susan	Harder		2708 S Prairie Ave	Sioux Falls, SD 57105		6052619150
317	2018-07-28 17:23:13.065375+00	2018-07-28 17:23:13.065434+00	309	Deb	Sanders		826 S Relanto	Freeman, SD	57029	701-388-8991
318	2018-07-28 17:24:07.19978+00	2018-07-28 17:24:07.19983+00	329	Jay	Allison		28139 451st Ave	Hurley SD 57036		4023400259
319	2018-07-28 17:24:53.07948+00	2018-07-28 17:24:53.079597+00	330	Kelly	wiese		102 N Cedar Ave	Marion, SD 57043		6057281624
320	2018-07-28 17:26:47.70625+00	2018-07-28 17:26:47.706317+00	332	Jo	Stratmeyer		28503 474th Ave	Worthing, SD	57077	605-372-4744
321	2018-07-28 17:27:38.643465+00	2018-07-28 17:27:38.643524+00	334	Kerwin	Graber		44065 278th St	Freeman, SD 57029		6059257805
322	2018-07-28 17:31:07.035833+00	2018-07-28 17:31:07.0359+00	341	Liz	Graber		27956 443rd Ave	Freeman, SD 57029		6056606948
323	2018-07-28 17:35:29.287439+00	2018-07-28 17:35:29.287505+00	335	Sonja	Waltner		28278 442nd Ave	Freeman, SD 57029		6059254722
324	2018-07-28 17:35:56.243862+00	2018-07-28 17:35:56.243927+00	336	Lisbeth	Graber		115 W Spy Glass Dr	Sioux Falls, SD		605-366-2253
132	2018-07-28 04:01:06.324005+00	2018-07-28 17:39:05.185248+00	337	Kate	Widmer	kate.widmer13@gmail.com	815 S Prairie Ave	Sioux Falls, SD	57104	574-349-1386
325	2018-07-28 17:39:26.971786+00	2018-07-28 17:39:26.971849+00	338	Barbara	Tieszen		801 E 15th St	Unit 13	57078	605-310-4503
326	2018-07-28 17:40:28.424351+00	2018-07-28 17:40:28.424416+00	342	Lisa	Brockmeuller		27372 437th Ave	Freeman, SD 57029		6059254881
327	2018-07-28 17:40:32.344636+00	2018-07-28 17:40:32.344693+00	339	Jo Ann	Ries		PO Box 429	Freeman, SD	57029	605-254-5408
288	2018-07-28 16:47:36.029265+00	2018-07-28 17:41:14.761142+00	290	Cheryl & John	Koch		PO Box 456	Freeman, SD	57029	605-376-3039
328	2018-07-28 17:41:40.210953+00	2018-07-28 17:41:40.213154+00	343	David	Graber		43772 283rd St	f		6059257083
329	2018-07-28 17:42:15.971066+00	2018-07-28 17:42:15.971128+00	344	Dustin	Walter		43442 271st St	Bridgewater, SD	57319	605-999-2603
330	2018-07-28 17:43:41.80534+00	2018-07-28 17:43:41.805399+00	345	Patricia	Bartell		5717 W 49th St	Sioux Falls, SD 57106		5078220630
331	2018-07-28 17:44:48.550195+00	2018-07-28 17:44:48.550254+00	347	Zecyn	Phillips		5202 W 37th St	Sioux Falls, SD 57106		6053768719
332	2018-07-28 17:45:00.342302+00	2018-07-28 17:45:00.342352+00	348	Gabriel	Eisenbeis		44373 280th St	Marion, SD	57043	2192815444
333	2018-07-28 17:45:12.995718+00	2018-07-28 17:45:12.995785+00	346	Megan	Eisenbeis		44566 285th St	Hurley, SD	57036	605-610-57036
334	2018-07-28 17:46:12.843602+00	2018-07-28 17:46:12.843661+00	349	Lacey	Figland		426 N French Ave	Sioux Falls, SD 57103		6057700004
335	2018-07-28 17:46:26.063381+00	2018-07-28 17:46:26.064197+00	350	Andrew	Graber		27725 443rd Ave	Marion, SD	57043	
336	2018-07-28 17:48:24.215924+00	2018-07-28 17:48:24.216022+00	353	Bruce & Monica	Hofer		27304 436th Ave	Freeman, SD	57029	
337	2018-07-28 17:49:11.339434+00	2018-07-28 17:49:11.339484+00	352	Joy	Erdman		648 Lincoln Ave SW	Huron, SD 57350		6053501713
338	2018-07-28 17:49:16.075549+00	2018-07-28 17:49:16.075598+00	354	Stacy	Medina		7945 Alida St	La Mesa, CA	91942	760-419-2615
339	2018-07-28 17:50:11.563293+00	2018-07-28 17:50:11.563345+00	355	Nathan	Schrag		27836 445th Ave	Marion, SD 57043		6053517036
340	2018-07-28 17:51:05.495878+00	2018-07-28 17:51:05.495937+00	356	Lorriann	Shatter		PO Box 90550	Sioux Falls, SD	57109	
341	2018-07-28 17:51:37.107687+00	2018-07-28 17:51:37.107753+00	357	Cheryl	Johnson		217 S Poplar	Freeman, SD 57029		6054136191
342	2018-07-28 17:53:24.531682+00	2018-07-28 17:53:24.531743+00	358	Carol	Wieman	wieman6@goldenwest.net	Box 135	Marion, SD 57043		6056483164
343	2018-07-28 17:54:43.410204+00	2018-07-28 17:54:43.410256+00	359	Larry	Eisenbeis		44438 280th St	Marion, SD 57043		6059257322
344	2018-07-28 17:55:23.383628+00	2018-07-28 17:55:23.38369+00	361	Barb	Yoder		28152 US Hwy 81	Freeman, SD 57029		6059254713
345	2018-07-28 17:56:53.342171+00	2018-07-28 17:56:53.342238+00	360	Brett	Eisenbeis	bretteisenbeis@gmail.com	215 S 14th St	Sioux Falls, SD	57104	605 661-8325
346	2018-07-28 17:58:18.815312+00	2018-07-28 17:58:18.815381+00	366	Tyronne	Preheim		28533 441st Ave	Freeman, SD	57029	605-327-3462
347	2018-07-28 18:00:09.600365+00	2018-07-28 18:00:09.600434+00	364	Peg	Kesteloot		44364 273rd St	Marion, SD	57043	605-648-3159
348	2018-07-28 18:02:26.842375+00	2018-07-28 18:02:26.843093+00	365	Marilyn	Penner		4601 E Fernwood Dr	Sioux Falls, SD 57110		6053712712
349	2018-07-28 18:08:09.934506+00	2018-07-28 18:08:09.93457+00	367	Renee	Hartman		316 N Cedar, Box 520	Freeman, SD	57029	605-925-7494
350	2018-07-28 18:26:20.591515+00	2018-07-28 18:26:20.591576+00	368	Raymon	Epp		30849 448th Ave	Mission Hill, SD	57046	6056680855
351	2018-07-28 18:27:47.24704+00	2018-07-28 18:27:47.247102+00	362	Doris	Hofer		46754 271st St	Tea, SD 57064		605-368-2410
352	2018-07-28 18:29:11.597042+00	2018-07-28 18:29:11.597743+00	370	Vicki	Ormseth		4708 E Tomar Rd	Sioux Falls, SD 57105		6053591538
353	2018-07-28 18:36:22.830463+00	2018-07-28 18:36:22.830518+00	371	Shawn	Hofer		123	Marion, SD	57043	605-648-3722
354	2018-07-28 18:41:33.476535+00	2018-07-28 18:41:33.476597+00	369	Chris	Steele		PO Box 413	Tyndall, D	57066	605-660-4353
355	2018-07-28 18:46:29.382899+00	2018-07-28 18:46:29.382988+00	372	Alex	Eisenbeis		3511 S Gateway Blvd	Apt 105	Sioux Falls, SD 57106	6056609172
356	2018-07-28 19:01:08.506071+00	2018-07-28 19:01:08.506144+00	\N	Arlyss	Ortman		Freeman, SD	57029		
357	2018-07-28 19:10:07.476409+00	2018-07-28 19:10:07.476702+00	373	Dennis	Webber		po box 76	Avon, SD	57315	
358	2018-07-28 19:16:34.892593+00	2018-07-28 19:16:34.892655+00	374	Barbie	Hofer		43481 269th St	Bridgewater, SD	57319	
360	2018-07-28 19:19:38.619335+00	2018-07-28 19:19:38.619388+00	377	Tim	Graber		44750 282nd	Marion, SD		
361	2018-07-28 19:19:48.177304+00	2018-07-28 19:20:27.60764+00	376	June	Wipf		20974 396th Ave	Huron	57350	
362	2018-07-28 19:21:13.445852+00	2018-07-28 19:21:13.446477+00	378	Cindy	Graber		43772 283rd	Freeman, SD		
359	2018-07-28 19:17:58.903782+00	2018-07-28 19:21:34.235656+00	375	Ron	Maendl		1645 Riverview Drive	Huron	57350	
\.


--
-- Data for Name: auction_payment; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.auction_payment (id, ctime, mtime, amount, method, transaction_time, note, patron_id) FROM stdin;
1	2018-07-28 14:08:37.162753+00	2018-07-28 14:08:37.162791+00	18.00	CASH	2018-07-28 14:08:37.162872+00		138
2	2018-07-28 14:24:48.554252+00	2018-07-28 14:24:48.554306+00	20.00	CASH	2018-07-28 14:24:48.554463+00		180
3	2018-07-28 14:27:03.079331+00	2018-07-28 14:27:03.079979+00	30.00	CASH	2018-07-28 14:27:03.08057+00		180
4	2018-07-28 15:22:36.775898+00	2018-07-28 15:22:36.775961+00	20.00	CASH	2018-07-28 15:22:36.788607+00		207
5	2018-07-28 15:23:29.477905+00	2018-07-28 15:23:29.477974+00	4.00	CASH	2018-07-28 15:23:29.4792+00		199
6	2018-07-28 15:33:15.471498+00	2018-07-28 15:33:15.472002+00	2.95	CASH	2018-07-28 15:33:15.47213+00		176
7	2018-07-28 15:36:19.720579+00	2018-07-28 15:36:19.72064+00	74.00	CHECK	2018-07-28 15:36:19.720794+00		130
8	2018-07-28 16:18:27.532283+00	2018-07-28 16:18:27.532347+00	12.00	CASH	2018-07-28 16:18:27.532501+00		241
9	2018-07-28 16:20:07.580252+00	2018-07-28 16:20:07.580307+00	0.75	CASH	2018-07-28 16:20:07.580436+00		194
10	2018-07-28 16:26:25.387697+00	2018-07-28 16:26:25.387752+00	5.00	CASH	2018-07-28 16:26:25.38788+00		241
11	2018-07-28 16:30:58.683411+00	2018-07-28 16:30:58.683469+00	55.00	CHECK	2018-07-28 16:30:58.683606+00		198
12	2018-07-28 16:32:10.862163+00	2018-07-28 16:32:10.862226+00	25.50	CHECK	2018-07-28 16:32:10.862438+00		240
13	2018-07-28 16:33:33.262775+00	2018-07-28 16:33:33.262836+00	88.54	CHECK	2018-07-28 16:33:33.262961+00		106
14	2018-07-28 16:39:30.82525+00	2018-07-28 16:39:30.825302+00	15.00	CASH	2018-07-28 16:39:30.825432+00		166
15	2018-07-28 16:51:03.261699+00	2018-07-28 16:51:03.261754+00	10.00	CASH	2018-07-28 16:51:03.261926+00		242
16	2018-07-28 16:52:59.617233+00	2018-07-28 16:52:59.617357+00	20.00	CHECK	2018-07-28 16:52:59.617513+00		25
17	2018-07-28 16:57:38.516635+00	2018-07-28 16:57:38.516697+00	15.00	CASH	2018-07-28 16:57:38.516846+00		180
18	2018-07-28 16:58:28.165449+00	2018-07-28 16:58:28.165552+00	15.00	CASH	2018-07-28 16:58:28.165809+00		239
19	2018-07-28 16:59:41.79454+00	2018-07-28 16:59:41.794595+00	11.00	CASH	2018-07-28 16:59:41.794721+00		167
21	2018-07-28 17:01:28.827743+00	2018-07-28 17:01:28.827802+00	10.00	CASH	2018-07-28 17:01:28.827947+00		145
20	2018-07-28 17:01:17.61667+00	2018-07-28 17:03:00.170582+00	12.00	CASH	2018-07-28 17:01:17.61684+00	Added $6 for Kettle Korn So total amount paid $12	224
23	2018-07-28 17:09:28.361015+00	2018-07-28 17:09:28.361064+00	51.50	CASH	2018-07-28 17:09:28.361178+00		244
24	2018-07-28 17:11:13.679492+00	2018-07-28 17:11:13.67955+00	22.66	CARD	2018-07-28 17:11:13.67971+00		285
25	2018-07-28 17:14:15.157878+00	2018-07-28 17:14:15.158005+00	22.80	CASH	2018-07-28 17:14:15.158396+00		148
26	2018-07-28 17:17:24.424653+00	2018-07-28 17:17:24.424715+00	20.00	CASH	2018-07-28 17:17:24.42487+00		150
27	2018-07-28 17:18:37.080551+00	2018-07-28 17:18:37.080613+00	7.00	CASH	2018-07-28 17:18:37.08076+00		269
28	2018-07-28 17:20:20.876168+00	2018-07-28 17:20:20.87623+00	24.00	CASH	2018-07-28 17:20:20.876373+00		261
29	2018-07-28 17:23:51.363644+00	2018-07-28 17:23:51.363705+00	51.50	CARD	2018-07-28 17:23:51.363858+00		257
30	2018-07-28 17:25:14.975466+00	2018-07-28 17:25:14.975525+00	20.00	CASH	2018-07-28 17:25:14.975659+00		236
31	2018-07-28 17:28:17.80378+00	2018-07-28 17:28:17.80384+00	14.42	CARD	2018-07-28 17:28:17.803988+00		250
32	2018-07-28 17:28:49.528537+00	2018-07-28 17:28:49.528595+00	58.71	CARD	2018-07-28 17:28:49.528752+00		255
33	2018-07-28 17:29:45.140344+00	2018-07-28 17:29:45.1404+00	10.30	CARD	2018-07-28 17:29:45.140576+00		159
34	2018-07-28 17:30:14.612157+00	2018-07-28 17:30:14.612217+00	9.00	CASH	2018-07-28 17:30:14.612359+00		161
35	2018-07-28 17:30:56.221287+00	2018-07-28 17:30:56.221347+00	13.00	CASH	2018-07-28 17:30:56.221486+00		214
36	2018-07-28 17:32:00.439209+00	2018-07-28 17:32:00.439281+00	97.40	CHECK	2018-07-28 17:32:00.439423+00		14
37	2018-07-28 17:37:30.211684+00	2018-07-28 17:37:30.211745+00	10.00	CASH	2018-07-28 17:37:30.2119+00		298
38	2018-07-28 17:38:32.716539+00	2018-07-28 17:38:32.716593+00	53.75	CHECK	2018-07-28 17:38:32.716723+00		188
39	2018-07-28 17:40:49.37412+00	2018-07-28 17:40:49.374176+00	15.00	CASH	2018-07-28 17:40:49.383085+00		280
40	2018-07-28 17:41:49.031348+00	2018-07-28 17:41:49.031409+00	17.00	CASH	2018-07-28 17:41:49.031553+00		288
41	2018-07-28 17:42:35.348686+00	2018-07-28 17:42:35.348746+00	8.00	CASH	2018-07-28 17:42:35.34888+00		286
42	2018-07-28 17:42:49.024979+00	2018-07-28 17:42:49.025038+00	20.00	CASH	2018-07-28 17:42:49.025171+00		287
43	2018-07-28 17:43:21.829182+00	2018-07-28 17:43:21.82924+00	13.00	CASH	2018-07-28 17:43:21.829386+00		282
44	2018-07-28 17:47:05.413132+00	2018-07-28 17:47:05.413191+00	12.00	CASH	2018-07-28 17:47:05.413341+00		306
45	2018-07-28 17:49:53.300368+00	2018-07-28 17:49:53.30043+00	51.00	CASH	2018-07-28 17:49:53.300569+00		277
46	2018-07-28 17:50:28.556465+00	2018-07-28 17:50:28.556527+00	55.00	CHECK	2018-07-28 17:50:28.556662+00		279
47	2018-07-28 17:52:17.649656+00	2018-07-28 17:52:17.64972+00	113.30	CARD	2018-07-28 17:52:17.649878+00		245
48	2018-07-28 17:52:48.169385+00	2018-07-28 17:52:48.169441+00	20.00	CHECK	2018-07-28 17:52:48.169581+00		302
49	2018-07-28 17:53:11.431928+00	2018-07-28 17:53:11.431992+00	10.00	CASH	2018-07-28 17:53:11.432429+00		118
50	2018-07-28 17:53:37.514045+00	2018-07-28 17:53:37.514105+00	51.50	CHECK	2018-07-28 17:53:37.514249+00		266
51	2018-07-28 17:53:41.106088+00	2018-07-28 17:53:41.106141+00	20.00	CASH	2018-07-28 17:53:41.10627+00		243
52	2018-07-28 18:00:15.98588+00	2018-07-28 18:00:15.985944+00	39.50	CHECK	2018-07-28 18:00:15.986097+00		206
53	2018-07-28 18:01:33.161876+00	2018-07-28 18:01:33.161938+00	7.00	CHECK	2018-07-28 18:01:33.162074+00	1416	317
54	2018-07-28 18:02:40.243825+00	2018-07-28 18:02:40.243879+00	10.00	CASH	2018-07-28 18:02:40.243994+00		233
55	2018-07-28 18:07:42.963155+00	2018-07-28 18:07:42.96322+00	28.00	CASH	2018-07-28 18:07:42.963373+00		35
56	2018-07-28 18:08:14.444449+00	2018-07-28 18:08:14.444511+00	25.00	CASH	2018-07-28 18:08:14.44466+00		316
57	2018-07-28 18:10:59.752561+00	2018-07-28 18:10:59.752616+00	25.00	CHECK	2018-07-28 18:10:59.75276+00	1070	268
58	2018-07-28 18:11:18.537371+00	2018-07-28 18:11:18.537427+00	28.00	CASH	2018-07-28 18:11:18.537631+00		262
59	2018-07-28 18:13:32.364074+00	2018-07-28 18:13:32.364133+00	20.15	CASH	2018-07-28 18:13:32.364273+00		348
60	2018-07-28 18:16:28.776378+00	2018-07-28 18:16:28.776447+00	20.00	CASH	2018-07-28 18:16:28.776949+00		90
61	2018-07-28 18:18:26.037069+00	2018-07-28 18:18:26.037126+00	6.00	CASH	2018-07-28 18:18:26.037262+00		305
62	2018-07-28 18:19:10.939623+00	2018-07-28 18:19:10.939681+00	10.00	CASH	2018-07-28 18:19:10.939829+00		278
63	2018-07-28 18:19:57.919883+00	2018-07-28 18:19:57.919942+00	40.00	CASH	2018-07-28 18:19:57.920082+00		138
64	2018-07-28 18:21:56.457536+00	2018-07-28 18:21:56.457708+00	26.00	CHECK	2018-07-28 18:21:56.458805+00		11
66	2018-07-28 18:23:30.009357+00	2018-07-28 18:23:30.009414+00	30.00	CASH	2018-07-28 18:23:30.009542+00		297
67	2018-07-28 18:24:14.875252+00	2018-07-28 18:24:14.875307+00	10.00	CASH	2018-07-28 18:24:14.875449+00		267
65	2018-07-28 18:23:25.218359+00	2018-07-28 18:24:35.797804+00	100.00	CHECK	2018-07-28 18:23:25.218576+00	3021	179
68	2018-07-28 18:26:45.571322+00	2018-07-28 18:26:45.571382+00	12.88	CARD	2018-07-28 18:26:45.57153+00		309
69	2018-07-28 18:27:50.021079+00	2018-07-28 18:29:44.915409+00	50.00	CHECK	2018-07-28 18:27:50.021292+00		321
70	2018-07-28 18:30:18.882869+00	2018-07-28 18:30:18.882916+00	20.00	CASH	2018-07-28 18:30:18.883174+00		209
71	2018-07-28 18:31:16.049508+00	2018-07-28 18:31:16.04957+00	12.00	CASH	2018-07-28 18:31:16.049718+00		351
72	2018-07-28 18:31:17.495357+00	2018-07-28 18:31:17.495412+00	10.00	CASH	2018-07-28 18:31:17.495546+00		341
73	2018-07-28 18:31:25.503626+00	2018-07-28 18:31:25.50368+00	20.00	CASH	2018-07-28 18:31:25.503806+00		263
74	2018-07-28 18:32:32.989038+00	2018-07-28 18:32:32.989094+00	50.00	CHECK	2018-07-28 18:32:32.989215+00		276
75	2018-07-28 18:33:06.815324+00	2018-07-28 18:33:06.815772+00	25.00	CASH	2018-07-28 18:33:06.81648+00		160
76	2018-07-28 18:36:04.784853+00	2018-07-28 18:36:04.784915+00	21.00	CASH	2018-07-28 18:36:04.785064+00		293
77	2018-07-28 18:37:15.346771+00	2018-07-28 18:37:15.346823+00	118.45	CARD	2018-07-28 18:37:15.346959+00		253
78	2018-07-28 18:37:15.765878+00	2018-07-28 18:37:15.765934+00	13.00	CASH	2018-07-28 18:37:15.766069+00		281
79	2018-07-28 18:37:49.140905+00	2018-07-28 18:37:49.140963+00	69.00	CHECK	2018-07-28 18:37:49.141109+00	1044	204
80	2018-07-28 18:42:05.800883+00	2018-07-28 18:42:05.800945+00	8.00	CASH	2018-07-28 18:42:05.801084+00		353
81	2018-07-28 18:43:08.23393+00	2018-07-28 18:43:08.233974+00	33.99	CARD	2018-07-28 18:43:08.234087+00		113
82	2018-07-28 18:43:48.909416+00	2018-07-28 18:43:48.909857+00	15.00	CASH	2018-07-28 18:43:48.910005+00		284
83	2018-07-28 18:44:25.492851+00	2018-07-28 18:44:25.49291+00	50.74	CHECK	2018-07-28 18:44:25.49304+00		168
84	2018-07-28 18:45:18.780914+00	2018-07-28 18:45:18.780971+00	5.00	CASH	2018-07-28 18:45:18.781112+00		320
85	2018-07-28 18:46:31.308135+00	2018-07-28 18:46:31.308194+00	138.00	CHECK	2018-07-28 18:46:31.308339+00		271
86	2018-07-28 18:47:24.121481+00	2018-07-28 18:47:24.121538+00	21.00	CASH	2018-07-28 18:47:24.12167+00		349
87	2018-07-28 18:48:49.256618+00	2018-07-28 18:48:49.256813+00	538.00	CHECK	2018-07-28 18:48:49.256959+00		190
88	2018-07-28 18:51:28.237719+00	2018-07-28 18:51:28.237777+00	22.00	CASH	2018-07-28 18:51:28.237915+00		329
89	2018-07-28 18:53:19.658191+00	2018-07-28 18:53:19.658238+00	58.00	CASH	2018-07-28 18:53:19.658343+00		163
90	2018-07-28 18:53:49.152851+00	2018-07-28 18:53:49.152915+00	10.00	CASH	2018-07-28 18:53:49.153058+00		162
91	2018-07-28 18:55:48.830465+00	2018-07-28 18:55:48.830527+00	50.50	CASH	2018-07-28 18:55:48.830673+00		331
92	2018-07-28 18:56:28.338167+00	2018-07-28 18:56:28.338218+00	18.00	CASH	2018-07-28 18:56:28.338346+00		291
93	2018-07-28 18:58:34.74791+00	2018-07-28 18:58:34.747971+00	3.00	CASH	2018-07-28 18:58:34.74811+00		325
94	2018-07-28 19:02:32.62836+00	2018-07-28 19:02:32.628422+00	220.00	CHECK	2018-07-28 19:02:32.628563+00		228
95	2018-07-28 19:02:50.472425+00	2018-07-28 19:02:50.472487+00	21.75	CASH	2018-07-28 19:02:50.472637+00		227
96	2018-07-28 19:04:14.146565+00	2018-07-28 19:04:14.14662+00	16.00	CASH	2018-07-28 19:04:14.146757+00		157
97	2018-07-28 19:04:43.358637+00	2018-07-28 19:04:43.358692+00	15.00	CASH	2018-07-28 19:04:43.358819+00		347
98	2018-07-28 19:05:07.108549+00	2018-07-28 19:05:07.108611+00	9.00	CASH	2018-07-28 19:05:07.108746+00		350
99	2018-07-28 19:07:52.935755+00	2018-07-28 19:07:52.935828+00	74.16	CARD	2018-07-28 19:07:52.936055+00		140
100	2018-07-28 19:09:09.73703+00	2018-07-28 19:09:09.737142+00	10.00	CASH	2018-07-28 19:09:09.737713+00		324
102	2018-07-28 19:11:53.980081+00	2018-07-28 19:11:53.980163+00	73.95	CHECK	2018-07-28 19:11:53.980316+00		101
103	2018-07-28 19:14:42.933494+00	2018-07-28 19:14:42.933554+00	600.00	CASH	2018-07-28 19:14:42.933702+00		313
104	2018-07-28 19:15:26.567609+00	2018-07-28 19:15:26.567673+00	20.00	CHECK	2018-07-28 19:15:26.567937+00		119
101	2018-07-28 19:10:58.348302+00	2018-07-28 19:24:08.015962+00	288.00	CHECK	2018-07-28 19:10:58.348454+00		93
105	2018-07-28 19:27:06.656487+00	2018-07-28 19:27:06.656547+00	216.00	CASH	2018-07-28 19:27:06.656689+00		234
106	2018-07-28 19:27:15.78565+00	2018-07-28 19:27:15.785709+00	47.38	CARD	2018-07-28 19:27:15.785849+00		32
107	2018-07-28 19:28:19.003278+00	2018-07-28 19:28:19.003341+00	103.00	CHECK	2018-07-28 19:28:19.003493+00		182
108	2018-07-28 19:32:43.099136+00	2018-07-28 19:32:43.099205+00	444.50	CHECK	2018-07-28 19:32:43.099374+00		12
109	2018-07-28 19:33:34.709371+00	2018-07-28 19:33:34.709422+00	50.00	CASH	2018-07-28 19:33:34.709554+00		311
110	2018-07-28 19:33:45.329203+00	2018-07-28 19:33:45.329266+00	25.00	CASH	2018-07-28 19:33:45.329412+00		312
111	2018-07-28 19:36:13.354891+00	2018-07-28 19:36:13.354983+00	13.00	CASH	2018-07-28 19:36:13.355342+00		335
112	2018-07-28 19:36:49.019809+00	2018-07-28 19:36:49.019873+00	58.00	CHECK	2018-07-28 19:36:49.020024+00		337
113	2018-07-28 19:37:10.590057+00	2018-07-28 19:37:10.590116+00	210.00	CHECK	2018-07-28 19:37:10.590266+00		270
114	2018-07-28 19:38:19.156373+00	2018-07-28 19:38:19.156438+00	110.00	CHECK	2018-07-28 19:38:19.156849+00		249
115	2018-07-28 19:38:38.019621+00	2018-07-28 19:38:38.019677+00	36.05	CARD	2018-07-28 19:38:38.019818+00		246
116	2018-07-28 19:39:56.329629+00	2018-07-28 19:39:56.329692+00	45.00	CHECK	2018-07-28 19:39:56.340705+00		231
117	2018-07-28 19:40:17.645841+00	2018-07-28 19:40:17.645904+00	40.00	CHECK	2018-07-28 19:40:17.646047+00		318
118	2018-07-28 19:40:48.383346+00	2018-07-28 19:40:48.38341+00	12.00	CASH	2018-07-28 19:40:48.383558+00		357
119	2018-07-28 19:41:12.900344+00	2018-07-28 19:41:12.900403+00	320.00	CHECK	2018-07-28 19:41:12.900626+00		295
120	2018-07-28 19:41:28.772635+00	2018-07-28 19:41:28.772697+00	40.00	CASH	2018-07-28 19:41:28.77285+00		170
121	2018-07-28 19:41:59.930803+00	2018-07-28 19:41:59.930859+00	20.00	CASH	2018-07-28 19:41:59.931225+00		28
122	2018-07-28 19:42:45.531239+00	2018-07-28 19:42:45.531314+00	25.00	CHECK	2018-07-28 19:42:45.531483+00		202
123	2018-07-28 19:44:35.384505+00	2018-07-28 19:44:35.384578+00	1176.00	CHECK	2018-07-28 19:44:35.384723+00		120
124	2018-07-28 19:44:56.372438+00	2018-07-28 19:44:56.372487+00	900.00	CHECK	2018-07-28 19:44:56.373226+00		342
125	2018-07-28 19:45:22.036625+00	2018-07-28 19:45:22.036692+00	75.00	CHECK	2018-07-28 19:45:22.036841+00		185
126	2018-07-28 19:45:56.111217+00	2018-07-28 19:45:56.111278+00	11.00	CHECK	2018-07-28 19:45:56.111421+00		192
127	2018-07-28 19:47:04.215544+00	2018-07-28 19:47:04.215608+00	136.30	CHECK	2018-07-28 19:47:04.215749+00		175
128	2018-07-28 19:47:16.969299+00	2018-07-28 19:47:16.969357+00	834.50	CHECK	2018-07-28 19:47:16.969496+00		105
129	2018-07-28 19:48:53.352648+00	2018-07-28 19:48:53.352708+00	13.00	CHECK	2018-07-28 19:48:53.352855+00		332
130	2018-07-28 19:50:03.884602+00	2018-07-28 19:50:03.884663+00	500.00	CHECK	2018-07-28 19:50:03.884809+00		39
131	2018-07-28 19:51:28.667783+00	2018-07-28 19:51:28.667845+00	27.00	CHECK	2018-07-28 19:51:28.667991+00		223
132	2018-07-28 19:51:53.116482+00	2018-07-28 19:51:53.116543+00	10.00	CASH	2018-07-28 19:51:53.116679+00		339
133	2018-07-28 19:52:09.498658+00	2018-07-28 19:52:09.498724+00	20.00	CASH	2018-07-28 19:52:09.499142+00		310
134	2018-07-28 19:52:11.113308+00	2018-07-28 19:52:11.113356+00	8.24	CARD	2018-07-28 19:52:11.113479+00		334
135	2018-07-28 19:53:03.514872+00	2018-07-28 19:53:03.514935+00	8.00	CASH	2018-07-28 19:53:03.515103+00		308
136	2018-07-28 19:53:11.999585+00	2018-07-28 19:53:11.999635+00	125.66	CARD	2018-07-28 19:53:11.999765+00		20
137	2018-07-28 19:53:35.46037+00	2018-07-28 19:53:35.460425+00	336.00	CHECK	2018-07-28 19:53:35.460555+00		8
138	2018-07-28 19:53:57.437853+00	2018-07-28 19:53:57.43791+00	37.00	CASH	2018-07-28 19:53:57.438048+00		152
139	2018-07-28 19:54:24.285127+00	2018-07-28 19:54:24.285192+00	331.66	CARD	2018-07-28 19:54:24.285355+00		229
141	2018-07-28 19:55:49.653967+00	2018-07-28 19:55:49.654025+00	51.50	CHECK	2018-07-28 19:55:49.654155+00		187
142	2018-07-28 19:56:02.830339+00	2018-07-28 19:56:02.830407+00	206.00	CHECK	2018-07-28 19:56:02.835125+00		117
143	2018-07-28 19:56:59.892022+00	2018-07-28 19:56:59.892079+00	75.00	CHECK	2018-07-28 19:56:59.892208+00		154
144	2018-07-28 19:57:43.83525+00	2018-07-28 19:57:43.835313+00	288.92	CARD	2018-07-28 19:57:43.837782+00		174
146	2018-07-28 19:58:17.777027+00	2018-07-28 19:58:17.779463+00	40.50	CASH	2018-07-28 19:58:17.782237+00		116
147	2018-07-28 19:58:55.353652+00	2018-07-28 19:58:55.353711+00	17.00	CHECK	2018-07-28 19:58:55.35388+00		183
148	2018-07-28 19:59:20.773359+00	2018-07-28 19:59:20.773422+00	45.00	CASH	2018-07-28 19:59:20.773652+00		336
149	2018-07-28 19:59:33.671036+00	2018-07-28 19:59:33.671087+00	512.00	CHECK	2018-07-28 19:59:33.6712+00		55
150	2018-07-28 20:00:11.140334+00	2018-07-28 20:00:11.140395+00	30.00	CASH	2018-07-28 20:00:11.140875+00		267
151	2018-07-28 20:00:57.495572+00	2018-07-28 20:00:57.495648+00	285.00	CHECK	2018-07-28 20:00:57.498058+00		55
152	2018-07-28 20:02:20.443184+00	2018-07-28 20:02:20.443255+00	34.00	CHECK	2018-07-28 20:02:20.443397+00		45
153	2018-07-28 20:02:43.326649+00	2018-07-28 20:02:43.326709+00	50.00	CHECK	2018-07-28 20:02:43.326852+00		34
154	2018-07-28 20:03:04.453815+00	2018-07-28 20:03:04.453875+00	25.00	CHECK	2018-07-28 20:03:04.454026+00		204
155	2018-07-28 20:03:04.576608+00	2018-07-28 20:03:04.576673+00	25.00	CHECK	2018-07-28 20:03:04.576811+00		204
156	2018-07-28 20:03:43.708623+00	2018-07-28 20:03:43.708676+00	16.48	CARD	2018-07-28 20:03:43.708809+00		222
157	2018-07-28 20:04:58.64843+00	2018-07-28 20:04:58.648489+00	104.00	CHECK	2018-07-28 20:04:58.648625+00		126
158	2018-07-28 20:05:14.972926+00	2018-07-28 20:05:14.97299+00	22.66	CARD	2018-07-28 20:05:14.974126+00		343
159	2018-07-28 20:05:54.180407+00	2018-07-28 20:05:54.180852+00	158.62	CARD	2018-07-28 20:05:54.182072+00		273
160	2018-07-28 20:06:03.822263+00	2018-07-28 20:06:03.822328+00	30.00	CHECK	2018-07-28 20:06:03.823866+00		272
161	2018-07-28 20:06:55.468454+00	2018-07-28 20:06:55.468517+00	160.00	CHECK	2018-07-28 20:06:55.46865+00		221
162	2018-07-28 20:08:15.667602+00	2018-07-28 20:08:15.667655+00	122.13	CARD	2018-07-28 20:08:15.667832+00		220
163	2018-07-28 20:08:44.921075+00	2018-07-28 20:08:44.921147+00	76.00	CHECK	2018-07-28 20:08:44.92129+00		301
164	2018-07-28 20:09:11.623633+00	2018-07-28 20:09:11.623693+00	2798.04	CARD	2018-07-28 20:09:11.623838+00		4
165	2018-07-28 20:09:34.57397+00	2018-07-28 20:09:34.57403+00	322.00	CHECK	2018-07-28 20:09:34.574168+00		91
166	2018-07-28 20:10:10.519158+00	2018-07-28 20:10:10.519204+00	25.75	CARD	2018-07-28 20:10:10.519318+00		327
167	2018-07-28 20:10:22.162888+00	2018-07-28 20:10:22.162951+00	760.00	CHECK	2018-07-28 20:10:22.163128+00		30
168	2018-07-28 20:10:46.647381+00	2018-07-28 20:10:46.647435+00	500.00	CASH	2018-07-28 20:10:46.647551+00		142
169	2018-07-28 20:11:04.895528+00	2018-07-28 20:11:04.895582+00	12.36	CARD	2018-07-28 20:11:04.895714+00		226
170	2018-07-28 20:12:23.283208+00	2018-07-28 20:12:23.283263+00	40.00	CASH	2018-07-28 20:12:23.283397+00		340
171	2018-07-28 20:12:55.097475+00	2018-07-28 20:12:55.097979+00	30.00	CHECK	2018-07-28 20:12:55.098369+00		169
172	2018-07-28 20:13:18.006006+00	2018-07-28 20:13:18.006062+00	30.90	CARD	2018-07-28 20:13:18.006225+00		70
173	2018-07-28 20:14:32.628335+00	2018-07-28 20:14:32.628394+00	20.00	CASH	2018-07-28 20:14:32.628532+00		92
174	2018-07-28 20:15:01.798836+00	2018-07-28 20:15:01.798897+00	118.45	CARD	2018-07-28 20:15:01.805222+00		158
175	2018-07-28 20:15:33.311699+00	2018-07-28 20:15:33.311764+00	337.84	CARD	2018-07-28 20:15:33.311915+00		96
176	2018-07-28 20:15:48.323139+00	2018-07-28 20:15:48.323193+00	74.16	CARD	2018-07-28 20:15:48.323325+00		156
177	2018-07-28 20:15:54.393252+00	2018-07-28 20:15:54.393314+00	235.00	CASH	2018-07-28 20:15:54.393461+00		322
178	2018-07-28 20:16:36.003744+00	2018-07-28 20:16:36.003802+00	49.62	CHECK	2018-07-28 20:16:36.003941+00		344
179	2018-07-28 20:18:18.056914+00	2018-07-28 20:18:18.056981+00	93.73	CARD	2018-07-28 20:18:18.057143+00		144
180	2018-07-28 20:21:07.61161+00	2018-07-28 20:21:07.611672+00	14.00	CASH	2018-07-28 20:21:07.611816+00		146
181	2018-07-28 20:22:31.155236+00	2018-07-28 20:22:31.155294+00	130.81	CARD	2018-07-28 20:22:31.155442+00		13
182	2018-07-28 20:25:29.624927+00	2018-07-28 20:25:29.624988+00	20.00	CHECK	2018-07-28 20:25:29.625128+00	210 & 214 together	219
183	2018-07-28 20:25:40.188117+00	2018-07-28 20:25:40.188175+00	159.60	CARD	2018-07-28 20:25:40.18831+00		230
184	2018-07-28 20:25:52.823963+00	2018-07-28 20:25:52.824027+00	40.00	CHECK	2018-07-28 20:25:52.824167+00	210 & 214 together	218
185	2018-07-28 20:26:18.120013+00	2018-07-28 20:26:18.120075+00	114.00	CASH	2018-07-28 20:26:18.120216+00		275
186	2018-07-28 20:27:03.841945+00	2018-07-28 20:27:03.841998+00	450.00	CHECK	2018-07-28 20:27:03.842125+00		149
187	2018-07-28 20:27:25.620575+00	2018-07-28 20:27:25.62063+00	338.00	CHECK	2018-07-28 20:27:25.620755+00		72
189	2018-07-28 20:28:04.04096+00	2018-07-28 20:28:04.041018+00	50.00	CHECK	2018-07-28 20:28:04.041165+00		251
190	2018-07-28 20:28:31.437548+00	2018-07-28 20:28:31.437643+00	552.08	CARD	2018-07-28 20:28:31.437823+00		38
191	2018-07-28 20:29:29.358131+00	2018-07-28 20:29:29.358188+00	12.00	CHECK	2018-07-28 20:29:29.358329+00		323
192	2018-07-28 20:29:30.626518+00	2018-07-28 20:29:30.626581+00	25.00	CHECK	2018-07-28 20:29:30.627403+00		212
193	2018-07-28 20:29:56.678822+00	2018-07-28 20:29:56.67888+00	51.50	CARD	2018-07-28 20:29:56.68042+00		215
194	2018-07-28 20:30:41.605782+00	2018-07-28 20:30:41.605842+00	35.65	CHECK	2018-07-28 20:30:41.605988+00	co-payment with #151/#152	165
195	2018-07-28 20:31:25.5871+00	2018-07-28 20:31:25.587155+00	220.00	CHECK	2018-07-28 20:31:25.587277+00	co-payment with #151/#152	164
196	2018-07-28 20:31:45.124855+00	2018-07-28 20:31:45.124905+00	17.00	CASH	2018-07-28 20:31:45.125024+00		294
197	2018-07-28 20:33:41.465887+00	2018-07-28 20:33:41.465941+00	369.00	CHECK	2018-07-28 20:33:41.466079+00		238
198	2018-07-28 20:33:50.732264+00	2018-07-28 20:33:50.732317+00	400.00	CHECK	2018-07-28 20:33:50.732444+00		211
199	2018-07-28 20:34:31.277499+00	2018-07-28 20:34:31.277556+00	20.00	CASH	2018-07-28 20:34:31.2777+00		115
200	2018-07-28 20:35:07.271426+00	2018-07-28 20:35:07.27149+00	43.00	CHECK	2018-07-28 20:35:07.271687+00		314
201	2018-07-28 20:36:08.808632+00	2018-07-28 20:36:08.808693+00	24.00	CASH	2018-07-28 20:36:08.808837+00		181
202	2018-07-28 20:36:14.244739+00	2018-07-28 20:36:14.244796+00	62.00	CHECK	2018-07-28 20:36:14.244941+00		56
203	2018-07-28 20:37:18.493828+00	2018-07-28 20:37:18.493889+00	156.00	CHECK	2018-07-28 20:37:18.494084+00		303
204	2018-07-28 20:37:25.540927+00	2018-07-28 20:37:25.540977+00	479.00	CHECK	2018-07-28 20:37:25.541094+00	Included $210 for wooden eggs Pete Preheim	9
205	2018-07-28 20:37:43.302343+00	2018-07-28 20:37:43.302401+00	70.00	CHECK	2018-07-28 20:37:43.302523+00		211
206	2018-07-28 20:38:51.799656+00	2018-07-28 20:38:51.799715+00	22.00	CHECK	2018-07-28 20:38:51.799898+00		147
207	2018-07-28 20:38:56.040969+00	2018-07-28 20:38:56.041033+00	142.00	CHECK	2018-07-28 20:38:56.041184+00		217
208	2018-07-28 20:39:18.007645+00	2018-07-28 20:39:18.007716+00	11.00	CASH	2018-07-28 20:39:18.00787+00		108
209	2018-07-28 20:40:02.364405+00	2018-07-28 20:40:02.36447+00	684.95	CARD	2018-07-28 20:40:02.364681+00		260
210	2018-07-28 20:40:35.497434+00	2018-07-28 20:40:35.497514+00	105.00	CHECK	2018-07-28 20:40:35.497653+00		319
211	2018-07-28 20:40:41.511892+00	2018-07-28 20:40:41.512006+00	0.00	CHECK	2018-07-28 20:40:41.512155+00		319
212	2018-07-28 20:41:09.790007+00	2018-07-28 20:41:09.790167+00	237.00	CHECK	2018-07-28 20:41:09.791114+00		265
213	2018-07-28 20:41:11.32454+00	2018-07-28 20:41:11.324599+00	240.00	CHECK	2018-07-28 20:41:11.324742+00		315
214	2018-07-28 20:41:46.100217+00	2018-07-28 20:41:46.100269+00	65.00	CHECK	2018-07-28 20:41:46.100394+00		26
215	2018-07-28 20:42:10.316951+00	2018-07-28 20:42:10.317017+00	41.20	CARD	2018-07-28 20:42:10.317212+00		178
216	2018-07-28 20:42:47.599537+00	2018-07-28 20:42:47.599591+00	8.00	CASH	2018-07-28 20:42:47.599716+00		184
217	2018-07-28 20:43:03.472748+00	2018-07-28 20:43:03.472811+00	12.00	CHECK	2018-07-28 20:43:03.472962+00		258
218	2018-07-28 20:43:05.649973+00	2018-07-28 20:43:05.650035+00	84.00	CHECK	2018-07-28 20:43:05.650173+00		103
219	2018-07-28 20:43:51.268727+00	2018-07-28 20:43:51.268789+00	90.00	CHECK	2018-07-28 20:43:51.268951+00		330
220	2018-07-28 20:44:20.293348+00	2018-07-28 20:44:20.293408+00	6.00	CASH	2018-07-28 20:44:20.293555+00		237
221	2018-07-28 20:44:25.658925+00	2018-07-28 20:44:25.658976+00	41.00	CHECK	2018-07-28 20:44:25.659149+00		197
222	2018-07-28 20:44:38.302587+00	2018-07-28 20:44:38.302866+00	71.00	CHECK	2018-07-28 20:44:38.303337+00		235
223	2018-07-28 20:45:11.99773+00	2018-07-28 20:45:11.997782+00	76.83	CHECK	2018-07-28 20:45:11.997904+00		80
224	2018-07-28 20:45:34.501283+00	2018-07-28 20:45:34.501338+00	235.00	CHECK	2018-07-28 20:45:34.50147+00		292
225	2018-07-28 20:46:14.549975+00	2018-07-28 20:46:14.550027+00	49.95	CARD	2018-07-28 20:46:14.550435+00		95
226	2018-07-28 20:46:33.158092+00	2018-07-28 20:46:33.158152+00	16.48	CARD	2018-07-28 20:46:33.158292+00		37
227	2018-07-28 20:47:45.580466+00	2018-07-28 20:47:45.580525+00	2490.00	CHECK	2018-07-28 20:47:45.580669+00		59
228	2018-07-28 20:48:10.178631+00	2018-07-28 20:48:10.178692+00	56.75	CARD	2018-07-28 20:48:10.178837+00		354
229	2018-07-28 20:48:49.388454+00	2018-07-28 20:48:49.388525+00	138.02	CARD	2018-07-28 20:48:49.388682+00		193
230	2018-07-28 20:49:22.023675+00	2018-07-28 20:49:22.023742+00	11.33	CARD	2018-07-28 20:49:22.023938+00		195
231	2018-07-28 20:49:31.228773+00	2018-07-28 20:49:31.229069+00	771.00	CHECK	2018-07-28 20:49:31.229223+00		139
232	2018-07-28 20:49:58.346335+00	2018-07-28 20:49:58.34639+00	2559.30	CHECK	2018-07-28 20:49:58.346522+00	chk 8243	99
233	2018-07-28 20:50:17.06729+00	2018-07-28 20:50:17.067356+00	85.00	CHECK	2018-07-28 20:50:17.067496+00		132
234	2018-07-28 20:50:22.889493+00	2018-07-28 20:50:22.88957+00	73.16	CARD	2018-07-28 20:50:22.889729+00		355
235	2018-07-28 20:50:53.792421+00	2018-07-28 20:50:53.792486+00	248.00	CHECK	2018-07-28 20:50:53.793381+00	chk 8243	171
236	2018-07-28 20:51:08.229506+00	2018-07-28 20:51:08.229564+00	200.00	CHECK	2018-07-28 20:51:08.229827+00		134
237	2018-07-28 20:51:34.162845+00	2018-07-28 20:51:34.162907+00	33.19	CARD	2018-07-28 20:51:34.163099+00		345
238	2018-07-28 20:52:13.998933+00	2018-07-28 20:52:13.999038+00	34.25	CHECK	2018-07-28 20:52:13.999184+00		153
239	2018-07-28 20:53:33.735418+00	2018-07-28 20:53:33.735467+00	1852.00	CHECK	2018-07-28 20:53:33.735587+00		290
240	2018-07-28 20:53:48.593888+00	2018-07-28 20:53:48.593948+00	78.00	CHECK	2018-07-28 20:53:48.594482+00		2
241	2018-07-28 20:53:58.679577+00	2018-07-28 20:53:58.679634+00	580.46	CARD	2018-07-28 20:53:58.679773+00	additional $500.00 was donation bid	29
242	2018-07-28 20:54:12.076397+00	2018-07-28 20:54:12.076462+00	37.00	CASH	2018-07-28 20:54:12.077322+00		274
243	2018-07-28 20:54:31.004798+00	2018-07-28 20:54:31.004855+00	600.00	CHECK	2018-07-28 20:54:31.00501+00		60
244	2018-07-28 20:54:57.528494+00	2018-07-28 20:54:57.52855+00	25.00	CASH	2018-07-28 20:54:57.528707+00		177
245	2018-07-28 20:54:58.896359+00	2018-07-28 20:54:58.896415+00	35.00	CHECK	2018-07-28 20:54:58.896546+00		264
246	2018-07-28 20:55:23.581872+00	2018-07-28 20:55:23.581928+00	372.86	CARD	2018-07-28 20:55:23.582165+00		81
247	2018-07-28 20:56:21.549743+00	2018-07-28 20:56:21.549797+00	218.36	CARD	2018-07-28 20:56:21.549934+00		1
248	2018-07-28 20:57:05.457508+00	2018-07-28 20:57:05.457566+00	851.50	CHECK	2018-07-28 20:57:05.457708+00		83
249	2018-07-28 20:58:02.92826+00	2018-07-28 20:58:02.928319+00	715.85	CARD	2018-07-28 20:58:02.928502+00		62
250	2018-07-28 20:58:02.936346+00	2018-07-28 20:58:02.936403+00	61.75	CHECK	2018-07-28 20:58:02.936534+00		58
251	2018-07-28 20:59:39.600984+00	2018-07-28 20:59:39.601076+00	746.75	CARD	2018-07-28 20:59:39.601235+00		133
252	2018-07-28 21:00:19.812457+00	2018-07-28 21:00:19.812521+00	10.00	CASH	2018-07-28 21:00:19.812666+00		299
253	2018-07-28 21:00:32.861362+00	2018-07-28 21:00:32.861424+00	910.00	CHECK	2018-07-28 21:00:32.861564+00		296
254	2018-07-28 21:00:48.785714+00	2018-07-28 21:00:48.786512+00	19.57	CARD	2018-07-28 21:00:48.787254+00		333
255	2018-07-28 21:02:12.100198+00	2018-07-28 21:02:12.10026+00	97.85	CARD	2018-07-28 21:02:12.100413+00		289
256	2018-07-28 21:06:03.713253+00	2018-07-28 21:06:03.713315+00	108.00	CHECK	2018-07-28 21:06:03.714235+00		3
257	2018-07-28 21:07:27.238314+00	2018-07-28 21:07:27.23837+00	11.00	CASH	2018-07-28 21:07:27.238503+00		256
258	2018-07-28 21:08:06.812379+00	2018-07-28 21:08:06.812438+00	39.00	CHECK	2018-07-28 21:08:06.812574+00		307
259	2018-07-28 21:08:17.891394+00	2018-07-28 21:08:17.891455+00	20.60	CARD	2018-07-28 21:08:17.891618+00		326
260	2018-07-28 21:08:33.200671+00	2018-07-28 21:08:33.200722+00	90.00	CHECK	2018-07-28 21:08:33.200849+00		98
261	2018-07-28 21:09:09.931327+00	2018-07-28 21:09:09.931389+00	77.77	CARD	2018-07-28 21:09:09.931546+00		143
262	2018-07-28 21:17:42.234676+00	2018-07-28 21:17:42.234733+00	602.00	CHECK	2018-07-28 21:17:42.234871+00		27
263	2018-07-28 21:20:17.826848+00	2018-07-28 21:20:17.826912+00	10.00	CASH	2018-07-28 21:20:17.827097+00		173
264	2018-07-28 21:26:55.869068+00	2018-07-28 21:26:55.869123+00	4020.00	CHECK	2018-07-28 21:26:55.869256+00		123
265	2018-07-28 21:32:38.549367+00	2018-07-28 21:32:38.549427+00	150.00	CHECK	2018-07-28 21:32:38.549581+00		278
266	2018-07-28 21:58:15.572899+00	2018-07-28 21:58:15.572958+00	60.00	CASH	2018-07-28 21:58:15.573101+00		62
\.


--
-- Data for Name: auction_priceditem; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.auction_priceditem (id, ctime, mtime, name, long_desc, sale_time, fair_market_value, is_purchased, booth_id, purchase_id) FROM stdin;
1	2018-07-28 13:01:26.442107+00	2018-07-28 13:01:26.446827+00	Priced Item(s)		2018-07-28 13:01:26.44656+00	20.00	t	5	1
2	2018-07-28 13:02:04.341516+00	2018-07-28 13:02:04.346344+00	Priced Item(s)		2018-07-28 13:02:04.346167+00	15.00	t	5	2
3	2018-07-28 13:09:37.207979+00	2018-07-28 13:09:37.22356+00	Priced Item(s)		2018-07-28 13:09:37.223291+00	20.00	t	5	3
4	2018-07-28 13:10:21.408149+00	2018-07-28 13:10:21.411686+00	Priced Item(s)		2018-07-28 13:10:21.411521+00	80.00	t	5	4
5	2018-07-28 13:13:31.555785+00	2018-07-28 13:13:31.565607+00	Priced Item(s)		2018-07-28 13:13:31.565114+00	15.00	t	5	5
6	2018-07-28 13:15:49.724993+00	2018-07-28 13:15:49.734242+00	Priced Item(s)		2018-07-28 13:15:49.731879+00	10.00	t	5	6
7	2018-07-28 13:20:09.794633+00	2018-07-28 13:20:09.798179+00	Priced Item(s)		2018-07-28 13:20:09.798012+00	10.00	t	5	7
8	2018-07-28 13:21:36.827621+00	2018-07-28 13:21:36.851605+00	Priced Item(s)		2018-07-28 13:21:36.851291+00	10.00	t	5	8
9	2018-07-28 13:32:37.523697+00	2018-07-28 13:32:37.5285+00	Priced Item(s)		2018-07-28 13:32:37.528298+00	35.00	t	5	9
10	2018-07-28 13:34:15.417779+00	2018-07-28 13:34:15.431497+00	Priced Item(s)		2018-07-28 13:34:15.431233+00	5.00	t	5	10
11	2018-07-28 13:35:59.476651+00	2018-07-28 13:35:59.4825+00	Priced Item(s)		2018-07-28 13:35:59.482022+00	15.00	t	5	11
12	2018-07-28 13:40:19.672385+00	2018-07-28 13:40:19.679476+00	Priced Item(s)		2018-07-28 13:40:19.679193+00	30.00	t	5	12
13	2018-07-28 13:52:43.900961+00	2018-07-28 13:52:43.909459+00	Priced Item(s)		2018-07-28 13:52:43.909209+00	139.00	t	3	13
14	2018-07-28 13:53:41.91504+00	2018-07-28 13:53:41.999582+00	Priced Item(s)		2018-07-28 13:53:41.9993+00	100.00	t	5	14
15	2018-07-28 13:58:42.542383+00	2018-07-28 13:58:42.546581+00	Priced Item(s)		2018-07-28 13:58:42.546115+00	25.00	t	5	15
16	2018-07-28 13:59:13.424267+00	2018-07-28 13:59:13.431498+00	Priced Item(s)		2018-07-28 13:59:13.431256+00	1.00	t	3	16
17	2018-07-28 14:00:03.710735+00	2018-07-28 14:00:03.720666+00	Priced Item(s)		2018-07-28 14:00:03.720502+00	10.00	t	5	17
18	2018-07-28 14:01:26.203781+00	2018-07-28 14:01:26.219572+00	Priced Item(s)		2018-07-28 14:01:26.219298+00	40.00	t	5	18
19	2018-07-28 14:02:44.629253+00	2018-07-28 14:02:44.646796+00	Priced Item(s)		2018-07-28 14:02:44.646544+00	15.00	t	5	19
20	2018-07-28 14:03:00.216394+00	2018-07-28 14:03:00.222647+00	Priced Item(s)		2018-07-28 14:03:00.222041+00	30.00	t	5	20
21	2018-07-28 14:03:11.761558+00	2018-07-28 14:03:11.766288+00	Priced Item(s)		2018-07-28 14:03:11.766083+00	18.00	t	1	21
22	2018-07-28 14:03:56.663623+00	2018-07-28 14:03:56.672804+00	Priced Item(s)		2018-07-28 14:03:56.670993+00	26.00	t	4	22
23	2018-07-28 14:05:19.26726+00	2018-07-28 14:05:19.275301+00	Priced Item(s)		2018-07-28 14:05:19.274659+00	9.00	t	5	23
24	2018-07-28 14:06:15.060223+00	2018-07-28 14:06:15.071316+00	Priced Item(s)		2018-07-28 14:06:15.071013+00	40.00	t	1	24
25	2018-07-28 14:07:18.910034+00	2018-07-28 14:07:18.913828+00	Priced Item(s)		2018-07-28 14:07:18.913619+00	100.00	t	3	25
26	2018-07-28 14:07:56.57083+00	2018-07-28 14:07:56.577096+00	Priced Item(s)		2018-07-28 14:07:56.576832+00	35.00	t	1	26
27	2018-07-28 14:09:01.114694+00	2018-07-28 14:09:01.119999+00	Priced Item(s)		2018-07-28 14:09:01.119662+00	26.00	t	1	27
28	2018-07-28 14:09:27.497939+00	2018-07-28 14:09:27.503451+00	Priced Item(s)		2018-07-28 14:09:27.50323+00	20.00	t	5	28
29	2018-07-28 14:10:35.282327+00	2018-07-28 14:10:35.28728+00	Priced Item(s)		2018-07-28 14:10:35.286775+00	12.00	t	3	29
30	2018-07-28 14:11:01.63572+00	2018-07-28 14:11:01.658277+00	Priced Item(s)		2018-07-28 14:11:01.658008+00	34.00	t	1	30
31	2018-07-28 14:11:53.597796+00	2018-07-28 14:11:53.613545+00	Priced Item(s)		2018-07-28 14:11:53.61327+00	40.00	t	5	31
32	2018-07-28 14:12:24.257698+00	2018-07-28 14:12:24.287832+00	Priced Item(s)		2018-07-28 14:12:24.28752+00	10.00	t	1	32
33	2018-07-28 14:12:48.873007+00	2018-07-28 14:12:48.881843+00	Priced Item(s)		2018-07-28 14:12:48.881687+00	20.00	t	5	33
34	2018-07-28 14:13:54.822151+00	2018-07-28 14:13:54.826158+00	Priced Item(s)		2018-07-28 14:13:54.825999+00	10.00	t	1	34
35	2018-07-28 14:14:47.384538+00	2018-07-28 14:14:47.388262+00	Priced Item(s)		2018-07-28 14:14:47.38807+00	30.00	t	5	35
36	2018-07-28 14:15:21.642967+00	2018-07-28 14:15:21.649177+00	Priced Item(s)		2018-07-28 14:15:21.648047+00	50.00	t	5	36
37	2018-07-28 14:15:59.790185+00	2018-07-28 14:15:59.804152+00	Priced Item(s)		2018-07-28 14:15:59.803895+00	10.00	t	5	37
38	2018-07-28 14:16:04.569629+00	2018-07-28 14:16:04.579532+00	Priced Item(s)		2018-07-28 14:16:04.579264+00	20.00	t	1	38
39	2018-07-28 14:17:16.760446+00	2018-07-28 14:17:16.771533+00	Priced Item(s)		2018-07-28 14:17:16.771267+00	45.00	t	1	39
40	2018-07-28 14:18:18.688749+00	2018-07-28 14:18:18.704808+00	Priced Item(s)		2018-07-28 14:18:18.704526+00	16.00	t	1	40
41	2018-07-28 14:19:23.602951+00	2018-07-28 14:19:23.607026+00	Priced Item(s)		2018-07-28 14:19:23.606833+00	24.00	t	1	41
42	2018-07-28 14:20:04.694637+00	2018-07-28 14:20:04.69868+00	Priced Item(s)		2018-07-28 14:20:04.69848+00	15.00	t	5	42
43	2018-07-28 14:20:09.911988+00	2018-07-28 14:20:09.923655+00	Priced Item(s)		2018-07-28 14:20:09.923402+00	10.00	t	1	43
44	2018-07-28 14:20:23.419816+00	2018-07-28 14:20:23.42378+00	Priced Item(s)		2018-07-28 14:20:23.423619+00	15.00	t	5	44
45	2018-07-28 14:20:53.105629+00	2018-07-28 14:20:53.111898+00	Priced Item(s)		2018-07-28 14:20:53.11147+00	12.00	t	1	45
46	2018-07-28 14:21:29.539789+00	2018-07-28 14:21:29.544831+00	Priced Item(s)		2018-07-28 14:21:29.544549+00	30.00	t	5	46
47	2018-07-28 14:21:59.231629+00	2018-07-28 14:21:59.247527+00	Priced Item(s)		2018-07-28 14:21:59.247287+00	24.00	t	1	47
48	2018-07-28 14:22:44.812637+00	2018-07-28 14:22:44.816318+00	Priced Item(s)		2018-07-28 14:22:44.816143+00	20.00	t	3	48
49	2018-07-28 14:22:59.254997+00	2018-07-28 14:22:59.263483+00	Priced Item(s)		2018-07-28 14:22:59.262368+00	27.00	t	1	49
50	2018-07-28 14:23:27.078359+00	2018-07-28 14:23:27.083107+00	Priced Item(s)		2018-07-28 14:23:27.082863+00	6.00	t	3	50
51	2018-07-28 14:24:20.212698+00	2018-07-28 14:24:20.217765+00	Priced Item(s)		2018-07-28 14:24:20.217433+00	16.00	t	1	51
52	2018-07-28 14:24:52.84459+00	2018-07-28 14:24:52.849855+00	Priced Item(s)		2018-07-28 14:24:52.849571+00	15.00	t	5	52
53	2018-07-28 14:25:07.155425+00	2018-07-28 14:25:07.161259+00	Priced Item(s)		2018-07-28 14:25:07.161121+00	9.00	t	1	53
54	2018-07-28 14:25:18.760749+00	2018-07-28 14:25:18.76422+00	Priced Item(s)		2018-07-28 14:25:18.764062+00	32.00	t	3	54
55	2018-07-28 14:26:28.328854+00	2018-07-28 14:26:28.337825+00	Priced Item(s)		2018-07-28 14:26:28.337519+00	30.00	t	5	55
56	2018-07-28 14:26:32.134919+00	2018-07-28 14:26:32.139397+00	Priced Item(s)		2018-07-28 14:26:32.139193+00	25.00	t	1	56
57	2018-07-28 14:28:04.923206+00	2018-07-28 14:28:04.938096+00	Priced Item(s)		2018-07-28 14:28:04.937521+00	9.00	t	1	57
58	2018-07-28 14:30:04.982052+00	2018-07-28 14:30:04.987451+00	Priced Item(s)		2018-07-28 14:30:04.987228+00	18.00	t	1	58
59	2018-07-28 14:30:43.714852+00	2018-07-28 14:30:43.729502+00	Priced Item(s)		2018-07-28 14:30:43.729139+00	38.00	t	1	59
60	2018-07-28 14:31:51.79939+00	2018-07-28 14:31:51.805613+00	Priced Item(s)		2018-07-28 14:31:51.803943+00	12.00	t	5	60
61	2018-07-28 14:32:15.559692+00	2018-07-28 14:32:15.566093+00	Priced Item(s)		2018-07-28 14:32:15.565836+00	10.00	t	1	61
62	2018-07-28 14:32:20.157313+00	2018-07-28 14:32:20.175484+00	Priced Item(s)		2018-07-28 14:32:20.175203+00	10.00	t	4	62
63	2018-07-28 14:34:38.553449+00	2018-07-28 14:34:38.565636+00	Priced Item(s)		2018-07-28 14:34:38.564632+00	45.00	t	3	63
64	2018-07-28 14:34:54.403668+00	2018-07-28 14:34:54.419473+00	Priced Item(s)		2018-07-28 14:34:54.419196+00	8.00	t	1	64
65	2018-07-28 14:35:02.186921+00	2018-07-28 14:35:02.200518+00	Priced Item(s)		2018-07-28 14:35:02.199975+00	15.00	t	3	65
66	2018-07-28 14:35:24.152018+00	2018-07-28 14:35:24.163496+00	Priced Item(s)		2018-07-28 14:35:24.16321+00	10.00	t	3	66
67	2018-07-28 14:35:31.478104+00	2018-07-28 14:35:31.491432+00	Priced Item(s)		2018-07-28 14:35:31.491179+00	10.00	t	1	67
68	2018-07-28 14:37:49.868069+00	2018-07-28 14:37:49.884082+00	Priced Item(s)		2018-07-28 14:37:49.883813+00	6.30	t	2	68
69	2018-07-28 14:37:55.784897+00	2018-07-28 14:37:55.794571+00	Priced Item(s)		2018-07-28 14:37:55.794316+00	21.00	t	3	69
70	2018-07-28 14:40:29.751138+00	2018-07-28 14:40:29.760237+00	Priced Item(s)		2018-07-28 14:40:29.75998+00	60.00	t	1	70
71	2018-07-28 14:41:16.610778+00	2018-07-28 14:41:16.626101+00	Priced Item(s)		2018-07-28 14:41:16.625704+00	6.25	t	2	71
72	2018-07-28 14:41:44.444408+00	2018-07-28 14:41:44.45555+00	Priced Item(s)		2018-07-28 14:41:44.455267+00	16.00	t	1	72
73	2018-07-28 14:42:53.972022+00	2018-07-28 14:42:53.990132+00	Priced Item(s)		2018-07-28 14:42:53.988846+00	24.50	t	1	73
74	2018-07-28 14:42:56.322288+00	2018-07-28 14:42:56.340206+00	Priced Item(s)		2018-07-28 14:42:56.339333+00	1.65	t	2	74
75	2018-07-28 14:43:51.240313+00	2018-07-28 14:43:51.250963+00	Priced Item(s)		2018-07-28 14:43:51.250716+00	10.00	t	5	75
76	2018-07-28 14:46:13.345337+00	2018-07-28 14:46:13.358874+00	Priced Item(s)		2018-07-28 14:46:13.358614+00	30.00	t	1	76
77	2018-07-28 14:46:14.904733+00	2018-07-28 14:46:14.91329+00	Priced Item(s)		2018-07-28 14:46:14.912585+00	25.00	t	4	77
78	2018-07-28 14:46:58.521788+00	2018-07-28 14:46:58.532266+00	Priced Item(s)		2018-07-28 14:46:58.529895+00	20.00	t	4	78
79	2018-07-28 14:47:04.869824+00	2018-07-28 14:47:04.87947+00	Priced Item(s)		2018-07-28 14:47:04.879188+00	36.00	t	5	79
80	2018-07-28 14:47:43.951757+00	2018-07-28 14:47:43.965721+00	Priced Item(s)		2018-07-28 14:47:43.965462+00	30.00	t	4	80
81	2018-07-28 14:48:10.395173+00	2018-07-28 14:48:10.406361+00	Priced Item(s)		2018-07-28 14:48:10.406104+00	12.00	t	5	81
82	2018-07-28 14:49:57.987654+00	2018-07-28 14:49:58.0035+00	Priced Item(s)		2018-07-28 14:49:58.003209+00	8.00	t	4	82
83	2018-07-28 14:50:13.135687+00	2018-07-28 14:50:13.155837+00	Priced Item(s)		2018-07-28 14:50:13.155272+00	20.00	t	5	83
84	2018-07-28 14:53:00.557297+00	2018-07-28 14:53:00.567312+00	Priced Item(s)		2018-07-28 14:53:00.566981+00	5.00	t	4	84
85	2018-07-28 14:53:05.596862+00	2018-07-28 14:53:05.602123+00	Priced Item(s)		2018-07-28 14:53:05.601881+00	7.00	t	3	85
87	2018-07-28 14:55:35.969951+00	2018-07-28 14:55:35.978032+00	Priced Item(s)		2018-07-28 14:55:35.977754+00	10.00	t	5	87
88	2018-07-28 14:56:41.995709+00	2018-07-28 14:56:42.011466+00	Priced Item(s)		2018-07-28 14:56:42.011179+00	4.00	t	5	88
89	2018-07-28 14:57:01.663385+00	2018-07-28 14:57:01.684556+00	Priced Item(s)		2018-07-28 14:57:01.684264+00	4.00	t	5	89
90	2018-07-28 14:58:14.422925+00	2018-07-28 14:58:14.433344+00	Priced Item(s)		2018-07-28 14:58:14.43189+00	20.00	t	5	90
91	2018-07-28 14:59:01.825285+00	2018-07-28 14:59:01.838036+00	Priced Item(s)		2018-07-28 14:59:01.837623+00	4.00	t	5	91
92	2018-07-28 15:00:16.022584+00	2018-07-28 15:00:16.035551+00	Priced Item(s)		2018-07-28 15:00:16.034726+00	10.00	t	1	92
93	2018-07-28 15:01:12.100991+00	2018-07-28 15:01:12.121998+00	Priced Item(s)		2018-07-28 15:01:12.121728+00	40.00	t	3	93
94	2018-07-28 15:01:37.92663+00	2018-07-28 15:01:37.943499+00	Priced Item(s)		2018-07-28 15:01:37.943192+00	15.00	t	5	94
95	2018-07-28 15:02:12.304628+00	2018-07-28 15:02:12.314537+00	Priced Item(s)		2018-07-28 15:02:12.314267+00	55.54	t	2	95
96	2018-07-28 15:02:54.996884+00	2018-07-28 15:02:55.005991+00	Priced Item(s)		2018-07-28 15:02:55.005721+00	5.00	t	3	96
97	2018-07-28 15:03:28.285877+00	2018-07-28 15:03:28.291642+00	Priced Item(s)		2018-07-28 15:03:28.291418+00	5.00	t	2	97
98	2018-07-28 15:07:37.391605+00	2018-07-28 15:07:37.41326+00	Priced Item(s)		2018-07-28 15:07:37.412908+00	2.95	t	2	98
99	2018-07-28 15:08:45.691713+00	2018-07-28 15:08:45.698026+00	Priced Item(s)		2018-07-28 15:08:45.69765+00	20.00	t	5	99
100	2018-07-28 15:11:43.012409+00	2018-07-28 15:11:43.018404+00	Priced Item(s)		2018-07-28 15:11:43.018116+00	13.00	t	4	100
101	2018-07-28 15:12:25.724141+00	2018-07-28 15:12:25.736335+00	Priced Item(s)		2018-07-28 15:12:25.734201+00	15.00	t	5	101
102	2018-07-28 15:13:39.352375+00	2018-07-28 15:13:39.369341+00	Priced Item(s)		2018-07-28 15:13:39.369069+00	20.00	t	5	102
103	2018-07-28 15:13:39.695463+00	2018-07-28 15:13:39.715653+00	Priced Item(s)		2018-07-28 15:13:39.715205+00	20.00	t	1	103
104	2018-07-28 15:14:41.840165+00	2018-07-28 15:14:41.855897+00	Priced Item(s)		2018-07-28 15:14:41.854589+00	21.50	t	1	104
105	2018-07-28 15:14:44.262983+00	2018-07-28 15:14:44.271486+00	Priced Item(s)		2018-07-28 15:14:44.271186+00	3.00	t	3	105
106	2018-07-28 15:15:16.952426+00	2018-07-28 15:15:16.974116+00	Priced Item(s)		2018-07-28 15:15:16.973788+00	10.00	t	5	106
107	2018-07-28 15:15:32.460614+00	2018-07-28 15:15:32.472098+00	Priced Item(s)		2018-07-28 15:15:32.471682+00	10.00	t	5	107
108	2018-07-28 15:16:04.363249+00	2018-07-28 15:16:04.373072+00	Priced Item(s)		2018-07-28 15:16:04.372561+00	20.00	t	5	108
109	2018-07-28 15:16:22.188572+00	2018-07-28 15:16:22.205824+00	Priced Item(s)		2018-07-28 15:16:22.205548+00	33.00	t	4	109
110	2018-07-28 15:16:24.839768+00	2018-07-28 15:16:24.85155+00	Priced Item(s)		2018-07-28 15:16:24.851017+00	8.00	t	3	110
111	2018-07-28 15:17:03.716684+00	2018-07-28 15:17:03.726666+00	Priced Item(s)		2018-07-28 15:17:03.726188+00	11.00	t	5	111
112	2018-07-28 15:17:23.664617+00	2018-07-28 15:17:23.674661+00	Priced Item(s)		2018-07-28 15:17:23.674311+00	10.00	t	3	112
113	2018-07-28 15:17:49.759496+00	2018-07-28 15:17:49.77194+00	Priced Item(s)		2018-07-28 15:17:49.771428+00	20.00	t	5	113
114	2018-07-28 15:18:36.440612+00	2018-07-28 15:18:36.449003+00	Priced Item(s)		2018-07-28 15:18:36.448756+00	26.00	t	1	114
115	2018-07-28 15:18:53.777852+00	2018-07-28 15:18:53.801652+00	Priced Item(s)		2018-07-28 15:18:53.801361+00	10.00	t	3	115
116	2018-07-28 15:19:31.137825+00	2018-07-28 15:19:31.183531+00	Priced Item(s)		2018-07-28 15:19:31.183118+00	8.00	t	5	116
117	2018-07-28 15:20:03.457902+00	2018-07-28 15:20:03.47696+00	Priced Item(s)		2018-07-28 15:20:03.476687+00	33.00	t	1	117
118	2018-07-28 15:20:12.228237+00	2018-07-28 15:20:12.244456+00	Priced Item(s)		2018-07-28 15:20:12.243917+00	20.00	t	5	118
119	2018-07-28 15:20:50.223836+00	2018-07-28 15:20:50.247609+00	Priced Item(s)		2018-07-28 15:20:50.247328+00	8.00	t	3	119
120	2018-07-28 15:21:30.831922+00	2018-07-28 15:21:30.861715+00	Priced Item(s)		2018-07-28 15:21:30.861432+00	20.00	t	1	120
121	2018-07-28 15:22:10.744346+00	2018-07-28 15:22:10.772253+00	Priced Item(s)		2018-07-28 15:22:10.771963+00	20.00	t	5	121
122	2018-07-28 15:22:37.549489+00	2018-07-28 15:22:37.562238+00	Priced Item(s)		2018-07-28 15:22:37.561546+00	10.00	t	1	122
123	2018-07-28 15:23:32.403796+00	2018-07-28 15:23:32.411761+00	Priced Item(s)		2018-07-28 15:23:32.411226+00	20.00	t	5	123
124	2018-07-28 15:25:00.603657+00	2018-07-28 15:25:00.617984+00	Priced Item(s)		2018-07-28 15:25:00.616937+00	6.00	t	1	124
125	2018-07-28 15:26:08.857111+00	2018-07-28 15:26:08.86392+00	Priced Item(s)		2018-07-28 15:26:08.863669+00	5.00	t	4	125
126	2018-07-28 15:26:22.143677+00	2018-07-28 15:26:22.158774+00	Priced Item(s)		2018-07-28 15:26:22.158497+00	0.30	t	2	126
127	2018-07-28 15:26:27.234002+00	2018-07-28 15:26:27.246743+00	Priced Item(s)		2018-07-28 15:26:27.246466+00	12.00	t	1	127
128	2018-07-28 15:26:39.779562+00	2018-07-28 15:26:39.791831+00	Priced Item(s)		2018-07-28 15:26:39.791568+00	5.00	t	3	128
129	2018-07-28 15:26:56.00745+00	2018-07-28 15:26:56.025807+00	Priced Item(s)		2018-07-28 15:26:56.025524+00	6.00	t	1	129
130	2018-07-28 15:27:21.055981+00	2018-07-28 15:27:21.066579+00	Priced Item(s)		2018-07-28 15:27:21.06598+00	24.00	t	1	130
131	2018-07-28 15:28:06.938031+00	2018-07-28 15:28:06.953942+00	Priced Item(s)		2018-07-28 15:28:06.953704+00	5.00	t	5	131
132	2018-07-28 15:29:28.607089+00	2018-07-28 15:29:28.619294+00	Priced Item(s)		2018-07-28 15:29:28.618753+00	8.50	t	2	132
133	2018-07-28 15:30:42.036522+00	2018-07-28 15:30:42.047122+00	Priced Item(s)		2018-07-28 15:30:42.046755+00	10.00	t	5	133
134	2018-07-28 15:31:06.064594+00	2018-07-28 15:31:06.071852+00	Priced Item(s)		2018-07-28 15:31:06.07117+00	2.50	t	2	134
135	2018-07-28 15:31:07.777391+00	2018-07-28 15:31:07.783902+00	Priced Item(s)		2018-07-28 15:31:07.783633+00	10.00	t	5	135
136	2018-07-28 15:31:43.40104+00	2018-07-28 15:31:43.421686+00	Priced Item(s)		2018-07-28 15:31:43.421325+00	10.00	t	5	136
137	2018-07-28 15:32:03.611714+00	2018-07-28 15:32:03.625172+00	Priced Item(s)		2018-07-28 15:32:03.624664+00	5.00	t	2	137
138	2018-07-28 15:32:19.302982+00	2018-07-28 15:32:19.311502+00	Priced Item(s)		2018-07-28 15:32:19.311254+00	51.00	t	5	138
139	2018-07-28 15:33:43.647551+00	2018-07-28 15:33:43.662582+00	Priced Item(s)		2018-07-28 15:33:43.66118+00	37.34	t	2	139
140	2018-07-28 15:34:55.53402+00	2018-07-28 15:34:55.541202+00	Priced Item(s)		2018-07-28 15:34:55.540981+00	14.40	t	2	140
86	2018-07-28 14:54:09.722873+00	2018-07-28 14:54:09.73544+00	Priced Item(s)		2018-07-28 14:54:09.735182+00	10.00	t	5	\N
142	2018-07-28 15:35:47.94689+00	2018-07-28 15:35:47.959428+00	Priced Item(s)		2018-07-28 15:35:47.959172+00	5.95	t	2	142
143	2018-07-28 15:36:22.643805+00	2018-07-28 15:36:22.678135+00	Priced Item(s)		2018-07-28 15:36:22.677526+00	10.00	t	5	143
144	2018-07-28 15:36:45.528463+00	2018-07-28 15:36:45.537631+00	Priced Item(s)		2018-07-28 15:36:45.536657+00	10.00	t	5	144
145	2018-07-28 15:37:56.212175+00	2018-07-28 15:37:56.232261+00	Priced Item(s)		2018-07-28 15:37:56.228285+00	20.00	t	5	145
146	2018-07-28 15:39:07.691176+00	2018-07-28 15:39:07.699052+00	Priced Item(s)		2018-07-28 15:39:07.698733+00	10.00	t	5	146
147	2018-07-28 15:39:08.511759+00	2018-07-28 15:39:08.523507+00	Priced Item(s)		2018-07-28 15:39:08.52322+00	10.00	t	1	147
148	2018-07-28 15:39:27.945104+00	2018-07-28 15:39:27.966125+00	Priced Item(s)		2018-07-28 15:39:27.965871+00	4.55	t	2	148
149	2018-07-28 15:39:58.923956+00	2018-07-28 15:39:58.933316+00	Priced Item(s)		2018-07-28 15:39:58.933046+00	15.00	t	5	149
150	2018-07-28 15:40:26.229679+00	2018-07-28 15:40:26.262439+00	Priced Item(s)		2018-07-28 15:40:26.254097+00	16.50	t	1	150
151	2018-07-28 15:40:36.720182+00	2018-07-28 15:40:36.726576+00	Priced Item(s)		2018-07-28 15:40:36.726342+00	10.00	t	5	151
152	2018-07-28 15:41:19.255697+00	2018-07-28 15:41:19.2666+00	Priced Item(s)		2018-07-28 15:41:19.266325+00	90.00	t	5	152
153	2018-07-28 15:42:47.461322+00	2018-07-28 15:42:47.47155+00	Priced Item(s)		2018-07-28 15:42:47.47129+00	27.00	t	1	153
154	2018-07-28 15:42:50.051399+00	2018-07-28 15:42:50.069354+00	Priced Item(s)		2018-07-28 15:42:50.069101+00	0.75	t	2	154
155	2018-07-28 15:43:30.835536+00	2018-07-28 15:43:30.851533+00	Priced Item(s)		2018-07-28 15:43:30.851264+00	4.00	t	3	155
156	2018-07-28 15:43:53.254006+00	2018-07-28 15:43:53.26181+00	Priced Item(s)		2018-07-28 15:43:53.261268+00	10.00	t	5	156
157	2018-07-28 15:44:25.54672+00	2018-07-28 15:44:25.556048+00	Priced Item(s)		2018-07-28 15:44:25.555585+00	10.00	t	1	157
158	2018-07-28 15:45:05.460534+00	2018-07-28 15:45:05.475557+00	Priced Item(s)		2018-07-28 15:45:05.47527+00	8.00	t	3	158
159	2018-07-28 15:45:43.376186+00	2018-07-28 15:45:43.396341+00	Priced Item(s)		2018-07-28 15:45:43.395917+00	6.00	t	1	159
160	2018-07-28 15:46:05.623776+00	2018-07-28 15:46:05.632647+00	Priced Item(s)		2018-07-28 15:46:05.632391+00	6.00	t	5	160
161	2018-07-28 15:47:20.843832+00	2018-07-28 15:47:20.850485+00	Priced Item(s)		2018-07-28 15:47:20.849962+00	1.95	t	2	161
162	2018-07-28 15:47:32.081035+00	2018-07-28 15:47:32.089804+00	Priced Item(s)		2018-07-28 15:47:32.089543+00	4.50	t	4	162
163	2018-07-28 15:47:56.523555+00	2018-07-28 15:47:56.531532+00	Priced Item(s)		2018-07-28 15:47:56.531262+00	2.00	t	4	163
164	2018-07-28 15:50:16.934744+00	2018-07-28 15:50:16.947508+00	Priced Item(s)		2018-07-28 15:50:16.94722+00	21.00	t	1	164
165	2018-07-28 15:50:28.249457+00	2018-07-28 15:50:28.255404+00	Priced Item(s)		2018-07-28 15:50:28.254903+00	10.00	t	5	165
166	2018-07-28 15:50:37.912278+00	2018-07-28 15:50:37.936299+00	Priced Item(s)		2018-07-28 15:50:37.934915+00	1.75	t	2	166
167	2018-07-28 15:51:02.9039+00	2018-07-28 15:51:02.918571+00	Priced Item(s)		2018-07-28 15:51:02.918071+00	20.00	t	5	167
168	2018-07-28 15:52:10.795581+00	2018-07-28 15:52:10.802788+00	Priced Item(s)		2018-07-28 15:52:10.802523+00	14.00	t	3	168
169	2018-07-28 15:52:50.983913+00	2018-07-28 15:52:50.999139+00	Priced Item(s)		2018-07-28 15:52:50.997919+00	6.00	t	1	169
170	2018-07-28 15:53:54.104222+00	2018-07-28 15:53:54.123472+00	Priced Item(s)		2018-07-28 15:53:54.123195+00	10.00	t	1	170
141	2018-07-28 15:35:19.655752+00	2018-07-28 17:03:32.251444+00	Priced Item(s)		2018-07-28 15:35:19.664054+00	12.00	t	5	141
171	2018-07-28 15:54:25.258136+00	2018-07-28 15:54:25.272774+00	Priced Item(s)		2018-07-28 15:54:25.272514+00	21.00	t	5	171
173	2018-07-28 15:54:48.77865+00	2018-07-28 15:54:48.783588+00	Priced Item(s)		2018-07-28 15:54:48.783367+00	15.00	t	5	173
177	2018-07-28 15:55:51.316139+00	2018-07-28 15:55:51.331467+00	Priced Item(s)		2018-07-28 15:55:51.331189+00	20.00	t	5	177
172	2018-07-28 15:54:40.304034+00	2018-07-28 15:54:40.315412+00	Priced Item(s)		2018-07-28 15:54:40.315163+00	21.50	t	1	172
174	2018-07-28 15:55:17.255047+00	2018-07-28 15:55:17.264483+00	Priced Item(s)		2018-07-28 15:55:17.26421+00	12.00	t	1	174
175	2018-07-28 15:55:20.049205+00	2018-07-28 15:55:20.063043+00	Priced Item(s)		2018-07-28 15:55:20.062749+00	12.00	t	5	175
176	2018-07-28 15:55:45.163793+00	2018-07-28 15:55:45.174313+00	Priced Item(s)		2018-07-28 15:55:45.174047+00	6.00	t	1	176
178	2018-07-28 15:55:58.595652+00	2018-07-28 15:55:58.602532+00	Priced Item(s)		2018-07-28 15:55:58.601867+00	10.00	t	3	178
179	2018-07-28 15:56:24.219725+00	2018-07-28 15:56:24.228098+00	Priced Item(s)		2018-07-28 15:56:24.227765+00	6.00	t	5	179
180	2018-07-28 15:57:27.623545+00	2018-07-28 15:57:27.64051+00	Priced Item(s)		2018-07-28 15:57:27.640234+00	5.00	t	5	180
181	2018-07-28 15:57:44.744329+00	2018-07-28 15:57:44.759499+00	Priced Item(s)		2018-07-28 15:57:44.75922+00	6.00	t	1	181
182	2018-07-28 15:59:15.467163+00	2018-07-28 15:59:15.483421+00	Priced Item(s)		2018-07-28 15:59:15.483162+00	16.50	t	1	182
183	2018-07-28 15:59:48.854205+00	2018-07-28 15:59:48.868721+00	Priced Item(s)		2018-07-28 15:59:48.867347+00	5.00	t	2	183
184	2018-07-28 16:00:15.785392+00	2018-07-28 16:00:15.79852+00	Priced Item(s)		2018-07-28 16:00:15.798244+00	16.50	t	1	184
185	2018-07-28 16:00:50.088705+00	2018-07-28 16:00:50.109959+00	Priced Item(s)		2018-07-28 16:00:50.108147+00	4.50	t	2	185
186	2018-07-28 16:00:56.905964+00	2018-07-28 16:00:56.915931+00	Priced Item(s)		2018-07-28 16:00:56.914869+00	16.00	t	1	186
187	2018-07-28 16:01:09.065764+00	2018-07-28 16:01:09.094525+00	Priced Item(s)		2018-07-28 16:01:09.091201+00	12.00	t	5	187
188	2018-07-28 16:01:27.254879+00	2018-07-28 16:01:27.294328+00	Priced Item(s)		2018-07-28 16:01:27.294039+00	12.00	t	5	188
189	2018-07-28 16:01:41.29338+00	2018-07-28 16:01:41.299364+00	Priced Item(s)		2018-07-28 16:01:41.298825+00	2.60	t	2	189
190	2018-07-28 16:02:18.488014+00	2018-07-28 16:02:18.498464+00	Priced Item(s)		2018-07-28 16:02:18.495332+00	7.75	t	2	190
191	2018-07-28 16:02:19.222947+00	2018-07-28 16:02:19.231565+00	Priced Item(s)		2018-07-28 16:02:19.231277+00	26.00	t	1	191
192	2018-07-28 16:03:20.593612+00	2018-07-28 16:03:20.614648+00	Priced Item(s)		2018-07-28 16:03:20.614222+00	6.00	t	1	192
193	2018-07-28 16:03:28.757676+00	2018-07-28 16:03:28.788082+00	Priced Item(s)		2018-07-28 16:03:28.787788+00	10.00	t	5	193
194	2018-07-28 16:03:30.182637+00	2018-07-28 16:03:30.204151+00	Priced Item(s)		2018-07-28 16:03:30.20387+00	20.00	t	5	194
195	2018-07-28 16:03:43.605435+00	2018-07-28 16:03:43.613703+00	Priced Item(s)		2018-07-28 16:03:43.613271+00	42.00	t	5	195
196	2018-07-28 16:04:00.502714+00	2018-07-28 16:04:00.515498+00	Priced Item(s)		2018-07-28 16:04:00.515223+00	12.00	t	1	196
197	2018-07-28 16:04:28.484804+00	2018-07-28 16:04:28.490973+00	Priced Item(s)		2018-07-28 16:04:28.490701+00	15.00	t	5	197
198	2018-07-28 16:04:39.596123+00	2018-07-28 16:04:39.621481+00	Priced Item(s)		2018-07-28 16:04:39.620887+00	20.00	t	1	198
199	2018-07-28 16:05:21.345266+00	2018-07-28 16:05:21.352549+00	Priced Item(s)		2018-07-28 16:05:21.352213+00	10.00	t	5	199
200	2018-07-28 16:05:26.470533+00	2018-07-28 16:05:26.478909+00	Priced Item(s)		2018-07-28 16:05:26.478325+00	35.00	t	3	200
201	2018-07-28 16:05:40.696737+00	2018-07-28 16:05:40.709957+00	Priced Item(s)		2018-07-28 16:05:40.708892+00	10.00	t	5	201
202	2018-07-28 16:05:42.338702+00	2018-07-28 16:05:42.350975+00	Priced Item(s)		2018-07-28 16:05:42.350711+00	34.50	t	1	202
203	2018-07-28 16:06:21.415592+00	2018-07-28 16:06:21.434232+00	Priced Item(s)		2018-07-28 16:06:21.433874+00	10.00	t	5	203
204	2018-07-28 16:06:31.974508+00	2018-07-28 16:06:31.997098+00	Priced Item(s)		2018-07-28 16:06:31.996662+00	20.00	t	4	204
205	2018-07-28 16:06:42.439815+00	2018-07-28 16:06:42.445841+00	Priced Item(s)		2018-07-28 16:06:42.445608+00	10.00	t	5	205
207	2018-07-28 16:07:28.094481+00	2018-07-28 16:07:28.126602+00	Priced Item(s)		2018-07-28 16:07:28.126311+00	15.00	t	5	207
208	2018-07-28 16:08:15.003764+00	2018-07-28 16:08:15.023503+00	Priced Item(s)		2018-07-28 16:08:15.023065+00	7.00	t	5	208
209	2018-07-28 16:08:47.515143+00	2018-07-28 16:08:47.552824+00	Priced Item(s)		2018-07-28 16:08:47.552549+00	20.00	t	5	209
213	2018-07-28 16:10:39.00825+00	2018-07-28 16:10:39.081444+00	Priced Item(s)		2018-07-28 16:10:39.080905+00	4.80	t	2	213
211	2018-07-28 16:09:28.792272+00	2018-07-28 16:09:28.814099+00	Priced Item(s)		2018-07-28 16:09:28.813851+00	30.00	t	5	211
232	2018-07-28 16:17:29.958564+00	2018-07-28 16:17:29.975504+00	Priced Item(s)		2018-07-28 16:17:29.975237+00	6.00	t	1	232
212	2018-07-28 16:09:55.820398+00	2018-07-28 16:09:55.836329+00	Priced Item(s)		2018-07-28 16:09:55.835421+00	11.00	t	5	212
214	2018-07-28 16:10:41.891473+00	2018-07-28 16:10:41.935825+00	Priced Item(s)		2018-07-28 16:10:41.933304+00	15.00	t	5	214
210	2018-07-28 16:09:00.492952+00	2018-07-28 16:09:46.180405+00	Priced Item(s)		2018-07-28 16:09:00.502862+00	10.00	t	5	\N
215	2018-07-28 16:11:12.93707+00	2018-07-28 16:11:12.95298+00	Priced Item(s)		2018-07-28 16:11:12.952715+00	10.00	t	5	215
216	2018-07-28 16:11:26.715699+00	2018-07-28 16:11:26.722976+00	Priced Item(s)		2018-07-28 16:11:26.722738+00	15.00	t	5	216
217	2018-07-28 16:11:48.682231+00	2018-07-28 16:11:48.726164+00	Priced Item(s)		2018-07-28 16:11:48.725893+00	15.00	t	5	217
218	2018-07-28 16:12:36.45012+00	2018-07-28 16:12:36.458472+00	Priced Item(s)		2018-07-28 16:12:36.458206+00	10.00	t	5	218
219	2018-07-28 16:13:07.412858+00	2018-07-28 16:13:07.427455+00	Priced Item(s)		2018-07-28 16:13:07.427193+00	18.50	t	1	219
220	2018-07-28 16:13:14.191681+00	2018-07-28 16:13:14.203468+00	Priced Item(s)		2018-07-28 16:13:14.203192+00	35.00	t	3	220
221	2018-07-28 16:13:37.064469+00	2018-07-28 16:13:37.074895+00	Priced Item(s)		2018-07-28 16:13:37.074606+00	18.50	t	1	221
222	2018-07-28 16:13:41.763781+00	2018-07-28 16:13:41.779443+00	Priced Item(s)		2018-07-28 16:13:41.779174+00	20.00	t	5	222
223	2018-07-28 16:14:06.404688+00	2018-07-28 16:14:06.412685+00	Priced Item(s)		2018-07-28 16:14:06.412154+00	22.00	t	3	223
224	2018-07-28 16:14:23.911755+00	2018-07-28 16:14:23.924036+00	Priced Item(s)		2018-07-28 16:14:23.923637+00	20.00	t	5	224
225	2018-07-28 16:14:27.599346+00	2018-07-28 16:14:27.620314+00	Priced Item(s)		2018-07-28 16:14:27.614876+00	19.00	t	1	225
226	2018-07-28 16:14:44.573739+00	2018-07-28 16:14:44.582434+00	Priced Item(s)		2018-07-28 16:14:44.582196+00	15.00	t	5	226
227	2018-07-28 16:15:05.226757+00	2018-07-28 16:15:05.239754+00	Priced Item(s)		2018-07-28 16:15:05.239505+00	20.00	t	5	227
228	2018-07-28 16:15:22.182938+00	2018-07-28 16:15:22.196937+00	Priced Item(s)		2018-07-28 16:15:22.196635+00	6.00	t	5	228
229	2018-07-28 16:15:37.771808+00	2018-07-28 16:15:37.789645+00	Priced Item(s)		2018-07-28 16:15:37.789358+00	20.00	t	1	229
230	2018-07-28 16:16:39.478323+00	2018-07-28 16:16:39.495634+00	Priced Item(s)		2018-07-28 16:16:39.495366+00	5.00	t	5	230
231	2018-07-28 16:17:04.05363+00	2018-07-28 16:17:04.118552+00	Priced Item(s)		2018-07-28 16:17:04.118272+00	3.00	t	2	231
233	2018-07-28 16:17:33.524497+00	2018-07-28 16:17:33.535515+00	Priced Item(s)		2018-07-28 16:17:33.535226+00	8.00	t	5	233
234	2018-07-28 16:17:48.497275+00	2018-07-28 16:17:48.51823+00	Priced Item(s)		2018-07-28 16:17:48.517949+00	6.00	t	1	234
235	2018-07-28 16:18:26.189972+00	2018-07-28 16:18:26.203559+00	Priced Item(s)		2018-07-28 16:18:26.203287+00	10.00	t	5	235
236	2018-07-28 16:18:39.770615+00	2018-07-28 16:18:39.783918+00	Priced Item(s)		2018-07-28 16:18:39.783377+00	3.90	t	2	236
237	2018-07-28 16:18:43.948918+00	2018-07-28 16:18:43.954455+00	Priced Item(s)		2018-07-28 16:18:43.953861+00	16.00	t	1	237
238	2018-07-28 16:18:49.036052+00	2018-07-28 16:18:49.050059+00	Priced Item(s)		2018-07-28 16:18:49.049744+00	7.00	t	5	238
239	2018-07-28 16:18:58.74845+00	2018-07-28 16:18:58.762893+00	Priced Item(s)		2018-07-28 16:18:58.761979+00	15.00	t	5	239
240	2018-07-28 16:19:08.150967+00	2018-07-28 16:19:08.163546+00	Priced Item(s)		2018-07-28 16:19:08.16329+00	40.00	t	5	240
241	2018-07-28 16:19:31.72646+00	2018-07-28 16:19:31.735262+00	Priced Item(s)		2018-07-28 16:19:31.734885+00	7.00	t	2	241
242	2018-07-28 16:19:46.580846+00	2018-07-28 16:19:46.590765+00	Priced Item(s)		2018-07-28 16:19:46.590504+00	12.00	t	5	242
243	2018-07-28 16:20:14.55054+00	2018-07-28 16:20:14.556296+00	Priced Item(s)		2018-07-28 16:20:14.555766+00	2.00	t	2	243
244	2018-07-28 16:20:37.838978+00	2018-07-28 16:20:37.845046+00	Priced Item(s)		2018-07-28 16:20:37.844808+00	2.00	t	2	244
245	2018-07-28 16:20:40.771774+00	2018-07-28 16:20:40.781764+00	Priced Item(s)		2018-07-28 16:20:40.781536+00	20.00	t	5	245
246	2018-07-28 16:20:50.228472+00	2018-07-28 16:20:50.234785+00	Priced Item(s)		2018-07-28 16:20:50.234292+00	24.00	t	5	246
247	2018-07-28 16:20:58.765414+00	2018-07-28 16:20:58.779639+00	Priced Item(s)		2018-07-28 16:20:58.779371+00	8.00	t	5	247
248	2018-07-28 16:20:59.819642+00	2018-07-28 16:20:59.827325+00	Priced Item(s)		2018-07-28 16:20:59.827054+00	10.00	t	5	248
249	2018-07-28 16:21:20.854507+00	2018-07-28 16:21:20.867417+00	Priced Item(s)		2018-07-28 16:21:20.867174+00	8.00	t	5	249
250	2018-07-28 16:21:26.394204+00	2018-07-28 16:21:26.399922+00	Priced Item(s)		2018-07-28 16:21:26.399681+00	10.00	t	5	250
251	2018-07-28 16:21:30.469173+00	2018-07-28 16:21:30.480426+00	Priced Item(s)		2018-07-28 16:21:30.479552+00	15.00	t	4	251
252	2018-07-28 16:21:46.403934+00	2018-07-28 16:21:46.415667+00	Priced Item(s)		2018-07-28 16:21:46.415321+00	10.00	t	5	252
253	2018-07-28 16:22:33.897909+00	2018-07-28 16:22:33.914377+00	Priced Item(s)		2018-07-28 16:22:33.914109+00	10.00	t	5	253
254	2018-07-28 16:22:38.232328+00	2018-07-28 16:22:38.238118+00	Priced Item(s)		2018-07-28 16:22:38.237744+00	12.00	t	3	254
255	2018-07-28 16:23:21.464209+00	2018-07-28 16:23:21.483609+00	Priced Item(s)		2018-07-28 16:23:21.483354+00	9.00	t	5	255
256	2018-07-28 16:23:48.852435+00	2018-07-28 16:23:48.86346+00	Priced Item(s)		2018-07-28 16:23:48.863198+00	11.00	t	3	256
257	2018-07-28 16:23:51.341475+00	2018-07-28 16:23:51.351355+00	Priced Item(s)		2018-07-28 16:23:51.350938+00	10.00	t	5	257
258	2018-07-28 16:24:12.459796+00	2018-07-28 16:24:12.475052+00	Priced Item(s)		2018-07-28 16:24:12.474762+00	5.00	t	3	258
259	2018-07-28 16:24:22.242026+00	2018-07-28 16:24:22.267901+00	Priced Item(s)		2018-07-28 16:24:22.267288+00	3.00	t	5	259
260	2018-07-28 16:24:23.327179+00	2018-07-28 16:24:23.334863+00	Priced Item(s)		2018-07-28 16:24:23.334635+00	10.00	t	5	260
262	2018-07-28 16:25:29.460448+00	2018-07-28 16:25:29.471079+00	Priced Item(s)		2018-07-28 16:25:29.470774+00	10.00	t	5	262
264	2018-07-28 16:25:36.245831+00	2018-07-28 16:25:36.250726+00	Priced Item(s)		2018-07-28 16:25:36.250529+00	2.00	t	3	264
268	2018-07-28 16:27:19.83915+00	2018-07-28 16:27:19.847355+00	Priced Item(s)		2018-07-28 16:27:19.847118+00	20.00	t	5	268
269	2018-07-28 16:27:48.918076+00	2018-07-28 16:27:48.93345+00	Priced Item(s)		2018-07-28 16:27:48.933209+00	10.00	t	5	269
271	2018-07-28 16:28:16.736772+00	2018-07-28 16:28:16.763499+00	Priced Item(s)		2018-07-28 16:28:16.761761+00	12.00	t	1	271
272	2018-07-28 16:28:29.122457+00	2018-07-28 16:28:29.133847+00	Priced Item(s)		2018-07-28 16:28:29.133581+00	5.00	t	5	272
261	2018-07-28 16:24:58.128629+00	2018-07-28 16:24:58.141827+00	Priced Item(s)		2018-07-28 16:24:58.141565+00	5.00	t	5	261
263	2018-07-28 16:25:31.651322+00	2018-07-28 16:25:31.659663+00	Priced Item(s)		2018-07-28 16:25:31.659414+00	20.00	t	5	263
265	2018-07-28 16:25:49.593849+00	2018-07-28 16:25:49.602162+00	Priced Item(s)		2018-07-28 16:25:49.601888+00	18.50	t	1	265
266	2018-07-28 16:25:53.554917+00	2018-07-28 16:25:53.567533+00	Priced Item(s)		2018-07-28 16:25:53.567264+00	15.00	t	5	266
267	2018-07-28 16:26:28.711274+00	2018-07-28 16:26:28.723694+00	Priced Item(s)		2018-07-28 16:26:28.723429+00	30.00	t	5	267
270	2018-07-28 16:28:14.329319+00	2018-07-28 16:28:14.335154+00	Priced Item(s)		2018-07-28 16:28:14.334869+00	12.00	t	5	270
273	2018-07-28 16:29:16.651684+00	2018-07-28 16:29:16.658799+00	Priced Item(s)		2018-07-28 16:29:16.657775+00	7.00	t	5	273
274	2018-07-28 16:29:21.311753+00	2018-07-28 16:29:21.327492+00	Priced Item(s)		2018-07-28 16:29:21.327207+00	1.00	t	3	274
275	2018-07-28 16:30:05.251691+00	2018-07-28 16:30:05.26149+00	Priced Item(s)		2018-07-28 16:30:05.26124+00	3.00	t	5	275
276	2018-07-28 16:30:30.807863+00	2018-07-28 16:30:30.817955+00	Priced Item(s)		2018-07-28 16:30:30.817684+00	1.00	t	1	276
277	2018-07-28 16:30:49.527726+00	2018-07-28 16:30:49.543785+00	Priced Item(s)		2018-07-28 16:30:49.54323+00	14.00	t	5	277
278	2018-07-28 16:30:51.577176+00	2018-07-28 16:30:51.584872+00	Priced Item(s)		2018-07-28 16:30:51.584556+00	10.00	t	5	278
279	2018-07-28 16:31:13.449415+00	2018-07-28 16:31:13.459477+00	Priced Item(s)		2018-07-28 16:31:13.459196+00	25.00	t	3	279
280	2018-07-28 16:31:16.487236+00	2018-07-28 16:31:16.497795+00	Priced Item(s)		2018-07-28 16:31:16.497541+00	10.00	t	5	280
281	2018-07-28 16:31:24.115067+00	2018-07-28 16:31:24.121676+00	Priced Item(s)		2018-07-28 16:31:24.121434+00	10.00	t	5	281
282	2018-07-28 16:31:51.275474+00	2018-07-28 16:31:51.289924+00	Priced Item(s)		2018-07-28 16:31:51.288157+00	20.00	t	5	282
283	2018-07-28 16:32:16.575164+00	2018-07-28 16:32:16.586047+00	Priced Item(s)		2018-07-28 16:32:16.585653+00	25.00	t	5	283
284	2018-07-28 16:32:48.626604+00	2018-07-28 16:32:48.641601+00	Priced Item(s)		2018-07-28 16:32:48.641246+00	20.00	t	5	284
285	2018-07-28 16:32:50.422862+00	2018-07-28 16:32:50.433411+00	Priced Item(s)		2018-07-28 16:32:50.433144+00	8.00	t	5	285
286	2018-07-28 16:33:02.178908+00	2018-07-28 16:33:02.195296+00	Priced Item(s)		2018-07-28 16:33:02.194121+00	20.00	t	1	286
287	2018-07-28 16:33:19.830354+00	2018-07-28 16:33:19.850125+00	Priced Item(s)		2018-07-28 16:33:19.849859+00	40.00	t	3	287
288	2018-07-28 16:33:26.404475+00	2018-07-28 16:33:26.416444+00	Priced Item(s)		2018-07-28 16:33:26.41511+00	14.00	t	5	288
289	2018-07-28 16:34:03.040697+00	2018-07-28 16:34:03.051816+00	Priced Item(s)		2018-07-28 16:34:03.051541+00	15.00	t	5	289
290	2018-07-28 16:34:09.468684+00	2018-07-28 16:34:09.475762+00	Priced Item(s)		2018-07-28 16:34:09.475464+00	5.00	t	3	290
291	2018-07-28 16:34:33.081589+00	2018-07-28 16:34:33.094185+00	Priced Item(s)		2018-07-28 16:34:33.093914+00	20.00	t	5	291
292	2018-07-28 16:34:43.400699+00	2018-07-28 16:34:43.411205+00	Priced Item(s)		2018-07-28 16:34:43.410832+00	25.00	t	5	292
293	2018-07-28 16:35:10.775278+00	2018-07-28 16:35:10.789689+00	Priced Item(s)		2018-07-28 16:35:10.787431+00	35.00	t	5	293
294	2018-07-28 16:36:30.595719+00	2018-07-28 16:36:30.604433+00	Priced Item(s)		2018-07-28 16:36:30.604151+00	17.00	t	5	294
295	2018-07-28 16:36:58.615135+00	2018-07-28 16:36:58.625128+00	Priced Item(s)		2018-07-28 16:36:58.624743+00	1.50	t	1	295
296	2018-07-28 16:37:11.560798+00	2018-07-28 16:37:11.57189+00	Priced Item(s)		2018-07-28 16:37:11.571619+00	15.00	t	5	296
297	2018-07-28 16:37:20.836382+00	2018-07-28 16:37:20.841695+00	Priced Item(s)		2018-07-28 16:37:20.841491+00	6.00	t	3	297
298	2018-07-28 16:37:33.767741+00	2018-07-28 16:37:33.77318+00	Priced Item(s)		2018-07-28 16:37:33.772703+00	8.00	t	5	298
299	2018-07-28 16:38:05.55355+00	2018-07-28 16:38:05.569131+00	Priced Item(s)		2018-07-28 16:38:05.567255+00	10.00	t	5	299
300	2018-07-28 16:38:24.312271+00	2018-07-28 16:38:24.324108+00	Priced Item(s)		2018-07-28 16:38:24.323685+00	9.00	t	5	300
301	2018-07-28 16:38:27.984119+00	2018-07-28 16:38:28.011718+00	Priced Item(s)		2018-07-28 16:38:28.011397+00	20.00	t	5	301
302	2018-07-28 16:38:45.008346+00	2018-07-28 16:38:45.016247+00	Priced Item(s)		2018-07-28 16:38:45.015986+00	20.00	t	5	302
303	2018-07-28 16:39:00.735568+00	2018-07-28 16:39:00.742296+00	Priced Item(s)		2018-07-28 16:39:00.742022+00	12.00	t	5	303
304	2018-07-28 16:39:14.147263+00	2018-07-28 16:39:14.159789+00	Priced Item(s)		2018-07-28 16:39:14.159489+00	30.00	t	5	304
305	2018-07-28 16:39:53.217742+00	2018-07-28 16:39:53.226431+00	Priced Item(s)		2018-07-28 16:39:53.226188+00	12.00	t	5	305
306	2018-07-28 16:40:24.934382+00	2018-07-28 16:40:24.956073+00	Priced Item(s)		2018-07-28 16:40:24.955652+00	40.00	t	5	306
307	2018-07-28 16:41:55.552737+00	2018-07-28 16:41:55.560214+00	Priced Item(s)		2018-07-28 16:41:55.55996+00	10.00	t	5	307
308	2018-07-28 16:42:47.771823+00	2018-07-28 16:42:47.791537+00	Priced Item(s)		2018-07-28 16:42:47.791243+00	20.00	t	5	308
309	2018-07-28 16:43:35.227747+00	2018-07-28 16:43:35.251075+00	Priced Item(s)		2018-07-28 16:43:35.250346+00	1.00	t	5	309
310	2018-07-28 16:43:54.192109+00	2018-07-28 16:43:54.21675+00	Priced Item(s)		2018-07-28 16:43:54.215993+00	10.00	t	4	310
311	2018-07-28 16:44:20.410513+00	2018-07-28 16:44:20.42751+00	Priced Item(s)		2018-07-28 16:44:20.427226+00	14.00	t	5	311
312	2018-07-28 16:44:55.309067+00	2018-07-28 16:44:55.341963+00	Priced Item(s)		2018-07-28 16:44:55.341502+00	20.00	t	5	312
313	2018-07-28 16:45:37.935754+00	2018-07-28 16:45:38.007341+00	Priced Item(s)		2018-07-28 16:45:38.006436+00	17.00	t	5	313
314	2018-07-28 16:45:59.262271+00	2018-07-28 16:45:59.295774+00	Priced Item(s)		2018-07-28 16:45:59.295161+00	8.00	t	5	314
315	2018-07-28 16:46:11.854145+00	2018-07-28 16:46:11.885815+00	Priced Item(s)		2018-07-28 16:46:11.885529+00	13.00	t	5	315
316	2018-07-28 16:46:39.659771+00	2018-07-28 16:46:39.719215+00	Priced Item(s)		2018-07-28 16:46:39.717821+00	5.00	t	5	316
317	2018-07-28 16:46:53.651087+00	2018-07-28 16:46:53.673121+00	Priced Item(s)		2018-07-28 16:46:53.670611+00	45.00	t	5	317
318	2018-07-28 16:47:06.596123+00	2018-07-28 16:47:06.607396+00	Priced Item(s)		2018-07-28 16:47:06.607153+00	25.50	t	3	318
319	2018-07-28 16:47:07.131772+00	2018-07-28 16:47:07.147453+00	Priced Item(s)		2018-07-28 16:47:07.147172+00	30.00	t	5	319
320	2018-07-28 16:47:18.447586+00	2018-07-28 16:47:18.464223+00	Priced Item(s)		2018-07-28 16:47:18.463841+00	16.00	t	1	320
321	2018-07-28 16:47:49.653497+00	2018-07-28 16:47:49.665885+00	Priced Item(s)		2018-07-28 16:47:49.665591+00	15.00	t	5	321
322	2018-07-28 16:48:13.760433+00	2018-07-28 16:48:13.777506+00	Priced Item(s)		2018-07-28 16:48:13.775825+00	2.00	t	5	322
323	2018-07-28 16:48:31.535828+00	2018-07-28 16:48:31.549539+00	Priced Item(s)		2018-07-28 16:48:31.549133+00	10.00	t	5	323
324	2018-07-28 16:49:07.652233+00	2018-07-28 16:49:07.669713+00	Priced Item(s)		2018-07-28 16:49:07.668114+00	7.00	t	5	324
325	2018-07-28 16:49:12.15811+00	2018-07-28 16:49:12.182357+00	Priced Item(s)		2018-07-28 16:49:12.181968+00	8.00	t	5	325
326	2018-07-28 16:49:40.108812+00	2018-07-28 16:49:40.131064+00	Priced Item(s)		2018-07-28 16:49:40.126514+00	2.00	t	5	326
327	2018-07-28 16:49:42.605974+00	2018-07-28 16:49:42.614036+00	Priced Item(s)		2018-07-28 16:49:42.612567+00	30.00	t	5	327
328	2018-07-28 16:49:58.011948+00	2018-07-28 16:49:58.023579+00	Priced Item(s)		2018-07-28 16:49:58.023291+00	2.00	t	5	328
329	2018-07-28 16:50:07.189053+00	2018-07-28 16:50:07.206754+00	Priced Item(s)		2018-07-28 16:50:07.206379+00	10.00	t	5	329
330	2018-07-28 16:51:13.577041+00	2018-07-28 16:51:13.617441+00	Priced Item(s)		2018-07-28 16:51:13.617182+00	15.00	t	5	330
331	2018-07-28 16:51:13.636546+00	2018-07-28 16:51:13.655024+00	Priced Item(s)		2018-07-28 16:51:13.654716+00	15.00	t	5	331
332	2018-07-28 16:52:17.028624+00	2018-07-28 16:52:17.038144+00	Priced Item(s)		2018-07-28 16:52:17.037876+00	12.00	t	5	332
333	2018-07-28 16:52:33.656585+00	2018-07-28 16:52:33.669661+00	Priced Item(s)		2018-07-28 16:52:33.66943+00	20.00	t	5	333
334	2018-07-28 16:52:48.795757+00	2018-07-28 16:52:48.808502+00	Priced Item(s)		2018-07-28 16:52:48.808196+00	10.00	t	5	334
335	2018-07-28 16:53:01.966066+00	2018-07-28 16:53:01.982663+00	Priced Item(s)		2018-07-28 16:53:01.982126+00	2.00	t	5	335
336	2018-07-28 16:54:47.47993+00	2018-07-28 16:54:47.492031+00	Priced Item(s)		2018-07-28 16:54:47.491307+00	22.00	t	5	336
337	2018-07-28 16:55:53.507736+00	2018-07-28 16:55:53.517916+00	Priced Item(s)		2018-07-28 16:55:53.517647+00	5.00	t	5	337
338	2018-07-28 16:56:04.148605+00	2018-07-28 16:56:04.166017+00	Priced Item(s)		2018-07-28 16:56:04.165653+00	15.00	t	5	338
339	2018-07-28 16:57:00.067377+00	2018-07-28 16:57:00.098111+00	Priced Item(s)		2018-07-28 16:57:00.097878+00	17.00	t	5	339
340	2018-07-28 16:57:19.96383+00	2018-07-28 16:57:19.974128+00	Priced Item(s)		2018-07-28 16:57:19.972892+00	22.00	t	3	340
342	2018-07-28 16:58:33.012026+00	2018-07-28 16:58:33.033628+00	Priced Item(s)		2018-07-28 16:58:33.033142+00	18.00	t	5	342
343	2018-07-28 16:59:17.298499+00	2018-07-28 16:59:17.325416+00	Priced Item(s)		2018-07-28 16:59:17.325154+00	11.00	t	5	343
344	2018-07-28 16:59:32.452001+00	2018-07-28 16:59:32.469446+00	Priced Item(s)		2018-07-28 16:59:32.469183+00	18.00	t	5	344
345	2018-07-28 16:59:32.483986+00	2018-07-28 16:59:32.495397+00	Priced Item(s)		2018-07-28 16:59:32.495124+00	7.00	t	5	345
346	2018-07-28 16:59:38.21391+00	2018-07-28 16:59:38.220008+00	Priced Item(s)		2018-07-28 16:59:38.219513+00	12.00	t	1	346
347	2018-07-28 16:59:53.093058+00	2018-07-28 16:59:53.111471+00	Priced Item(s)		2018-07-28 16:59:53.111196+00	15.00	t	5	347
348	2018-07-28 17:00:45.845481+00	2018-07-28 17:00:45.85277+00	Priced Item(s)		2018-07-28 17:00:45.852512+00	10.00	t	5	348
349	2018-07-28 17:01:02.915655+00	2018-07-28 17:01:02.927501+00	Priced Item(s)		2018-07-28 17:01:02.927216+00	35.00	t	5	349
350	2018-07-28 17:01:42.847906+00	2018-07-28 17:01:42.861408+00	Priced Item(s)		2018-07-28 17:01:42.861114+00	20.00	t	5	350
341	2018-07-28 16:57:55.273703+00	2018-07-28 17:41:32.749359+00	Priced Item(s)		2018-07-28 16:57:55.28813+00	2.00	t	5	341
351	2018-07-28 17:02:19.475701+00	2018-07-28 17:02:19.484138+00	Priced Item(s)		2018-07-28 17:02:19.483421+00	25.00	t	5	351
352	2018-07-28 17:02:46.392179+00	2018-07-28 17:02:46.405262+00	Priced Item(s)		2018-07-28 17:02:46.404626+00	30.00	t	5	352
353	2018-07-28 17:03:25.469549+00	2018-07-28 17:03:25.477211+00	Priced Item(s)		2018-07-28 17:03:25.475223+00	4.00	t	5	353
356	2018-07-28 17:04:09.720118+00	2018-07-28 17:04:09.752761+00	Priced Item(s)		2018-07-28 17:04:09.752413+00	10.00	t	5	356
358	2018-07-28 17:04:27.571806+00	2018-07-28 17:04:27.581917+00	Priced Item(s)		2018-07-28 17:04:27.581204+00	10.00	t	5	358
359	2018-07-28 17:05:05.480138+00	2018-07-28 17:05:05.498708+00	Priced Item(s)		2018-07-28 17:05:05.498425+00	25.00	t	5	359
361	2018-07-28 17:05:35.790978+00	2018-07-28 17:05:35.79957+00	Priced Item(s)		2018-07-28 17:05:35.799247+00	40.00	t	5	361
362	2018-07-28 17:06:02.938895+00	2018-07-28 17:06:02.955969+00	Priced Item(s)		2018-07-28 17:06:02.955496+00	20.00	t	5	362
363	2018-07-28 17:08:56.317797+00	2018-07-28 17:08:56.340169+00	Priced Item(s)		2018-07-28 17:08:56.338928+00	4.00	t	5	363
354	2018-07-28 17:03:44.695903+00	2018-07-28 17:03:44.716214+00	Priced Item(s)		2018-07-28 17:03:44.715846+00	2.00	t	5	354
355	2018-07-28 17:03:51.21651+00	2018-07-28 17:03:51.226398+00	Priced Item(s)		2018-07-28 17:03:51.226125+00	10.00	t	5	355
357	2018-07-28 17:04:15.814896+00	2018-07-28 17:04:15.847577+00	Priced Item(s)		2018-07-28 17:04:15.843513+00	10.00	t	5	357
360	2018-07-28 17:05:14.959682+00	2018-07-28 17:05:14.968515+00	Priced Item(s)		2018-07-28 17:05:14.968291+00	2.00	t	3	360
365	2018-07-28 17:09:45.25172+00	2018-07-28 17:09:45.270734+00	Priced Item(s)		2018-07-28 17:09:45.270267+00	16.00	t	5	365
366	2018-07-28 17:09:57.442835+00	2018-07-28 17:09:57.451923+00	Priced Item(s)		2018-07-28 17:09:57.449105+00	20.00	t	5	366
367	2018-07-28 17:11:07.672485+00	2018-07-28 17:11:07.6836+00	Priced Item(s)		2018-07-28 17:11:07.68332+00	2.00	t	3	367
368	2018-07-28 17:11:57.307865+00	2018-07-28 17:11:57.317506+00	Priced Item(s)		2018-07-28 17:11:57.316984+00	10.00	t	5	368
369	2018-07-28 17:12:23.044379+00	2018-07-28 17:12:23.058861+00	Priced Item(s)		2018-07-28 17:12:23.05857+00	10.00	t	5	369
370	2018-07-28 17:12:35.86057+00	2018-07-28 17:12:35.884047+00	Priced Item(s)		2018-07-28 17:12:35.883738+00	6.00	t	5	370
371	2018-07-28 17:12:41.906025+00	2018-07-28 17:12:41.92239+00	Priced Item(s)		2018-07-28 17:12:41.921691+00	4.00	t	5	371
372	2018-07-28 17:12:50.33937+00	2018-07-28 17:12:50.345481+00	Priced Item(s)		2018-07-28 17:12:50.345188+00	15.00	t	5	372
373	2018-07-28 17:14:33.67529+00	2018-07-28 17:14:33.687606+00	Priced Item(s)		2018-07-28 17:14:33.687345+00	13.00	t	5	373
374	2018-07-28 17:14:46.447536+00	2018-07-28 17:14:46.456957+00	Priced Item(s)		2018-07-28 17:14:46.454463+00	5.00	t	5	374
375	2018-07-28 17:15:48.398675+00	2018-07-28 17:15:48.414919+00	Priced Item(s)		2018-07-28 17:15:48.408079+00	12.00	t	5	375
376	2018-07-28 17:16:13.508024+00	2018-07-28 17:16:13.520194+00	Priced Item(s)		2018-07-28 17:16:13.519927+00	0.50	t	3	376
377	2018-07-28 17:16:31.350806+00	2018-07-28 17:16:31.359464+00	Priced Item(s)		2018-07-28 17:16:31.359217+00	10.00	t	5	377
378	2018-07-28 17:16:45.83587+00	2018-07-28 17:16:45.848561+00	Priced Item(s)		2018-07-28 17:16:45.847708+00	11.00	t	5	378
379	2018-07-28 17:17:03.42619+00	2018-07-28 17:17:03.437084+00	Priced Item(s)		2018-07-28 17:17:03.43422+00	10.00	t	1	379
380	2018-07-28 17:17:26.763757+00	2018-07-28 17:17:26.771939+00	Priced Item(s)		2018-07-28 17:17:26.771665+00	0.40	t	2	380
381	2018-07-28 17:17:53.336802+00	2018-07-28 17:17:53.353093+00	Priced Item(s)		2018-07-28 17:17:53.350457+00	10.00	t	5	381
382	2018-07-28 17:17:54.159701+00	2018-07-28 17:17:54.171479+00	Priced Item(s)		2018-07-28 17:17:54.171196+00	10.00	t	1	382
383	2018-07-28 17:18:30.526469+00	2018-07-28 17:18:30.540949+00	Priced Item(s)		2018-07-28 17:18:30.538922+00	8.00	t	5	383
384	2018-07-28 17:19:12.126856+00	2018-07-28 17:19:12.13954+00	Priced Item(s)		2018-07-28 17:19:12.139195+00	13.00	t	1	384
385	2018-07-28 17:19:27.258908+00	2018-07-28 17:19:27.280025+00	Priced Item(s)		2018-07-28 17:19:27.279754+00	12.00	t	5	385
386	2018-07-28 17:20:00.403743+00	2018-07-28 17:20:00.412745+00	Priced Item(s)		2018-07-28 17:20:00.412065+00	5.00	t	1	386
387	2018-07-28 17:20:42.362689+00	2018-07-28 17:20:42.375774+00	Priced Item(s)		2018-07-28 17:20:42.37548+00	7.00	t	5	387
388	2018-07-28 17:20:53.962836+00	2018-07-28 17:20:53.978341+00	Priced Item(s)		2018-07-28 17:20:53.978062+00	8.00	t	5	388
389	2018-07-28 17:21:01.911781+00	2018-07-28 17:21:01.927767+00	Priced Item(s)		2018-07-28 17:21:01.927534+00	10.83	t	2	389
390	2018-07-28 17:21:12.372231+00	2018-07-28 17:21:12.385079+00	Priced Item(s)		2018-07-28 17:21:12.384805+00	4.00	t	5	390
391	2018-07-28 17:21:20.814253+00	2018-07-28 17:21:20.827837+00	Priced Item(s)		2018-07-28 17:21:20.827423+00	25.00	t	5	391
392	2018-07-28 17:21:32.349182+00	2018-07-28 17:21:32.360097+00	Priced Item(s)		2018-07-28 17:21:32.359827+00	19.00	t	5	392
393	2018-07-28 17:21:53.705507+00	2018-07-28 17:21:53.719692+00	Priced Item(s)		2018-07-28 17:21:53.719431+00	75.00	t	1	393
394	2018-07-28 17:22:18.403822+00	2018-07-28 17:22:18.432401+00	Priced Item(s)		2018-07-28 17:22:18.431621+00	25.00	t	5	394
395	2018-07-28 17:23:45.633364+00	2018-07-28 17:23:45.645712+00	Priced Item(s)		2018-07-28 17:23:45.644263+00	10.00	t	1	395
396	2018-07-28 17:23:48.278161+00	2018-07-28 17:23:48.287929+00	Priced Item(s)		2018-07-28 17:23:48.287574+00	7.00	t	4	396
397	2018-07-28 17:23:51.826188+00	2018-07-28 17:23:51.848874+00	Priced Item(s)		2018-07-28 17:23:51.843831+00	18.00	t	5	397
398	2018-07-28 17:24:03.588516+00	2018-07-28 17:24:03.59948+00	Priced Item(s)		2018-07-28 17:24:03.599148+00	25.00	t	5	398
399	2018-07-28 17:24:11.027956+00	2018-07-28 17:24:11.041531+00	Priced Item(s)		2018-07-28 17:24:11.039769+00	5.00	t	1	399
400	2018-07-28 17:24:11.160307+00	2018-07-28 17:24:11.17149+00	Priced Item(s)		2018-07-28 17:24:11.171219+00	6.00	t	3	400
401	2018-07-28 17:24:14.111581+00	2018-07-28 17:24:14.127413+00	Priced Item(s)		2018-07-28 17:24:14.126141+00	1.00	t	5	401
402	2018-07-28 17:24:22.264543+00	2018-07-28 17:24:22.281941+00	Priced Item(s)		2018-07-28 17:24:22.281566+00	10.00	t	5	402
403	2018-07-28 17:24:34.878893+00	2018-07-28 17:24:34.903664+00	Priced Item(s)		2018-07-28 17:24:34.903263+00	1.00	t	5	403
404	2018-07-28 17:24:36.921852+00	2018-07-28 17:24:36.929001+00	Priced Item(s)		2018-07-28 17:24:36.92877+00	20.00	t	5	404
405	2018-07-28 17:24:39.49428+00	2018-07-28 17:24:39.50198+00	Priced Item(s)		2018-07-28 17:24:39.501695+00	2.00	t	3	405
406	2018-07-28 17:24:51.945697+00	2018-07-28 17:24:51.973059+00	Priced Item(s)		2018-07-28 17:24:51.967479+00	20.00	t	5	406
407	2018-07-28 17:25:16.64374+00	2018-07-28 17:25:16.652826+00	Priced Item(s)		2018-07-28 17:25:16.652549+00	30.00	t	5	407
408	2018-07-28 17:25:26.494617+00	2018-07-28 17:25:26.501855+00	Priced Item(s)		2018-07-28 17:25:26.500443+00	5.00	t	3	408
409	2018-07-28 17:25:49.594889+00	2018-07-28 17:25:49.604657+00	Priced Item(s)		2018-07-28 17:25:49.604172+00	10.00	t	5	409
410	2018-07-28 17:25:56.86994+00	2018-07-28 17:25:56.883545+00	Priced Item(s)		2018-07-28 17:25:56.883256+00	6.00	t	1	410
411	2018-07-28 17:26:47.414744+00	2018-07-28 17:26:47.422078+00	Priced Item(s)		2018-07-28 17:26:47.421437+00	24.00	t	1	411
412	2018-07-28 17:27:21.465408+00	2018-07-28 17:27:21.473947+00	Priced Item(s)		2018-07-28 17:27:21.473674+00	18.00	t	1	412
413	2018-07-28 17:27:42.103941+00	2018-07-28 17:27:42.116177+00	Priced Item(s)		2018-07-28 17:27:42.114789+00	5.00	t	5	413
414	2018-07-28 17:27:50.723855+00	2018-07-28 17:27:50.733726+00	Priced Item(s)		2018-07-28 17:27:50.73346+00	10.00	t	5	414
415	2018-07-28 17:28:06.559722+00	2018-07-28 17:28:06.572794+00	Priced Item(s)		2018-07-28 17:28:06.572167+00	20.00	t	5	415
416	2018-07-28 17:28:25.190027+00	2018-07-28 17:28:25.212686+00	Priced Item(s)		2018-07-28 17:28:25.212415+00	1.00	t	3	416
417	2018-07-28 17:28:35.737426+00	2018-07-28 17:28:35.764843+00	Priced Item(s)		2018-07-28 17:28:35.764553+00	20.00	t	5	417
418	2018-07-28 17:28:42.143698+00	2018-07-28 17:28:42.156124+00	Priced Item(s)		2018-07-28 17:28:42.155815+00	2.00	t	5	418
419	2018-07-28 17:29:17.234782+00	2018-07-28 17:29:17.291557+00	Priced Item(s)		2018-07-28 17:29:17.29127+00	20.00	t	5	419
420	2018-07-28 17:30:01.309843+00	2018-07-28 17:30:01.326542+00	Priced Item(s)		2018-07-28 17:30:01.326257+00	30.00	t	5	420
421	2018-07-28 17:32:43.228836+00	2018-07-28 17:32:43.237894+00	Priced Item(s)		2018-07-28 17:32:43.237555+00	2.00	t	5	421
422	2018-07-28 17:34:53.791712+00	2018-07-28 17:34:53.807602+00	Priced Item(s)		2018-07-28 17:34:53.807323+00	12.00	t	1	423
423	2018-07-28 17:35:30.681043+00	2018-07-28 17:35:30.689698+00	Priced Item(s)		2018-07-28 17:35:30.689419+00	15.00	t	5	424
424	2018-07-28 17:36:13.003251+00	2018-07-28 17:36:13.013646+00	Priced Item(s)		2018-07-28 17:36:13.012994+00	10.00	t	5	425
425	2018-07-28 17:36:41.916137+00	2018-07-28 17:36:41.931492+00	Priced Item(s)		2018-07-28 17:36:41.9312+00	10.00	t	5	427
426	2018-07-28 17:37:00.620683+00	2018-07-28 17:37:00.639536+00	Priced Item(s)		2018-07-28 17:37:00.639261+00	5.00	t	1	428
427	2018-07-28 17:37:22.633387+00	2018-07-28 17:37:22.65097+00	Priced Item(s)		2018-07-28 17:37:22.650254+00	80.00	t	4	429
428	2018-07-28 17:39:01.638166+00	2018-07-28 17:39:01.655964+00	Priced Item(s)		2018-07-28 17:39:01.655685+00	10.00	t	2	432
429	2018-07-28 17:39:22.296249+00	2018-07-28 17:39:22.304094+00	Priced Item(s)		2018-07-28 17:39:22.303824+00	5.00	t	5	433
430	2018-07-28 17:41:01.381792+00	2018-07-28 17:41:01.399447+00	Priced Item(s)		2018-07-28 17:41:01.399183+00	20.00	t	5	435
431	2018-07-28 17:41:16.676141+00	2018-07-28 17:41:16.70777+00	Priced Item(s)		2018-07-28 17:41:16.70148+00	1.00	t	4	437
432	2018-07-28 17:42:21.868624+00	2018-07-28 17:42:21.877376+00	Priced Item(s)		2018-07-28 17:42:21.876469+00	30.00	t	5	438
433	2018-07-28 17:43:32.185001+00	2018-07-28 17:43:32.193536+00	Priced Item(s)		2018-07-28 17:43:32.193299+00	3.00	t	5	440
434	2018-07-28 17:44:17.958821+00	2018-07-28 17:44:17.982491+00	Priced Item(s)		2018-07-28 17:44:17.982191+00	10.00	t	5	441
435	2018-07-28 17:44:36.972507+00	2018-07-28 17:44:36.987473+00	Priced Item(s)		2018-07-28 17:44:36.987198+00	10.00	t	5	442
436	2018-07-28 17:44:45.476904+00	2018-07-28 17:44:45.485264+00	Priced Item(s)		2018-07-28 17:44:45.483803+00	2.00	t	4	444
437	2018-07-28 17:45:08.932066+00	2018-07-28 17:45:08.952619+00	Priced Item(s)		2018-07-28 17:45:08.952311+00	10.00	t	5	445
438	2018-07-28 17:45:19.83874+00	2018-07-28 17:45:19.848763+00	Priced Item(s)		2018-07-28 17:45:19.848511+00	1.00	t	5	446
439	2018-07-28 17:45:37.4409+00	2018-07-28 17:45:37.453931+00	Priced Item(s)		2018-07-28 17:45:37.453654+00	13.00	t	5	447
440	2018-07-28 17:46:03.913485+00	2018-07-28 17:46:03.929949+00	Priced Item(s)		2018-07-28 17:46:03.929627+00	9.00	t	5	448
441	2018-07-28 17:46:30.678772+00	2018-07-28 17:46:30.72454+00	Priced Item(s)		2018-07-28 17:46:30.72427+00	10.00	t	5	449
442	2018-07-28 17:46:34.966305+00	2018-07-28 17:46:35.007432+00	Priced Item(s)		2018-07-28 17:46:35.007172+00	5.00	t	5	450
443	2018-07-28 17:47:07.792054+00	2018-07-28 17:47:07.7989+00	Priced Item(s)		2018-07-28 17:47:07.798644+00	13.00	t	5	452
364	2018-07-28 17:09:32.797522+00	2018-07-28 17:09:32.809899+00	Priced Item(s)		2018-07-28 17:09:32.80962+00	20.00	t	5	\N
444	2018-07-28 17:47:42.356875+00	2018-07-28 17:47:42.369676+00	Priced Item(s)		2018-07-28 17:47:42.367737+00	10.00	t	5	453
446	2018-07-28 17:48:04.976316+00	2018-07-28 17:48:04.98725+00	Priced Item(s)		2018-07-28 17:48:04.985101+00	2.00	t	4	456
447	2018-07-28 17:48:17.861315+00	2018-07-28 17:48:17.880837+00	Priced Item(s)		2018-07-28 17:48:17.88059+00	7.00	t	5	457
445	2018-07-28 17:48:02.31447+00	2018-07-28 17:48:02.323861+00	Priced Item(s)		2018-07-28 17:48:02.323346+00	20.00	t	5	455
448	2018-07-28 17:48:34.621722+00	2018-07-28 17:48:34.628166+00	Priced Item(s)		2018-07-28 17:48:34.627834+00	15.00	t	2	458
449	2018-07-28 17:48:50.267819+00	2018-07-28 17:48:50.277104+00	Priced Item(s)		2018-07-28 17:48:50.276866+00	21.50	t	1	459
450	2018-07-28 17:49:21.063798+00	2018-07-28 17:49:21.075585+00	Priced Item(s)		2018-07-28 17:49:21.0753+00	6.00	t	1	460
451	2018-07-28 17:49:42.004212+00	2018-07-28 17:49:42.019566+00	Priced Item(s)		2018-07-28 17:49:42.019266+00	8.00	t	5	462
452	2018-07-28 17:51:00.58364+00	2018-07-28 17:51:00.595698+00	Priced Item(s)		2018-07-28 17:51:00.595273+00	26.00	t	5	463
453	2018-07-28 17:51:13.207167+00	2018-07-28 17:51:13.30651+00	Priced Item(s)		2018-07-28 17:51:13.304179+00	2.00	t	5	465
454	2018-07-28 17:51:16.031762+00	2018-07-28 17:51:16.051213+00	Priced Item(s)		2018-07-28 17:51:16.050817+00	29.00	t	1	466
455	2018-07-28 17:51:40.551307+00	2018-07-28 17:51:40.561678+00	Priced Item(s)		2018-07-28 17:51:40.561009+00	6.00	t	5	467
456	2018-07-28 17:51:57.915518+00	2018-07-28 17:51:57.929896+00	Priced Item(s)		2018-07-28 17:51:57.929311+00	10.00	t	5	468
457	2018-07-28 17:52:46.163619+00	2018-07-28 17:52:46.171261+00	Priced Item(s)		2018-07-28 17:52:46.170549+00	10.00	t	5	470
458	2018-07-28 17:53:02.36633+00	2018-07-28 17:53:02.379443+00	Priced Item(s)		2018-07-28 17:53:02.379179+00	3.00	t	5	471
459	2018-07-28 17:54:05.744776+00	2018-07-28 17:54:05.751739+00	Priced Item(s)		2018-07-28 17:54:05.751415+00	5.00	t	5	473
460	2018-07-28 17:55:43.435916+00	2018-07-28 17:55:43.450807+00	Priced Item(s)		2018-07-28 17:55:43.449833+00	2.00	t	5	474
461	2018-07-28 17:56:27.987877+00	2018-07-28 17:56:27.999302+00	Priced Item(s)		2018-07-28 17:56:27.999052+00	1.00	t	5	475
462	2018-07-28 17:57:51.575555+00	2018-07-28 17:57:51.589814+00	Priced Item(s)		2018-07-28 17:57:51.589444+00	2.00	t	3	477
463	2018-07-28 18:00:57.576182+00	2018-07-28 18:00:57.608749+00	Priced Item(s)		2018-07-28 18:00:57.608465+00	10.00	t	5	479
206	2018-07-28 16:07:17.483672+00	2018-07-28 16:07:17.495453+00	Priced Item(s)		2018-07-28 16:07:17.495183+00	6.00	t	1	\N
464	2018-07-28 18:02:39.071999+00	2018-07-28 18:02:39.091601+00	Priced Item(s)		2018-07-28 18:02:39.091337+00	0.00	t	3	480
465	2018-07-28 18:03:13.614671+00	2018-07-28 18:03:13.62757+00	Priced Item(s)		2018-07-28 18:03:13.627251+00	10.00	t	3	481
466	2018-07-28 18:04:13.079648+00	2018-07-28 18:04:13.093546+00	Priced Item(s)		2018-07-28 18:04:13.093309+00	15.00	t	5	482
467	2018-07-28 18:05:08.433484+00	2018-07-28 18:05:08.445239+00	Priced Item(s)		2018-07-28 18:05:08.444975+00	4.00	t	5	483
468	2018-07-28 18:05:15.245108+00	2018-07-28 18:05:15.257948+00	Priced Item(s)		2018-07-28 18:05:15.257681+00	15.00	t	3	484
470	2018-07-28 18:06:21.483806+00	2018-07-28 18:06:21.492173+00	Priced Item(s)		2018-07-28 18:06:21.491718+00	22.00	t	5	486
471	2018-07-28 18:07:31.523528+00	2018-07-28 18:07:31.540733+00	Priced Item(s)		2018-07-28 18:07:31.540442+00	20.15	t	2	487
472	2018-07-28 18:07:45.361585+00	2018-07-28 18:07:45.377007+00	Priced Item(s)		2018-07-28 18:07:45.375263+00	30.00	t	5	488
473	2018-07-28 18:08:19.129003+00	2018-07-28 18:08:19.147912+00	Priced Item(s)		2018-07-28 18:08:19.147633+00	10.00	t	5	489
474	2018-07-28 18:09:08.672232+00	2018-07-28 18:09:08.680832+00	Priced Item(s)		2018-07-28 18:09:08.679779+00	4.00	t	5	490
475	2018-07-28 18:10:04.424944+00	2018-07-28 18:10:04.437918+00	Priced Item(s)		2018-07-28 18:10:04.43763+00	3.00	t	5	491
476	2018-07-28 18:10:48.220121+00	2018-07-28 18:10:48.232651+00	Priced Item(s)		2018-07-28 18:10:48.232435+00	21.00	t	5	492
477	2018-07-28 18:12:30.411227+00	2018-07-28 18:12:30.423479+00	Priced Item(s)		2018-07-28 18:12:30.423207+00	1.00	t	5	493
478	2018-07-28 18:13:31.263705+00	2018-07-28 18:13:31.279435+00	Priced Item(s)		2018-07-28 18:13:31.279166+00	10.00	t	1	494
479	2018-07-28 18:13:34.057955+00	2018-07-28 18:13:34.063701+00	Priced Item(s)		2018-07-28 18:13:34.06333+00	2.00	t	5	495
480	2018-07-28 18:14:23.480469+00	2018-07-28 18:14:23.489376+00	Priced Item(s)		2018-07-28 18:14:23.489094+00	1.00	t	3	496
481	2018-07-28 18:15:28.69172+00	2018-07-28 18:15:28.708219+00	Priced Item(s)		2018-07-28 18:15:28.707986+00	12.00	t	1	498
482	2018-07-28 18:15:41.239618+00	2018-07-28 18:15:41.246587+00	Priced Item(s)		2018-07-28 18:15:41.246238+00	10.00	t	5	499
483	2018-07-28 18:15:48.336155+00	2018-07-28 18:15:48.347857+00	Priced Item(s)		2018-07-28 18:15:48.347569+00	1.00	t	5	500
484	2018-07-28 18:16:08.451807+00	2018-07-28 18:16:08.463931+00	Priced Item(s)		2018-07-28 18:16:08.463453+00	6.00	t	1	501
485	2018-07-28 18:17:02.936825+00	2018-07-28 18:17:02.951644+00	Priced Item(s)		2018-07-28 18:17:02.951358+00	20.00	t	5	503
486	2018-07-28 18:17:11.552695+00	2018-07-28 18:17:11.567563+00	Priced Item(s)		2018-07-28 18:17:11.567279+00	22.50	t	1	504
487	2018-07-28 18:18:20.689131+00	2018-07-28 18:18:20.694765+00	Priced Item(s)		2018-07-28 18:18:20.694543+00	4.00	t	3	506
488	2018-07-28 18:18:27.553867+00	2018-07-28 18:18:27.56366+00	Priced Item(s)		2018-07-28 18:18:27.563354+00	5.00	t	5	507
489	2018-07-28 18:18:41.310923+00	2018-07-28 18:18:41.325104+00	Priced Item(s)		2018-07-28 18:18:41.324513+00	6.00	t	5	508
490	2018-07-28 18:18:51.257619+00	2018-07-28 18:18:51.271502+00	Priced Item(s)		2018-07-28 18:18:51.271225+00	12.00	t	1	509
491	2018-07-28 18:19:14.769377+00	2018-07-28 18:19:14.783472+00	Priced Item(s)		2018-07-28 18:19:14.783183+00	3.00	t	3	510
492	2018-07-28 18:19:51.168279+00	2018-07-28 18:19:51.175955+00	Donation: Blessing Bid		2018-07-28 18:19:51.175728+00	0.00	t	\N	512
493	2018-07-28 18:20:09.247467+00	2018-07-28 18:20:09.260326+00	Donation: Blessing Bid		2018-07-28 18:20:09.260034+00	0.00	t	\N	514
494	2018-07-28 18:20:20.930643+00	2018-07-28 18:20:20.935871+00	Donation: Blessing Bid		2018-07-28 18:20:20.935608+00	0.00	t	\N	515
495	2018-07-28 18:20:23.838299+00	2018-07-28 18:20:23.844336+00			2018-07-28 18:20:23.843459+00	0.00	t	\N	516
496	2018-07-28 18:20:31.320839+00	2018-07-28 18:20:31.327352+00	Donation: Blessing Bid		2018-07-28 18:20:31.326928+00	0.00	t	\N	517
497	2018-07-28 18:20:44.738522+00	2018-07-28 18:20:44.753912+00	Donation: Blessing Bid		2018-07-28 18:20:44.753581+00	0.00	t	\N	518
498	2018-07-28 18:20:46.710025+00	2018-07-28 18:20:46.734819+00	Priced Item(s)		2018-07-28 18:20:46.723133+00	10.00	t	5	519
499	2018-07-28 18:21:18.944626+00	2018-07-28 18:21:18.956511+00	Donation: Blessing Bid		2018-07-28 18:21:18.95619+00	0.00	t	\N	521
500	2018-07-28 18:21:29.537881+00	2018-07-28 18:21:29.55056+00	Donation: Blessing Bid		2018-07-28 18:21:29.550274+00	0.00	t	\N	522
501	2018-07-28 18:21:42.140529+00	2018-07-28 18:21:42.152846+00	Donation: Blessing Bid		2018-07-28 18:21:42.152565+00	0.00	t	\N	524
502	2018-07-28 18:21:55.134252+00	2018-07-28 18:21:55.142982+00	Donation: Blessing Bid		2018-07-28 18:21:55.142735+00	0.00	t	\N	525
503	2018-07-28 18:22:09.237943+00	2018-07-28 18:22:09.246614+00	Donation: Blessing Bid		2018-07-28 18:22:09.246377+00	0.00	t	\N	528
504	2018-07-28 18:22:37.179683+00	2018-07-28 18:22:37.199158+00	Donation: Blessing Bid		2018-07-28 18:22:37.198783+00	0.00	t	\N	529
505	2018-07-28 18:22:47.531752+00	2018-07-28 18:22:47.542886+00	Priced Item(s)		2018-07-28 18:22:47.542622+00	12.00	t	1	530
506	2018-07-28 18:22:53.912486+00	2018-07-28 18:22:53.922606+00	Donation: Blessing Bid		2018-07-28 18:22:53.922096+00	0.00	t	\N	532
507	2018-07-28 18:23:16.87737+00	2018-07-28 18:23:16.885447+00	Donation: Blessing Bid		2018-07-28 18:23:16.885188+00	0.00	t	\N	533
508	2018-07-28 18:23:27.649961+00	2018-07-28 18:23:27.667485+00	Priced Item(s)		2018-07-28 18:23:27.667223+00	2.50	t	1	534
509	2018-07-28 18:24:44.857763+00	2018-07-28 18:24:44.871674+00			2018-07-28 18:24:44.871413+00	0.00	t	\N	537
510	2018-07-28 18:25:12.875363+00	2018-07-28 18:25:12.889668+00	Priced Item(s)		2018-07-28 18:25:12.889403+00	5.00	t	5	538
511	2018-07-28 18:25:29.016908+00	2018-07-28 18:25:29.025677+00	Donation: Blessing Bid		2018-07-28 18:25:29.02494+00	0.00	t	\N	540
512	2018-07-28 18:25:52.446503+00	2018-07-28 18:25:52.452965+00	Donation: Blessing Bid		2018-07-28 18:25:52.45216+00	0.00	t	\N	541
513	2018-07-28 18:26:05.519308+00	2018-07-28 18:26:05.531144+00	Donation: Blessing Bid		2018-07-28 18:26:05.530851+00	0.00	t	\N	542
514	2018-07-28 18:26:23.198127+00	2018-07-28 18:26:23.204391+00	Donation: Blessing Bid		2018-07-28 18:26:23.203706+00	0.00	t	\N	543
515	2018-07-28 18:27:57.571071+00	2018-07-28 18:27:57.580358+00	Priced Item(s)		2018-07-28 18:27:57.580119+00	9.00	t	5	545
519	2018-07-28 18:29:41.747733+00	2018-07-28 18:29:41.763471+00	Priced Item(s)		2018-07-28 18:29:41.76319+00	40.00	t	3	549
517	2018-07-28 18:29:07.14254+00	2018-07-28 18:29:07.155542+00	Priced Item(s)		2018-07-28 18:29:07.155268+00	12.00	t	1	547
516	2018-07-28 18:28:30.708007+00	2018-07-28 18:28:30.72626+00			2018-07-28 18:28:30.725914+00	0.00	t	\N	\N
518	2018-07-28 18:29:27.890886+00	2018-07-28 18:29:27.903439+00			2018-07-28 18:29:27.903177+00	0.00	t	\N	548
520	2018-07-28 18:29:51.455862+00	2018-07-28 18:29:51.476075+00	Donation: Blessing Bid		2018-07-28 18:29:51.4758+00	0.00	t	\N	550
521	2018-07-28 18:30:08.53163+00	2018-07-28 18:30:08.545485+00	Donation: Blessing Bid		2018-07-28 18:30:08.542495+00	0.00	t	\N	551
522	2018-07-28 18:30:15.699155+00	2018-07-28 18:30:15.707893+00	Priced Item(s)		2018-07-28 18:30:15.707647+00	5.00	t	5	552
523	2018-07-28 18:30:56.702865+00	2018-07-28 18:30:56.710568+00	Priced Item(s)		2018-07-28 18:30:56.710295+00	10.00	t	5	554
524	2018-07-28 18:30:57.740997+00	2018-07-28 18:30:57.760243+00	Priced Item(s)		2018-07-28 18:30:57.75884+00	5.00	t	3	555
525	2018-07-28 18:31:40.164383+00	2018-07-28 18:31:40.172444+00			2018-07-28 18:31:40.171968+00	0.00	t	\N	556
526	2018-07-28 18:31:54.386015+00	2018-07-28 18:31:54.437498+00	Priced Item(s)		2018-07-28 18:31:54.437236+00	10.00	t	1	557
527	2018-07-28 18:31:58.978202+00	2018-07-28 18:31:58.986752+00	Donation: Blessing Bid		2018-07-28 18:31:58.986511+00	0.00	t	\N	558
469	2018-07-28 18:06:14.271906+00	2018-07-28 19:46:40.633899+00	Priced Item(s)		2018-07-28 18:06:14.287228+00	152.00	t	3	485
528	2018-07-28 18:32:16.595713+00	2018-07-28 18:32:16.605754+00	Donation: Blessing Bid		2018-07-28 18:32:16.605481+00	0.00	t	\N	560
531	2018-07-28 18:32:41.155756+00	2018-07-28 18:32:41.17236+00			2018-07-28 18:32:41.171925+00	0.00	t	\N	563
532	2018-07-28 18:32:48.159498+00	2018-07-28 18:32:48.181157+00	Donation: Blessing Bid		2018-07-28 18:32:48.180872+00	0.00	t	\N	564
534	2018-07-28 18:33:27.230207+00	2018-07-28 18:33:27.301725+00	Donation: Blessing Bid		2018-07-28 18:33:27.301441+00	0.00	t	\N	\N
538	2018-07-28 18:34:10.671986+00	2018-07-28 18:34:10.683499+00	Donation: Blessing Bid		2018-07-28 18:34:10.68323+00	0.00	t	\N	570
540	2018-07-28 18:34:41.2202+00	2018-07-28 18:34:41.233513+00	Donation: Blessing Bid		2018-07-28 18:34:41.233276+00	0.00	t	\N	573
541	2018-07-28 18:35:10.851034+00	2018-07-28 18:35:10.863524+00	Donation: Blessing Bid		2018-07-28 18:35:10.863243+00	0.00	t	\N	574
542	2018-07-28 18:35:24.205235+00	2018-07-28 18:35:24.220499+00	Donation: Blessing Bid		2018-07-28 18:35:24.220227+00	0.00	t	\N	575
548	2018-07-28 18:39:06.668022+00	2018-07-28 18:39:06.674489+00	Donation: Blessing Bid		2018-07-28 18:39:06.674164+00	0.00	t	\N	583
529	2018-07-28 18:32:28.92254+00	2018-07-28 18:32:28.932854+00	Priced Item(s)		2018-07-28 18:32:28.932129+00	10.00	t	4	561
530	2018-07-28 18:32:32.368256+00	2018-07-28 18:32:32.376846+00	Donation: Blessing Bid		2018-07-28 18:32:32.376617+00	0.00	t	\N	562
533	2018-07-28 18:33:09.36389+00	2018-07-28 18:33:09.373456+00	Donation: Blessing Bid		2018-07-28 18:33:09.373171+00	0.00	t	\N	565
535	2018-07-28 18:33:33.451681+00	2018-07-28 18:33:33.457911+00	Priced Item(s)		2018-07-28 18:33:33.45767+00	6.00	t	1	567
536	2018-07-28 18:33:41.200279+00	2018-07-28 18:33:41.205009+00	Donation: Blessing Bid		2018-07-28 18:33:41.204811+00	0.00	t	\N	568
537	2018-07-28 18:34:04.996834+00	2018-07-28 18:34:05.008013+00	Priced Item(s)		2018-07-28 18:34:05.007754+00	0.50	t	2	569
539	2018-07-28 18:34:24.473585+00	2018-07-28 18:34:24.48938+00	Donation: Blessing Bid		2018-07-28 18:34:24.489122+00	0.00	t	\N	572
543	2018-07-28 18:35:53.116958+00	2018-07-28 18:35:53.133432+00	Donation: Blessing Bid		2018-07-28 18:35:53.132771+00	0.00	t	\N	576
544	2018-07-28 18:36:08.942186+00	2018-07-28 18:36:08.947858+00	Priced Item(s)		2018-07-28 18:36:08.947311+00	15.00	t	5	578
545	2018-07-28 18:37:44.323679+00	2018-07-28 18:37:44.334458+00	Priced Item(s)		2018-07-28 18:37:44.334196+00	8.00	t	5	579
546	2018-07-28 18:38:39.07467+00	2018-07-28 18:38:39.079942+00	Donation: Blessing Bid		2018-07-28 18:38:39.079716+00	0.00	t	\N	581
547	2018-07-28 18:38:53.634563+00	2018-07-28 18:38:53.646317+00	Donation: Blessing Bid		2018-07-28 18:38:53.645451+00	0.00	t	\N	582
549	2018-07-28 18:40:08.991528+00	2018-07-28 18:40:09.003643+00	Donation: Blessing Bid		2018-07-28 18:40:09.003373+00	0.00	t	\N	585
550	2018-07-28 18:40:34.551316+00	2018-07-28 18:40:34.557341+00	Donation: Blessing Bid		2018-07-28 18:40:34.557109+00	0.00	t	\N	586
551	2018-07-28 18:40:49.495814+00	2018-07-28 18:40:49.50338+00	Donation: Blessing Bid		2018-07-28 18:40:49.503144+00	0.00	t	\N	587
552	2018-07-28 18:41:19.575894+00	2018-07-28 18:41:19.591136+00	Donation: Blessing Bid		2018-07-28 18:41:19.590753+00	0.00	t	\N	588
553	2018-07-28 18:41:39.615123+00	2018-07-28 18:41:39.629187+00	Donation: Blessing Bid		2018-07-28 18:41:39.628924+00	0.00	t	\N	589
554	2018-07-28 18:41:55.196483+00	2018-07-28 18:41:55.207403+00	Donation: Blessing Bid		2018-07-28 18:41:55.20718+00	0.00	t	\N	591
555	2018-07-28 18:41:56.981507+00	2018-07-28 18:41:56.995244+00	Priced Item(s)		2018-07-28 18:41:56.994982+00	0.00	t	5	592
556	2018-07-28 18:42:17.970703+00	2018-07-28 18:42:17.983485+00	Donation: Blessing Bid		2018-07-28 18:42:17.983217+00	0.00	t	\N	593
557	2018-07-28 18:42:34.263859+00	2018-07-28 18:42:34.277822+00	Donation: Blessing Bid		2018-07-28 18:42:34.277528+00	0.00	t	\N	594
558	2018-07-28 18:42:38.173715+00	2018-07-28 18:42:38.178928+00	Priced Item(s)		2018-07-28 18:42:38.178678+00	5.00	t	5	595
559	2018-07-28 18:42:57.367386+00	2018-07-28 18:42:57.373734+00	Priced Item(s)		2018-07-28 18:42:57.373505+00	2.00	t	5	596
560	2018-07-28 18:43:20.649586+00	2018-07-28 18:43:20.660006+00	Priced Item(s)		2018-07-28 18:43:20.659758+00	5.00	t	5	597
561	2018-07-28 18:44:03.706551+00	2018-07-28 18:44:03.727109+00	Donation: Blessing Bid		2018-07-28 18:44:03.726518+00	0.00	t	\N	599
562	2018-07-28 18:44:24.737853+00	2018-07-28 18:44:24.744003+00	Donation: Blessing Bid		2018-07-28 18:44:24.743488+00	0.00	t	\N	600
563	2018-07-28 18:44:40.672549+00	2018-07-28 18:44:40.683653+00	Donation: Blessing Bid		2018-07-28 18:44:40.683333+00	0.00	t	\N	601
564	2018-07-28 18:44:52.527251+00	2018-07-28 18:44:52.542832+00	Priced Item(s)		2018-07-28 18:44:52.542051+00	12.00	t	1	602
565	2018-07-28 18:44:54.335886+00	2018-07-28 18:44:54.354071+00	Donation: Blessing Bid		2018-07-28 18:44:54.352372+00	0.00	t	\N	603
566	2018-07-28 18:45:11.41578+00	2018-07-28 18:45:11.429615+00	Donation: Blessing Bid		2018-07-28 18:45:11.429355+00	0.00	t	\N	604
567	2018-07-28 18:45:24.906834+00	2018-07-28 18:45:24.928678+00	Donation: Blessing Bid		2018-07-28 18:45:24.928413+00	0.00	t	\N	605
568	2018-07-28 18:45:41.294076+00	2018-07-28 18:45:41.307575+00	Donation: Blessing Bid		2018-07-28 18:45:41.307313+00	0.00	t	\N	606
569	2018-07-28 18:46:12.189641+00	2018-07-28 18:46:12.197734+00	Donation: Blessing Bid		2018-07-28 18:46:12.1975+00	0.00	t	\N	608
570	2018-07-28 18:46:34.051425+00	2018-07-28 18:46:34.05682+00	Donation: Blessing Bid		2018-07-28 18:46:34.056397+00	0.00	t	\N	609
571	2018-07-28 18:46:49.959499+00	2018-07-28 18:46:49.986805+00	Donation: Blessing Bid		2018-07-28 18:46:49.983241+00	0.00	t	\N	611
572	2018-07-28 18:47:06.304019+00	2018-07-28 18:47:06.321435+00	Donation: Blessing Bid		2018-07-28 18:47:06.319245+00	0.00	t	\N	612
573	2018-07-28 18:48:18.586083+00	2018-07-28 18:48:18.592337+00	Donation: Blessing Bid		2018-07-28 18:48:18.591859+00	0.00	t	\N	613
574	2018-07-28 18:49:02.508629+00	2018-07-28 18:49:02.515275+00	Donation: Blessing Bid		2018-07-28 18:49:02.515037+00	0.00	t	\N	615
575	2018-07-28 18:49:41.731832+00	2018-07-28 18:49:41.73887+00	Donation: Blessing Bid		2018-07-28 18:49:41.738645+00	0.00	t	\N	616
576	2018-07-28 18:49:54.924155+00	2018-07-28 18:49:54.940153+00	Donation: Blessing Bid		2018-07-28 18:49:54.938564+00	0.00	t	\N	617
577	2018-07-28 18:50:53.296743+00	2018-07-28 18:50:53.302217+00	Donation: Blessing Bid		2018-07-28 18:50:53.301717+00	0.00	t	\N	619
578	2018-07-28 18:51:15.655175+00	2018-07-28 18:51:15.665033+00	Donation: Blessing Bid		2018-07-28 18:51:15.664788+00	0.00	t	\N	620
579	2018-07-28 18:51:39.23364+00	2018-07-28 18:51:39.239765+00	Donation: Blessing Bid		2018-07-28 18:51:39.239537+00	0.00	t	\N	621
580	2018-07-28 18:51:54.079842+00	2018-07-28 18:51:54.090809+00	Donation: Blessing Bid		2018-07-28 18:51:54.090538+00	0.00	t	\N	622
581	2018-07-28 18:52:28.914084+00	2018-07-28 18:52:28.921399+00	Priced Item(s)		2018-07-28 18:52:28.921039+00	20.00	t	1	623
582	2018-07-28 18:54:00.667787+00	2018-07-28 18:54:00.679429+00	Priced Item(s)		2018-07-28 18:54:00.679155+00	5.00	t	1	624
583	2018-07-28 18:54:40.283527+00	2018-07-28 18:54:40.289383+00	Donation: Blessing Bid		2018-07-28 18:54:40.288885+00	0.00	t	\N	625
584	2018-07-28 18:57:38.320195+00	2018-07-28 18:57:38.331016+00	Priced Item(s)		2018-07-28 18:57:38.329985+00	3.00	t	5	628
585	2018-07-28 18:57:58.571234+00	2018-07-28 18:57:58.580243+00	Priced Item(s)		2018-07-28 18:57:58.579974+00	1.00	t	5	629
586	2018-07-28 19:04:24.356027+00	2018-07-28 19:04:24.36868+00	Priced Item(s)		2018-07-28 19:04:24.368386+00	14.00	t	1	637
587	2018-07-28 19:05:28.264108+00	2018-07-28 19:05:28.378208+00	Priced Item(s)		2018-07-28 19:05:28.377922+00	20.00	t	3	639
588	2018-07-28 19:05:49.296857+00	2018-07-28 19:05:49.312922+00	Priced Item(s)		2018-07-28 19:05:49.310727+00	10.00	t	1	640
589	2018-07-28 19:11:12.045297+00	2018-07-28 19:11:12.072465+00	Priced Item(s)		2018-07-28 19:11:12.072202+00	10.00	t	1	648
590	2018-07-28 19:11:17.636222+00	2018-07-28 19:11:17.656504+00	Donation: food		2018-07-28 19:11:17.654521+00	0.00	t	\N	649
591	2018-07-28 19:12:27.156956+00	2018-07-28 19:12:27.172627+00	Priced Item(s)		2018-07-28 19:12:27.172346+00	44.62	t	2	653
592	2018-07-28 19:12:50.781819+00	2018-07-28 19:12:50.794127+00	Priced Item(s)		2018-07-28 19:12:50.793888+00	12.00	t	1	655
593	2018-07-28 19:13:08.334399+00	2018-07-28 19:13:08.347786+00	Priced Item(s)		2018-07-28 19:13:08.347313+00	8.00	t	2	656
594	2018-07-28 19:14:18.654776+00	2018-07-28 19:14:18.669768+00			2018-07-28 19:14:18.66908+00	0.00	t	\N	658
595	2018-07-28 19:14:37.757903+00	2018-07-28 19:14:37.771083+00	Priced Item(s)		2018-07-28 19:14:37.770804+00	12.00	t	1	660
596	2018-07-28 19:19:42.97203+00	2018-07-28 19:19:42.983752+00	Priced Item(s)		2018-07-28 19:19:42.983481+00	2.00	t	1	663
597	2018-07-28 19:22:21.005+00	2018-07-28 19:22:21.014897+00	Priced Item(s)		2018-07-28 19:22:21.014192+00	5.00	t	1	665
598	2018-07-28 19:23:41.774833+00	2018-07-28 19:23:41.782972+00	Priced Item(s)		2018-07-28 19:23:41.782718+00	11.00	t	3	666
599	2018-07-28 19:26:54.956038+00	2018-07-28 19:26:54.970739+00	Priced Item(s)		2018-07-28 19:26:54.9699+00	5.00	t	3	667
600	2018-07-28 19:27:39.012103+00	2018-07-28 19:27:39.023637+00	Priced Item(s)		2018-07-28 19:27:39.023358+00	2.50	t	2	668
601	2018-07-28 19:27:41.24947+00	2018-07-28 19:27:41.261348+00	Priced Item(s)		2018-07-28 19:27:41.261092+00	20.00	t	4	669
602	2018-07-28 19:29:50.875643+00	2018-07-28 19:29:50.89143+00	Priced Item(s)		2018-07-28 19:29:50.891178+00	6.00	t	1	670
603	2018-07-28 19:32:55.621638+00	2018-07-28 19:32:55.670904+00	Priced Item(s)		2018-07-28 19:32:55.666203+00	2.00	t	1	673
604	2018-07-28 19:35:16.836241+00	2018-07-28 19:35:16.845616+00	Priced Item(s)		2018-07-28 19:35:16.845251+00	23.00	t	3	676
605	2018-07-28 19:35:24.401455+00	2018-07-28 19:35:24.439423+00	Priced Item(s)		2018-07-28 19:35:24.439158+00	10.00	t	1	677
606	2018-07-28 19:36:35.273067+00	2018-07-28 19:36:35.282084+00	Priced Item(s)		2018-07-28 19:36:35.281023+00	20.00	t	3	679
607	2018-07-28 19:43:20.518665+00	2018-07-28 19:43:20.527474+00	Priced Item(s)		2018-07-28 19:43:20.527193+00	5.00	t	2	684
608	2018-07-28 19:43:49.560144+00	2018-07-28 19:43:49.573721+00	Priced Item(s)		2018-07-28 19:43:49.573359+00	15.00	t	5	686
609	2018-07-28 19:44:17.781882+00	2018-07-28 19:44:17.799827+00	Priced Item(s)		2018-07-28 19:44:17.799559+00	1.00	t	5	687
610	2018-07-28 19:44:56.248237+00	2018-07-28 19:44:56.259583+00	Priced Item(s)		2018-07-28 19:44:56.259298+00	5.00	t	3	688
611	2018-07-28 19:45:02.269767+00	2018-07-28 19:45:02.283494+00	Priced Item(s)		2018-07-28 19:45:02.283212+00	2.00	t	5	689
612	2018-07-28 19:45:41.445444+00	2018-07-28 19:45:41.456581+00	Priced Item(s)		2018-07-28 19:45:41.45608+00	2.00	t	5	691
613	2018-07-28 19:46:15.335795+00	2018-07-28 19:46:15.35381+00	Priced Item(s)		2018-07-28 19:46:15.349005+00	1.00	t	5	692
614	2018-07-28 19:46:20.299646+00	2018-07-28 19:46:20.314274+00	Priced Item(s)		2018-07-28 19:46:20.313595+00	100.00	t	3	693
615	2018-07-28 19:46:26.067136+00	2018-07-28 19:46:26.078974+00	Priced Item(s)		2018-07-28 19:46:26.078517+00	7.00	t	1	694
616	2018-07-28 19:48:26.410146+00	2018-07-28 19:48:26.423411+00	Priced Item(s)		2018-07-28 19:48:26.423154+00	2.00	t	5	695
617	2018-07-28 19:49:55.094803+00	2018-07-28 19:49:55.105726+00			2018-07-28 19:49:55.105447+00	0.00	t	\N	696
618	2018-07-28 19:52:03.530899+00	2018-07-28 19:52:03.539317+00			2018-07-28 19:52:03.5387+00	0.00	t	\N	697
619	2018-07-28 19:53:19.249447+00	2018-07-28 19:53:19.263494+00	Priced Item(s)		2018-07-28 19:53:19.263221+00	2.00	t	5	699
620	2018-07-28 19:54:38.66988+00	2018-07-28 19:54:38.681867+00	Priced Item(s)		2018-07-28 19:54:38.681606+00	2.00	t	1	700
621	2018-07-28 19:55:13.731767+00	2018-07-28 19:55:13.73959+00	Priced Item(s)		2018-07-28 19:55:13.739321+00	2.00	t	1	701
622	2018-07-28 19:56:10.402689+00	2018-07-28 19:56:10.414775+00	Priced Item(s)		2018-07-28 19:56:10.414499+00	4.00	t	5	704
623	2018-07-28 19:56:30.070458+00	2018-07-28 19:56:30.089374+00	Priced Item(s)		2018-07-28 19:56:30.089103+00	12.00	t	5	706
624	2018-07-28 19:57:13.151017+00	2018-07-28 19:57:13.15786+00			2018-07-28 19:57:13.157638+00	0.00	t	\N	708
625	2018-07-28 19:58:27.854921+00	2018-07-28 19:58:27.861454+00	Priced Item(s)		2018-07-28 19:58:27.861127+00	4.00	t	5	709
626	2018-07-28 19:59:29.365852+00	2018-07-28 19:59:29.37963+00			2018-07-28 19:59:29.379361+00	0.00	t	\N	710
628	2018-07-28 20:01:17.420536+00	2018-07-28 20:01:17.429194+00	Donation: Blessin Bid		2018-07-28 20:01:17.428935+00	0.00	t	\N	712
627	2018-07-28 20:01:16.950061+00	2018-07-28 20:01:16.958132+00	Donation: Blessin Bid		2018-07-28 20:01:16.957871+00	0.00	t	\N	\N
629	2018-07-28 20:01:52.877123+00	2018-07-28 20:01:52.90044+00	Donation: Viet Nam Blessing Bid		2018-07-28 20:01:52.899+00	0.00	t	\N	713
630	2018-07-28 20:02:05.823909+00	2018-07-28 20:02:05.843476+00	Donation: Viet Nam Blessing Bid		2018-07-28 20:02:05.843205+00	0.00	t	\N	714
631	2018-07-28 20:02:14.891622+00	2018-07-28 20:02:14.899054+00	Donation: Viet Nam Blessing Bid		2018-07-28 20:02:14.89877+00	0.00	t	\N	716
632	2018-07-28 20:03:21.099856+00	2018-07-28 20:03:21.115475+00	Priced Item(s)		2018-07-28 20:03:21.115186+00	5.64	t	2	718
633	2018-07-28 20:03:53.258076+00	2018-07-28 20:03:53.271424+00	Priced Item(s)		2018-07-28 20:03:53.271192+00	45.07	t	2	720
634	2018-07-28 20:05:03.979034+00	2018-07-28 20:05:03.991322+00	Priced Item(s)		2018-07-28 20:05:03.99107+00	10.00	t	2	722
635	2018-07-28 20:05:56.623762+00	2018-07-28 20:05:56.637329+00			2018-07-28 20:05:56.636807+00	0.00	t	\N	724
636	2018-07-28 20:08:05.189524+00	2018-07-28 20:08:05.209333+00	Donation: Gary Wieman's fundraiser auction		2018-07-28 20:08:05.209052+00	0.00	t	\N	726
657	2018-07-28 20:32:57.180889+00	2018-07-28 20:32:57.19052+00	Priced Item(s)		2018-07-28 20:32:57.190285+00	6.00	t	1	764
638	2018-07-28 20:08:36.687446+00	2018-07-28 20:08:36.697399+00	Donation: Vietnam Blessing Bid		2018-07-28 20:08:36.697135+00	0.00	t	\N	728
639	2018-07-28 20:09:15.988383+00	2018-07-28 20:09:15.995345+00	Priced Item(s)		2018-07-28 20:09:15.995137+00	6.00	t	5	730
640	2018-07-28 20:09:51.001164+00	2018-07-28 20:09:51.011023+00	Priced Item(s)		2018-07-28 20:09:51.010629+00	2.00	t	5	732
637	2018-07-28 20:08:14.958594+00	2018-07-28 20:08:14.976646+00	Priced Item(s)		2018-07-28 20:08:14.97635+00	10.00	t	2	\N
641	2018-07-28 20:10:35.312056+00	2018-07-28 20:10:35.323855+00			2018-07-28 20:10:35.323487+00	0.00	t	\N	733
642	2018-07-28 20:11:38.431073+00	2018-07-28 20:11:38.447478+00	Priced Item(s)		2018-07-28 20:11:38.447215+00	8.00	t	1	735
643	2018-07-28 20:12:09.455814+00	2018-07-28 20:12:09.471656+00	Donation: cookbook, she bought 2		2018-07-28 20:12:09.471387+00	0.00	t	\N	736
644	2018-07-28 20:13:06.916181+00	2018-07-28 20:13:06.925558+00	Priced Item(s)		2018-07-28 20:13:06.925307+00	20.00	t	5	737
645	2018-07-28 20:18:41.007737+00	2018-07-28 20:18:41.023402+00	Priced Item(s)		2018-07-28 20:18:41.02315+00	2.00	t	5	741
646	2018-07-28 20:24:07.875875+00	2018-07-28 20:24:07.891539+00	Priced Item(s)		2018-07-28 20:24:07.891243+00	16.00	t	1	747
647	2018-07-28 20:24:35.950808+00	2018-07-28 20:24:35.961094+00	Priced Item(s)		2018-07-28 20:24:35.960832+00	23.22	t	2	748
648	2018-07-28 20:26:06.187739+00	2018-07-28 20:26:06.197374+00	Priced Item(s)		2018-07-28 20:26:06.196764+00	15.10	t	2	750
649	2018-07-28 20:26:16.419454+00	2018-07-28 20:26:16.432248+00	Priced Item(s)		2018-07-28 20:26:16.431243+00	10.00	t	1	751
650	2018-07-28 20:26:35.2394+00	2018-07-28 20:26:35.259215+00	Priced Item(s)		2018-07-28 20:26:35.258808+00	5.00	t	2	752
651	2018-07-28 20:26:35.375604+00	2018-07-28 20:26:35.384805+00	Donation: Donation		2018-07-28 20:26:35.384557+00	0.00	t	\N	753
652	2018-07-28 20:29:22.219751+00	2018-07-28 20:29:22.233209+00			2018-07-28 20:29:22.231221+00	0.00	t	\N	757
653	2018-07-28 20:29:53.567696+00	2018-07-28 20:29:53.586256+00	Priced Item(s)		2018-07-28 20:29:53.583841+00	6.00	t	1	758
654	2018-07-28 20:31:00.581048+00	2018-07-28 20:31:00.589677+00	Priced Item(s)		2018-07-28 20:31:00.589407+00	2.00	t	1	760
655	2018-07-28 20:31:24.989356+00	2018-07-28 20:31:25.01087+00	Priced Item(s)		2018-07-28 20:31:25.010613+00	6.00	t	1	761
656	2018-07-28 20:32:29.471221+00	2018-07-28 20:32:29.483289+00	Priced Item(s)		2018-07-28 20:32:29.479517+00	2.00	t	1	762
658	2018-07-28 20:33:28.60982+00	2018-07-28 20:33:28.616024+00	Priced Item(s)		2018-07-28 20:33:28.615808+00	3.00	t	1	765
659	2018-07-28 20:33:38.156632+00	2018-07-28 20:33:38.179562+00	Donation: water project		2018-07-28 20:33:38.179296+00	0.00	t	\N	766
660	2018-07-28 20:35:13.880585+00	2018-07-28 20:35:13.891785+00			2018-07-28 20:35:13.890958+00	0.00	t	\N	769
661	2018-07-28 20:37:26.472628+00	2018-07-28 20:37:26.481191+00	Donation: cheese pockets - 1 doz		2018-07-28 20:37:26.480864+00	0.00	t	\N	771
662	2018-07-28 20:38:15.225236+00	2018-07-28 20:38:15.235968+00	Priced Item(s)		2018-07-28 20:38:15.2357+00	16.03	t	2	774
663	2018-07-28 20:40:37.577908+00	2018-07-28 20:40:37.6035+00	Priced Item(s)		2018-07-28 20:40:37.603216+00	16.75	t	2	775
664	2018-07-28 20:47:39.725304+00	2018-07-28 20:47:39.733812+00	Donation: 2 crocheted craft items afghans.		2018-07-28 20:47:39.733555+00	0.00	t	\N	776
665	2018-07-28 20:49:38.837356+00	2018-07-28 20:49:38.851458+00			2018-07-28 20:49:38.851184+00	0.00	t	\N	777
666	2018-07-28 20:53:00.675521+00	2018-07-28 20:53:00.701868+00			2018-07-28 20:53:00.701619+00	0.00	t	\N	778
667	2018-07-28 20:53:25.279342+00	2018-07-28 20:53:25.289914+00	Priced Item(s)		2018-07-28 20:53:25.289527+00	40.50	t	2	779
668	2018-07-28 20:54:16.680689+00	2018-07-28 20:54:16.696254+00			2018-07-28 20:54:16.695971+00	0.00	t	\N	780
669	2018-07-28 20:54:44.190253+00	2018-07-28 20:54:44.195124+00	Donation: bottle of vanilla		2018-07-28 20:54:44.194909+00	0.00	t	\N	781
670	2018-07-28 21:03:59.667814+00	2018-07-28 21:03:59.682285+00			2018-07-28 21:03:59.682014+00	0.00	t	\N	782
671	2018-07-28 21:26:35.806696+00	2018-07-28 21:26:35.821554+00	Donation: Blessing bid		2018-07-28 21:26:35.817545+00	0.00	t	\N	783
672	2018-07-28 21:26:42.322221+00	2018-07-28 21:26:42.333627+00			2018-07-28 21:26:42.333257+00	0.00	t	\N	784
\.


--
-- Data for Name: auction_purchase; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.auction_purchase (id, ctime, mtime, amount, transaction_time, patron_id) FROM stdin;
1	2018-07-28 13:01:26.42639+00	2018-07-28 13:01:26.426464+00	20.00	2018-07-28 13:01:26.436966+00	135
2	2018-07-28 13:02:04.3349+00	2018-07-28 13:02:04.334959+00	15.00	2018-07-28 13:02:04.335211+00	135
3	2018-07-28 13:09:37.187468+00	2018-07-28 13:09:37.187758+00	20.00	2018-07-28 13:09:37.188522+00	135
4	2018-07-28 13:10:21.403915+00	2018-07-28 13:10:21.403959+00	80.00	2018-07-28 13:10:21.404063+00	135
5	2018-07-28 13:13:31.546399+00	2018-07-28 13:13:31.546457+00	15.00	2018-07-28 13:13:31.546586+00	123
6	2018-07-28 13:15:49.714733+00	2018-07-28 13:15:49.71479+00	10.00	2018-07-28 13:15:49.715149+00	42
7	2018-07-28 13:20:09.791018+00	2018-07-28 13:20:09.791051+00	10.00	2018-07-28 13:20:09.79119+00	143
8	2018-07-28 13:21:36.817585+00	2018-07-28 13:21:36.817646+00	10.00	2018-07-28 13:21:36.817778+00	145
9	2018-07-28 13:32:37.519099+00	2018-07-28 13:32:37.519151+00	35.00	2018-07-28 13:32:37.519286+00	58
10	2018-07-28 13:34:15.409069+00	2018-07-28 13:34:15.409166+00	5.00	2018-07-28 13:34:15.409332+00	58
11	2018-07-28 13:35:59.472526+00	2018-07-28 13:35:59.472579+00	15.00	2018-07-28 13:35:59.472692+00	135
12	2018-07-28 13:40:19.663597+00	2018-07-28 13:40:19.663673+00	30.00	2018-07-28 13:40:19.664765+00	27
13	2018-07-28 13:52:43.885985+00	2018-07-28 13:52:43.886044+00	139.00	2018-07-28 13:52:43.886188+00	135
14	2018-07-28 13:53:41.905182+00	2018-07-28 13:53:41.905233+00	100.00	2018-07-28 13:53:41.905344+00	158
15	2018-07-28 13:58:42.538479+00	2018-07-28 13:58:42.538531+00	25.00	2018-07-28 13:58:42.538649+00	39
16	2018-07-28 13:59:13.420226+00	2018-07-28 13:59:13.420281+00	1.00	2018-07-28 13:59:13.420403+00	135
17	2018-07-28 14:00:03.702173+00	2018-07-28 14:00:03.702437+00	10.00	2018-07-28 14:00:03.702671+00	162
18	2018-07-28 14:01:26.188067+00	2018-07-28 14:01:26.188127+00	40.00	2018-07-28 14:01:26.188265+00	164
19	2018-07-28 14:02:44.617803+00	2018-07-28 14:02:44.617861+00	15.00	2018-07-28 14:02:44.617986+00	166
20	2018-07-28 14:03:00.210348+00	2018-07-28 14:03:00.210403+00	30.00	2018-07-28 14:03:00.210523+00	135
21	2018-07-28 14:03:11.756207+00	2018-07-28 14:03:11.756243+00	18.00	2018-07-28 14:03:11.75634+00	138
22	2018-07-28 14:03:56.653438+00	2018-07-28 14:03:56.653492+00	26.00	2018-07-28 14:03:56.653601+00	140
23	2018-07-28 14:05:19.263414+00	2018-07-28 14:05:19.263448+00	9.00	2018-07-28 14:05:19.263545+00	163
24	2018-07-28 14:06:15.050637+00	2018-07-28 14:06:15.050699+00	40.00	2018-07-28 14:06:15.05084+00	163
25	2018-07-28 14:07:18.906049+00	2018-07-28 14:07:18.906102+00	100.00	2018-07-28 14:07:18.906226+00	9
26	2018-07-28 14:07:56.565266+00	2018-07-28 14:07:56.565301+00	35.00	2018-07-28 14:07:56.565384+00	139
27	2018-07-28 14:09:01.110675+00	2018-07-28 14:09:01.110731+00	26.00	2018-07-28 14:09:01.110867+00	83
28	2018-07-28 14:09:27.4881+00	2018-07-28 14:09:27.48816+00	20.00	2018-07-28 14:09:27.488295+00	169
29	2018-07-28 14:10:35.276385+00	2018-07-28 14:10:35.276438+00	12.00	2018-07-28 14:10:35.276559+00	140
30	2018-07-28 14:11:01.62933+00	2018-07-28 14:11:01.629392+00	34.00	2018-07-28 14:11:01.629526+00	165
31	2018-07-28 14:11:53.590824+00	2018-07-28 14:11:53.590886+00	40.00	2018-07-28 14:11:53.591028+00	170
32	2018-07-28 14:12:24.251441+00	2018-07-28 14:12:24.251502+00	10.00	2018-07-28 14:12:24.25164+00	164
33	2018-07-28 14:12:48.859143+00	2018-07-28 14:12:48.859207+00	20.00	2018-07-28 14:12:48.859341+00	60
34	2018-07-28 14:13:54.817697+00	2018-07-28 14:13:54.817735+00	10.00	2018-07-28 14:13:54.817853+00	140
35	2018-07-28 14:14:47.380446+00	2018-07-28 14:14:47.380493+00	30.00	2018-07-28 14:14:47.380603+00	99
36	2018-07-28 14:15:21.635868+00	2018-07-28 14:15:21.635926+00	50.00	2018-07-28 14:15:21.636057+00	34
37	2018-07-28 14:15:59.77847+00	2018-07-28 14:15:59.778692+00	10.00	2018-07-28 14:15:59.778873+00	173
38	2018-07-28 14:16:04.562666+00	2018-07-28 14:16:04.562727+00	20.00	2018-07-28 14:16:04.562864+00	153
39	2018-07-28 14:17:16.748226+00	2018-07-28 14:17:16.74828+00	45.00	2018-07-28 14:17:16.748407+00	12
40	2018-07-28 14:18:18.661773+00	2018-07-28 14:18:18.661832+00	16.00	2018-07-28 14:18:18.66197+00	157
41	2018-07-28 14:19:23.598883+00	2018-07-28 14:19:23.598938+00	24.00	2018-07-28 14:19:23.599103+00	9
42	2018-07-28 14:20:04.691236+00	2018-07-28 14:20:04.691267+00	15.00	2018-07-28 14:20:04.691342+00	26
43	2018-07-28 14:20:09.903432+00	2018-07-28 14:20:09.903466+00	10.00	2018-07-28 14:20:09.903544+00	148
44	2018-07-28 14:20:23.409111+00	2018-07-28 14:20:23.409565+00	15.00	2018-07-28 14:20:23.410094+00	178
45	2018-07-28 14:20:53.09875+00	2018-07-28 14:20:53.098809+00	12.00	2018-07-28 14:20:53.09894+00	150
46	2018-07-28 14:21:29.53452+00	2018-07-28 14:21:29.534582+00	30.00	2018-07-28 14:21:29.534716+00	93
47	2018-07-28 14:21:59.219795+00	2018-07-28 14:21:59.219842+00	24.00	2018-07-28 14:21:59.219943+00	144
48	2018-07-28 14:22:44.804328+00	2018-07-28 14:22:44.804377+00	20.00	2018-07-28 14:22:44.804492+00	180
49	2018-07-28 14:22:59.250451+00	2018-07-28 14:22:59.250507+00	27.00	2018-07-28 14:22:59.250632+00	14
50	2018-07-28 14:23:27.069869+00	2018-07-28 14:23:27.069929+00	6.00	2018-07-28 14:23:27.07009+00	139
51	2018-07-28 14:24:20.207844+00	2018-07-28 14:24:20.207904+00	16.00	2018-07-28 14:24:20.208036+00	38
52	2018-07-28 14:24:52.839782+00	2018-07-28 14:24:52.839847+00	15.00	2018-07-28 14:24:52.839991+00	154
53	2018-07-28 14:25:07.144173+00	2018-07-28 14:25:07.144227+00	9.00	2018-07-28 14:25:07.144351+00	163
54	2018-07-28 14:25:18.757072+00	2018-07-28 14:25:18.75711+00	32.00	2018-07-28 14:25:18.757192+00	144
55	2018-07-28 14:26:28.323397+00	2018-07-28 14:26:28.323453+00	30.00	2018-07-28 14:26:28.323636+00	180
56	2018-07-28 14:26:32.126548+00	2018-07-28 14:26:32.126608+00	25.00	2018-07-28 14:26:32.126751+00	179
57	2018-07-28 14:28:04.903902+00	2018-07-28 14:28:04.903962+00	9.00	2018-07-28 14:28:04.904172+00	179
58	2018-07-28 14:30:04.975824+00	2018-07-28 14:30:04.975878+00	18.00	2018-07-28 14:30:04.976042+00	171
59	2018-07-28 14:30:43.704882+00	2018-07-28 14:30:43.704939+00	38.00	2018-07-28 14:30:43.705066+00	99
60	2018-07-28 14:31:51.789788+00	2018-07-28 14:31:51.789914+00	12.00	2018-07-28 14:31:51.790212+00	1
61	2018-07-28 14:32:15.552497+00	2018-07-28 14:32:15.552551+00	10.00	2018-07-28 14:32:15.552753+00	99
62	2018-07-28 14:32:20.147617+00	2018-07-28 14:32:20.147677+00	10.00	2018-07-28 14:32:20.147805+00	14
63	2018-07-28 14:34:38.545812+00	2018-07-28 14:34:38.546075+00	45.00	2018-07-28 14:34:38.546588+00	179
64	2018-07-28 14:34:54.387899+00	2018-07-28 14:34:54.387956+00	8.00	2018-07-28 14:34:54.388085+00	93
65	2018-07-28 14:35:02.168146+00	2018-07-28 14:35:02.168221+00	15.00	2018-07-28 14:35:02.168756+00	164
66	2018-07-28 14:35:24.138958+00	2018-07-28 14:35:24.139055+00	10.00	2018-07-28 14:35:24.139205+00	130
67	2018-07-28 14:35:31.467757+00	2018-07-28 14:35:31.467815+00	10.00	2018-07-28 14:35:31.467941+00	169
68	2018-07-28 14:37:49.851842+00	2018-07-28 14:37:49.851905+00	6.30	2018-07-28 14:37:49.852039+00	99
69	2018-07-28 14:37:55.76411+00	2018-07-28 14:37:55.764169+00	21.00	2018-07-28 14:37:55.764291+00	96
70	2018-07-28 14:40:29.74546+00	2018-07-28 14:40:29.745516+00	60.00	2018-07-28 14:40:29.745643+00	156
71	2018-07-28 14:41:16.59935+00	2018-07-28 14:41:16.599412+00	6.25	2018-07-28 14:41:16.599545+00	153
72	2018-07-28 14:41:44.43153+00	2018-07-28 14:41:44.431584+00	16.00	2018-07-28 14:41:44.431717+00	130
73	2018-07-28 14:42:53.95034+00	2018-07-28 14:42:53.950399+00	24.50	2018-07-28 14:42:53.95053+00	12
74	2018-07-28 14:42:56.304968+00	2018-07-28 14:42:56.305039+00	1.65	2018-07-28 14:42:56.30517+00	165
75	2018-07-28 14:43:51.230384+00	2018-07-28 14:43:51.230448+00	10.00	2018-07-28 14:43:51.231007+00	2
76	2018-07-28 14:46:13.338601+00	2018-07-28 14:46:13.338656+00	30.00	2018-07-28 14:46:13.338777+00	8
77	2018-07-28 14:46:14.890878+00	2018-07-28 14:46:14.890927+00	25.00	2018-07-28 14:46:14.891072+00	144
78	2018-07-28 14:46:58.508407+00	2018-07-28 14:46:58.508481+00	20.00	2018-07-28 14:46:58.509811+00	171
79	2018-07-28 14:47:04.86018+00	2018-07-28 14:47:04.860237+00	36.00	2018-07-28 14:47:04.860403+00	135
80	2018-07-28 14:47:43.940025+00	2018-07-28 14:47:43.940084+00	30.00	2018-07-28 14:47:43.940211+00	130
81	2018-07-28 14:48:10.38111+00	2018-07-28 14:48:10.381167+00	12.00	2018-07-28 14:48:10.381276+00	190
82	2018-07-28 14:49:57.977361+00	2018-07-28 14:49:57.977433+00	8.00	2018-07-28 14:49:57.977567+00	96
83	2018-07-28 14:50:13.126335+00	2018-07-28 14:50:13.126395+00	20.00	2018-07-28 14:50:13.126531+00	45
84	2018-07-28 14:53:00.547382+00	2018-07-28 14:53:00.54754+00	5.00	2018-07-28 14:53:00.547671+00	182
85	2018-07-28 14:53:05.591558+00	2018-07-28 14:53:05.591609+00	7.00	2018-07-28 14:53:05.591735+00	191
87	2018-07-28 14:55:35.955788+00	2018-07-28 14:55:35.955849+00	10.00	2018-07-28 14:55:35.955956+00	92
88	2018-07-28 14:56:41.981558+00	2018-07-28 14:56:41.982347+00	4.00	2018-07-28 14:56:41.983207+00	193
89	2018-07-28 14:57:01.645766+00	2018-07-28 14:57:01.645941+00	4.00	2018-07-28 14:57:01.646162+00	195
90	2018-07-28 14:58:14.4119+00	2018-07-28 14:58:14.411961+00	20.00	2018-07-28 14:58:14.412101+00	197
91	2018-07-28 14:59:01.815667+00	2018-07-28 14:59:01.815722+00	4.00	2018-07-28 14:59:01.815843+00	199
92	2018-07-28 15:00:16.011156+00	2018-07-28 15:00:16.011214+00	10.00	2018-07-28 15:00:16.011344+00	198
93	2018-07-28 15:01:12.090903+00	2018-07-28 15:01:12.091706+00	40.00	2018-07-28 15:01:12.092596+00	99
94	2018-07-28 15:01:37.919422+00	2018-07-28 15:01:37.919483+00	15.00	2018-07-28 15:01:37.919665+00	188
95	2018-07-28 15:02:12.289346+00	2018-07-28 15:02:12.289412+00	55.54	2018-07-28 15:02:12.289559+00	106
96	2018-07-28 15:02:54.988473+00	2018-07-28 15:02:54.988527+00	5.00	2018-07-28 15:02:54.988645+00	92
97	2018-07-28 15:03:28.279865+00	2018-07-28 15:03:28.279968+00	5.00	2018-07-28 15:03:28.28014+00	198
98	2018-07-28 15:07:37.352464+00	2018-07-28 15:07:37.352529+00	2.95	2018-07-28 15:07:37.352665+00	176
99	2018-07-28 15:08:45.684828+00	2018-07-28 15:08:45.684885+00	20.00	2018-07-28 15:08:45.685024+00	4
100	2018-07-28 15:11:43.005794+00	2018-07-28 15:11:43.005848+00	13.00	2018-07-28 15:11:43.005979+00	198
101	2018-07-28 15:12:25.70954+00	2018-07-28 15:12:25.709608+00	15.00	2018-07-28 15:12:25.710054+00	96
102	2018-07-28 15:13:39.335802+00	2018-07-28 15:13:39.335861+00	20.00	2018-07-28 15:13:39.335993+00	209
103	2018-07-28 15:13:39.680862+00	2018-07-28 15:13:39.680923+00	20.00	2018-07-28 15:13:39.68106+00	188
104	2018-07-28 15:14:41.831766+00	2018-07-28 15:14:41.831825+00	21.50	2018-07-28 15:14:41.831965+00	206
105	2018-07-28 15:14:44.25598+00	2018-07-28 15:14:44.256042+00	3.00	2018-07-28 15:14:44.256164+00	130
106	2018-07-28 15:15:16.936021+00	2018-07-28 15:15:16.936081+00	10.00	2018-07-28 15:15:16.936212+00	9
107	2018-07-28 15:15:32.449852+00	2018-07-28 15:15:32.450469+00	10.00	2018-07-28 15:15:32.45101+00	212
108	2018-07-28 15:16:04.348937+00	2018-07-28 15:16:04.348987+00	20.00	2018-07-28 15:16:04.349095+00	119
109	2018-07-28 15:16:22.178858+00	2018-07-28 15:16:22.178915+00	33.00	2018-07-28 15:16:22.179075+00	106
110	2018-07-28 15:16:24.735263+00	2018-07-28 15:16:24.735381+00	8.00	2018-07-28 15:16:24.735613+00	45
111	2018-07-28 15:17:03.699117+00	2018-07-28 15:17:03.699183+00	11.00	2018-07-28 15:17:03.699929+00	175
112	2018-07-28 15:17:23.644356+00	2018-07-28 15:17:23.644418+00	10.00	2018-07-28 15:17:23.644564+00	198
113	2018-07-28 15:17:49.737273+00	2018-07-28 15:17:49.737433+00	20.00	2018-07-28 15:17:49.737585+00	213
114	2018-07-28 15:18:36.42837+00	2018-07-28 15:18:36.428506+00	26.00	2018-07-28 15:18:36.428644+00	190
115	2018-07-28 15:18:53.765002+00	2018-07-28 15:18:53.765062+00	10.00	2018-07-28 15:18:53.76519+00	130
116	2018-07-28 15:19:31.127434+00	2018-07-28 15:19:31.12749+00	8.00	2018-07-28 15:19:31.127634+00	214
117	2018-07-28 15:20:03.446015+00	2018-07-28 15:20:03.446075+00	33.00	2018-07-28 15:20:03.446209+00	101
118	2018-07-28 15:20:12.217395+00	2018-07-28 15:20:12.217457+00	20.00	2018-07-28 15:20:12.217592+00	24
119	2018-07-28 15:20:50.208288+00	2018-07-28 15:20:50.208347+00	8.00	2018-07-28 15:20:50.208467+00	14
120	2018-07-28 15:21:30.808163+00	2018-07-28 15:21:30.808221+00	20.00	2018-07-28 15:21:30.808493+00	207
121	2018-07-28 15:22:10.728053+00	2018-07-28 15:22:10.728121+00	20.00	2018-07-28 15:22:10.728255+00	116
122	2018-07-28 15:22:37.541345+00	2018-07-28 15:22:37.541407+00	10.00	2018-07-28 15:22:37.541546+00	175
123	2018-07-28 15:23:32.392549+00	2018-07-28 15:23:32.392609+00	20.00	2018-07-28 15:23:32.392729+00	25
124	2018-07-28 15:25:00.593224+00	2018-07-28 15:25:00.593285+00	6.00	2018-07-28 15:25:00.593419+00	149
125	2018-07-28 15:26:08.841018+00	2018-07-28 15:26:08.841076+00	5.00	2018-07-28 15:26:08.841208+00	130
126	2018-07-28 15:26:22.129548+00	2018-07-28 15:26:22.129603+00	0.30	2018-07-28 15:26:22.129723+00	175
127	2018-07-28 15:26:27.168932+00	2018-07-28 15:26:27.168992+00	12.00	2018-07-28 15:26:27.169121+00	212
128	2018-07-28 15:26:39.761092+00	2018-07-28 15:26:39.761142+00	5.00	2018-07-28 15:26:39.761251+00	154
129	2018-07-28 15:26:55.987892+00	2018-07-28 15:26:55.987946+00	6.00	2018-07-28 15:26:55.988056+00	181
130	2018-07-28 15:27:21.045279+00	2018-07-28 15:27:21.045337+00	24.00	2018-07-28 15:27:21.045468+00	103
131	2018-07-28 15:28:06.928875+00	2018-07-28 15:28:06.928933+00	5.00	2018-07-28 15:28:06.929065+00	167
132	2018-07-28 15:29:28.584599+00	2018-07-28 15:29:28.584653+00	8.50	2018-07-28 15:29:28.584771+00	139
133	2018-07-28 15:30:42.030114+00	2018-07-28 15:30:42.030174+00	10.00	2018-07-28 15:30:42.030352+00	222
134	2018-07-28 15:31:06.03048+00	2018-07-28 15:31:06.030552+00	2.50	2018-07-28 15:31:06.030782+00	187
135	2018-07-28 15:31:07.767789+00	2018-07-28 15:31:07.767849+00	10.00	2018-07-28 15:31:07.767969+00	126
136	2018-07-28 15:31:43.394126+00	2018-07-28 15:31:43.394186+00	10.00	2018-07-28 15:31:43.394323+00	223
137	2018-07-28 15:32:03.59674+00	2018-07-28 15:32:03.596808+00	5.00	2018-07-28 15:32:03.59694+00	154
138	2018-07-28 15:32:19.289892+00	2018-07-28 15:32:19.289969+00	51.00	2018-07-28 15:32:19.290095+00	135
139	2018-07-28 15:33:43.626524+00	2018-07-28 15:33:43.626584+00	37.34	2018-07-28 15:33:43.626729+00	168
140	2018-07-28 15:34:55.520308+00	2018-07-28 15:34:55.52036+00	14.40	2018-07-28 15:34:55.520478+00	14
142	2018-07-28 15:35:47.932851+00	2018-07-28 15:35:47.932905+00	5.95	2018-07-28 15:35:47.933026+00	101
143	2018-07-28 15:36:22.628613+00	2018-07-28 15:36:22.628675+00	10.00	2018-07-28 15:36:22.628807+00	139
144	2018-07-28 15:36:45.521064+00	2018-07-28 15:36:45.521126+00	10.00	2018-07-28 15:36:45.521257+00	115
145	2018-07-28 15:37:56.192317+00	2018-07-28 15:37:56.192374+00	20.00	2018-07-28 15:37:56.192504+00	227
146	2018-07-28 15:39:07.676171+00	2018-07-28 15:39:07.676234+00	10.00	2018-07-28 15:39:07.67637+00	229
147	2018-07-28 15:39:08.498344+00	2018-07-28 15:39:08.503423+00	10.00	2018-07-28 15:39:08.503573+00	60
148	2018-07-28 15:39:27.936315+00	2018-07-28 15:39:27.93674+00	4.55	2018-07-28 15:39:27.937121+00	29
149	2018-07-28 15:39:58.913482+00	2018-07-28 15:39:58.91354+00	15.00	2018-07-28 15:39:58.913664+00	231
150	2018-07-28 15:40:26.219768+00	2018-07-28 15:40:26.21983+00	16.50	2018-07-28 15:40:26.22034+00	116
151	2018-07-28 15:40:36.713106+00	2018-07-28 15:40:36.713157+00	10.00	2018-07-28 15:40:36.713276+00	146
152	2018-07-28 15:41:19.242434+00	2018-07-28 15:41:19.242494+00	90.00	2018-07-28 15:41:19.242636+00	27
153	2018-07-28 15:42:47.449193+00	2018-07-28 15:42:47.449242+00	27.00	2018-07-28 15:42:47.449404+00	220
154	2018-07-28 15:42:50.042956+00	2018-07-28 15:42:50.043245+00	0.75	2018-07-28 15:42:50.043683+00	194
155	2018-07-28 15:43:30.818462+00	2018-07-28 15:43:30.818521+00	4.00	2018-07-28 15:43:30.818655+00	230
156	2018-07-28 15:43:53.243863+00	2018-07-28 15:43:53.243922+00	10.00	2018-07-28 15:43:53.244066+00	233
157	2018-07-28 15:44:25.536731+00	2018-07-28 15:44:25.537007+00	10.00	2018-07-28 15:44:25.537551+00	126
158	2018-07-28 15:45:05.448019+00	2018-07-28 15:45:05.448083+00	8.00	2018-07-28 15:45:05.44822+00	182
159	2018-07-28 15:45:43.359918+00	2018-07-28 15:45:43.360043+00	6.00	2018-07-28 15:45:43.360286+00	222
160	2018-07-28 15:46:05.609778+00	2018-07-28 15:46:05.609833+00	6.00	2018-07-28 15:46:05.609958+00	153
161	2018-07-28 15:47:20.837605+00	2018-07-28 15:47:20.837666+00	1.95	2018-07-28 15:47:20.837805+00	230
162	2018-07-28 15:47:32.062501+00	2018-07-28 15:47:32.062562+00	4.50	2018-07-28 15:47:32.062701+00	174
163	2018-07-28 15:47:56.516233+00	2018-07-28 15:47:56.516277+00	2.00	2018-07-28 15:47:56.516358+00	174
164	2018-07-28 15:50:16.920284+00	2018-07-28 15:50:16.920342+00	21.00	2018-07-28 15:50:16.920473+00	29
165	2018-07-28 15:50:28.227237+00	2018-07-28 15:50:28.227296+00	10.00	2018-07-28 15:50:28.227432+00	95
166	2018-07-28 15:50:37.849201+00	2018-07-28 15:50:37.849374+00	1.75	2018-07-28 15:50:37.849999+00	227
167	2018-07-28 15:51:02.892563+00	2018-07-28 15:51:02.892626+00	20.00	2018-07-28 15:51:02.892756+00	236
168	2018-07-28 15:52:10.786036+00	2018-07-28 15:52:10.786096+00	14.00	2018-07-28 15:52:10.786215+00	27
169	2018-07-28 15:52:50.962985+00	2018-07-28 15:52:50.963081+00	6.00	2018-07-28 15:52:50.963219+00	167
170	2018-07-28 15:53:54.089123+00	2018-07-28 15:53:54.089178+00	10.00	2018-07-28 15:53:54.089308+00	115
171	2018-07-28 15:54:25.232172+00	2018-07-28 15:54:25.232233+00	21.00	2018-07-28 15:54:25.232375+00	238
172	2018-07-28 15:54:40.284957+00	2018-07-28 15:54:40.285018+00	21.50	2018-07-28 15:54:40.285218+00	139
173	2018-07-28 15:54:48.772584+00	2018-07-28 15:54:48.772635+00	15.00	2018-07-28 15:54:48.772769+00	239
174	2018-07-28 15:55:17.240194+00	2018-07-28 15:55:17.240251+00	12.00	2018-07-28 15:55:17.240377+00	24
175	2018-07-28 15:55:20.018856+00	2018-07-28 15:55:20.018913+00	12.00	2018-07-28 15:55:20.023072+00	81
176	2018-07-28 15:55:45.145346+00	2018-07-28 15:55:45.145402+00	6.00	2018-07-28 15:55:45.145532+00	60
177	2018-07-28 15:55:51.292108+00	2018-07-28 15:55:51.292234+00	20.00	2018-07-28 15:55:51.292454+00	32
178	2018-07-28 15:55:58.574589+00	2018-07-28 15:55:58.574644+00	10.00	2018-07-28 15:55:58.575173+00	177
179	2018-07-28 15:56:24.204899+00	2018-07-28 15:56:24.205261+00	6.00	2018-07-28 15:56:24.205543+00	241
180	2018-07-28 15:57:27.608635+00	2018-07-28 15:57:27.608694+00	5.00	2018-07-28 15:57:27.608827+00	135
181	2018-07-28 15:57:44.721211+00	2018-07-28 15:57:44.721274+00	6.00	2018-07-28 15:57:44.72159+00	241
182	2018-07-28 15:59:15.447935+00	2018-07-28 15:59:15.447992+00	16.50	2018-07-28 15:59:15.448121+00	81
183	2018-07-28 15:59:48.837303+00	2018-07-28 15:59:48.837359+00	5.00	2018-07-28 15:59:48.837477+00	58
184	2018-07-28 16:00:15.774207+00	2018-07-28 16:00:15.774388+00	16.50	2018-07-28 16:00:15.774525+00	81
185	2018-07-28 16:00:50.071098+00	2018-07-28 16:00:50.072172+00	4.50	2018-07-28 16:00:50.073693+00	83
186	2018-07-28 16:00:56.893353+00	2018-07-28 16:00:56.893413+00	16.00	2018-07-28 16:00:56.893542+00	80
187	2018-07-28 16:01:09.055096+00	2018-07-28 16:01:09.055156+00	12.00	2018-07-28 16:01:09.055341+00	198
188	2018-07-28 16:01:27.239846+00	2018-07-28 16:01:27.239905+00	12.00	2018-07-28 16:01:27.24004+00	55
189	2018-07-28 16:01:41.283901+00	2018-07-28 16:01:41.284186+00	2.60	2018-07-28 16:01:41.284371+00	154
190	2018-07-28 16:02:18.452576+00	2018-07-28 16:02:18.452646+00	7.75	2018-07-28 16:02:18.45317+00	188
191	2018-07-28 16:02:19.210861+00	2018-07-28 16:02:19.211287+00	26.00	2018-07-28 16:02:19.211461+00	235
192	2018-07-28 16:03:20.576512+00	2018-07-28 16:03:20.576573+00	6.00	2018-07-28 16:03:20.576823+00	237
193	2018-07-28 16:03:28.742619+00	2018-07-28 16:03:28.742678+00	10.00	2018-07-28 16:03:28.742828+00	140
194	2018-07-28 16:03:30.157555+00	2018-07-28 16:03:30.157619+00	20.00	2018-07-28 16:03:30.157835+00	38
195	2018-07-28 16:03:43.597757+00	2018-07-28 16:03:43.597815+00	42.00	2018-07-28 16:03:43.597944+00	217
196	2018-07-28 16:04:00.495807+00	2018-07-28 16:04:00.495864+00	12.00	2018-07-28 16:04:00.49621+00	187
197	2018-07-28 16:04:28.478673+00	2018-07-28 16:04:28.478752+00	15.00	2018-07-28 16:04:28.478928+00	8
198	2018-07-28 16:04:39.582062+00	2018-07-28 16:04:39.582129+00	20.00	2018-07-28 16:04:39.582458+00	32
199	2018-07-28 16:05:21.336455+00	2018-07-28 16:05:21.336507+00	10.00	2018-07-28 16:05:21.336629+00	242
200	2018-07-28 16:05:26.456898+00	2018-07-28 16:05:26.456959+00	35.00	2018-07-28 16:05:26.457096+00	204
201	2018-07-28 16:05:40.681228+00	2018-07-28 16:05:40.681287+00	10.00	2018-07-28 16:05:40.681421+00	108
202	2018-07-28 16:05:42.320353+00	2018-07-28 16:05:42.320401+00	34.50	2018-07-28 16:05:42.321179+00	244
203	2018-07-28 16:06:21.396879+00	2018-07-28 16:06:21.396939+00	10.00	2018-07-28 16:06:21.397071+00	246
204	2018-07-28 16:06:31.954856+00	2018-07-28 16:06:31.954926+00	20.00	2018-07-28 16:06:31.964096+00	95
205	2018-07-28 16:06:42.431125+00	2018-07-28 16:06:42.431184+00	10.00	2018-07-28 16:06:42.431333+00	249
207	2018-07-28 16:07:28.054836+00	2018-07-28 16:07:28.054897+00	15.00	2018-07-28 16:07:28.055119+00	202
208	2018-07-28 16:08:14.980644+00	2018-07-28 16:08:14.980703+00	7.00	2018-07-28 16:08:14.991852+00	14
209	2018-07-28 16:08:47.477236+00	2018-07-28 16:08:47.477292+00	20.00	2018-07-28 16:08:47.47741+00	251
211	2018-07-28 16:09:28.779245+00	2018-07-28 16:09:28.779316+00	30.00	2018-07-28 16:09:28.779471+00	245
215	2018-07-28 16:11:12.923221+00	2018-07-28 16:11:12.923274+00	10.00	2018-07-28 16:11:12.923393+00	13
212	2018-07-28 16:09:55.808291+00	2018-07-28 16:09:55.808452+00	11.00	2018-07-28 16:09:55.808609+00	192
213	2018-07-28 16:10:38.971892+00	2018-07-28 16:10:38.971961+00	4.80	2018-07-28 16:10:38.97211+00	148
214	2018-07-28 16:10:41.815431+00	2018-07-28 16:10:41.8155+00	15.00	2018-07-28 16:10:41.820694+00	14
216	2018-07-28 16:11:26.699697+00	2018-07-28 16:11:26.699755+00	15.00	2018-07-28 16:11:26.699889+00	253
217	2018-07-28 16:11:48.668104+00	2018-07-28 16:11:48.668163+00	15.00	2018-07-28 16:11:48.668287+00	8
218	2018-07-28 16:12:36.44097+00	2018-07-28 16:12:36.44105+00	10.00	2018-07-28 16:12:36.441183+00	152
220	2018-07-28 16:13:14.181742+00	2018-07-28 16:13:14.181801+00	35.00	2018-07-28 16:13:14.181933+00	235
222	2018-07-28 16:13:41.743996+00	2018-07-28 16:13:41.744058+00	20.00	2018-07-28 16:13:41.744188+00	28
224	2018-07-28 16:14:23.898363+00	2018-07-28 16:14:23.898423+00	20.00	2018-07-28 16:14:23.898556+00	91
226	2018-07-28 16:14:44.564031+00	2018-07-28 16:14:44.564086+00	15.00	2018-07-28 16:14:44.564215+00	180
227	2018-07-28 16:15:05.21061+00	2018-07-28 16:15:05.210666+00	20.00	2018-07-28 16:15:05.210781+00	98
219	2018-07-28 16:13:07.403538+00	2018-07-28 16:13:07.403597+00	18.50	2018-07-28 16:13:07.403849+00	24
221	2018-07-28 16:13:37.049269+00	2018-07-28 16:13:37.049326+00	18.50	2018-07-28 16:13:37.04947+00	240
223	2018-07-28 16:14:06.393258+00	2018-07-28 16:14:06.393316+00	22.00	2018-07-28 16:14:06.393966+00	174
225	2018-07-28 16:14:27.575612+00	2018-07-28 16:14:27.575654+00	19.00	2018-07-28 16:14:27.575744+00	204
228	2018-07-28 16:15:22.173078+00	2018-07-28 16:15:22.173141+00	6.00	2018-07-28 16:15:22.173282+00	256
229	2018-07-28 16:15:37.756802+00	2018-07-28 16:15:37.756856+00	20.00	2018-07-28 16:15:37.756978+00	238
230	2018-07-28 16:16:39.46798+00	2018-07-28 16:16:39.468038+00	5.00	2018-07-28 16:16:39.468178+00	198
231	2018-07-28 16:17:04.040259+00	2018-07-28 16:17:04.040318+00	3.00	2018-07-28 16:17:04.040448+00	29
232	2018-07-28 16:17:29.942924+00	2018-07-28 16:17:29.943276+00	6.00	2018-07-28 16:17:29.943424+00	120
233	2018-07-28 16:17:33.513273+00	2018-07-28 16:17:33.513333+00	8.00	2018-07-28 16:17:33.513473+00	147
234	2018-07-28 16:17:48.484724+00	2018-07-28 16:17:48.484774+00	6.00	2018-07-28 16:17:48.485385+00	4
235	2018-07-28 16:18:26.180711+00	2018-07-28 16:18:26.18077+00	10.00	2018-07-28 16:18:26.180948+00	103
236	2018-07-28 16:18:39.760991+00	2018-07-28 16:18:39.761041+00	3.90	2018-07-28 16:18:39.761158+00	4
237	2018-07-28 16:18:43.942828+00	2018-07-28 16:18:43.942883+00	16.00	2018-07-28 16:18:43.943048+00	37
238	2018-07-28 16:18:49.018188+00	2018-07-28 16:18:49.018246+00	7.00	2018-07-28 16:18:49.018376+00	181
239	2018-07-28 16:18:58.734648+00	2018-07-28 16:18:58.734703+00	15.00	2018-07-28 16:18:58.734824+00	228
240	2018-07-28 16:19:08.142455+00	2018-07-28 16:19:08.142507+00	40.00	2018-07-28 16:19:08.142621+00	257
241	2018-07-28 16:19:31.715515+00	2018-07-28 16:19:31.715572+00	7.00	2018-07-28 16:19:31.7157+00	240
242	2018-07-28 16:19:46.573275+00	2018-07-28 16:19:46.57333+00	12.00	2018-07-28 16:19:46.573449+00	258
243	2018-07-28 16:20:14.538201+00	2018-07-28 16:20:14.538257+00	2.00	2018-07-28 16:20:14.538376+00	154
244	2018-07-28 16:20:37.832504+00	2018-07-28 16:20:37.832596+00	2.00	2018-07-28 16:20:37.832758+00	13
245	2018-07-28 16:20:40.756488+00	2018-07-28 16:20:40.756538+00	20.00	2018-07-28 16:20:40.756642+00	260
246	2018-07-28 16:20:50.215799+00	2018-07-28 16:20:50.215857+00	24.00	2018-07-28 16:20:50.216061+00	261
247	2018-07-28 16:20:58.751999+00	2018-07-28 16:20:58.753461+00	8.00	2018-07-28 16:20:58.75361+00	148
248	2018-07-28 16:20:59.814221+00	2018-07-28 16:20:59.814276+00	10.00	2018-07-28 16:20:59.814399+00	264
249	2018-07-28 16:21:20.846053+00	2018-07-28 16:21:20.846104+00	8.00	2018-07-28 16:21:20.846226+00	150
250	2018-07-28 16:21:26.382935+00	2018-07-28 16:21:26.387084+00	10.00	2018-07-28 16:21:26.387271+00	265
251	2018-07-28 16:21:30.451562+00	2018-07-28 16:21:30.451732+00	15.00	2018-07-28 16:21:30.452013+00	255
252	2018-07-28 16:21:46.390562+00	2018-07-28 16:21:46.39062+00	10.00	2018-07-28 16:21:46.390745+00	219
253	2018-07-28 16:22:33.885008+00	2018-07-28 16:22:33.885113+00	10.00	2018-07-28 16:22:33.885294+00	219
254	2018-07-28 16:22:38.222147+00	2018-07-28 16:22:38.222203+00	12.00	2018-07-28 16:22:38.222324+00	152
255	2018-07-28 16:23:21.456046+00	2018-07-28 16:23:21.456107+00	9.00	2018-07-28 16:23:21.456301+00	161
256	2018-07-28 16:23:48.837871+00	2018-07-28 16:23:48.837918+00	11.00	2018-07-28 16:23:48.838029+00	8
257	2018-07-28 16:23:51.334409+00	2018-07-28 16:23:51.334467+00	10.00	2018-07-28 16:23:51.334603+00	159
258	2018-07-28 16:24:12.448925+00	2018-07-28 16:24:12.448989+00	5.00	2018-07-28 16:24:12.449128+00	4
259	2018-07-28 16:24:22.229874+00	2018-07-28 16:24:22.229933+00	3.00	2018-07-28 16:24:22.230073+00	228
260	2018-07-28 16:24:23.320171+00	2018-07-28 16:24:23.320226+00	10.00	2018-07-28 16:24:23.320385+00	226
261	2018-07-28 16:24:58.119249+00	2018-07-28 16:24:58.119307+00	5.00	2018-07-28 16:24:58.119437+00	241
262	2018-07-28 16:25:29.450368+00	2018-07-28 16:25:29.4505+00	10.00	2018-07-28 16:25:29.450634+00	14
263	2018-07-28 16:25:31.644009+00	2018-07-28 16:25:31.644066+00	20.00	2018-07-28 16:25:31.644193+00	266
264	2018-07-28 16:25:36.240562+00	2018-07-28 16:25:36.240615+00	2.00	2018-07-28 16:25:36.240778+00	4
265	2018-07-28 16:25:49.577252+00	2018-07-28 16:25:49.577312+00	18.50	2018-07-28 16:25:49.577439+00	95
266	2018-07-28 16:25:53.540056+00	2018-07-28 16:25:53.540108+00	15.00	2018-07-28 16:25:53.540288+00	211
267	2018-07-28 16:26:28.699864+00	2018-07-28 16:26:28.699918+00	30.00	2018-07-28 16:26:28.700043+00	29
268	2018-07-28 16:27:19.82049+00	2018-07-28 16:27:19.820552+00	20.00	2018-07-28 16:27:19.820696+00	271
269	2018-07-28 16:27:48.907409+00	2018-07-28 16:27:48.907464+00	10.00	2018-07-28 16:27:48.907592+00	83
270	2018-07-28 16:28:14.323572+00	2018-07-28 16:28:14.323628+00	12.00	2018-07-28 16:28:14.323751+00	56
271	2018-07-28 16:28:16.723033+00	2018-07-28 16:28:16.723094+00	12.00	2018-07-28 16:28:16.723213+00	185
272	2018-07-28 16:28:29.114395+00	2018-07-28 16:28:29.114458+00	5.00	2018-07-28 16:28:29.114595+00	269
273	2018-07-28 16:29:16.644506+00	2018-07-28 16:29:16.644602+00	7.00	2018-07-28 16:29:16.645113+00	183
274	2018-07-28 16:29:21.301493+00	2018-07-28 16:29:21.301551+00	1.00	2018-07-28 16:29:21.301683+00	197
275	2018-07-28 16:30:05.235622+00	2018-07-28 16:30:05.235673+00	3.00	2018-07-28 16:30:05.235799+00	183
276	2018-07-28 16:30:30.797825+00	2018-07-28 16:30:30.797881+00	1.00	2018-07-28 16:30:30.798022+00	195
277	2018-07-28 16:30:49.511146+00	2018-07-28 16:30:49.511206+00	14.00	2018-07-28 16:30:49.511346+00	149
278	2018-07-28 16:30:51.563943+00	2018-07-28 16:30:51.564003+00	10.00	2018-07-28 16:30:51.564589+00	274
279	2018-07-28 16:31:13.433097+00	2018-07-28 16:31:13.433147+00	25.00	2018-07-28 16:31:13.433252+00	255
280	2018-07-28 16:31:16.46393+00	2018-07-28 16:31:16.463989+00	10.00	2018-07-28 16:31:16.464118+00	175
281	2018-07-28 16:31:24.10958+00	2018-07-28 16:31:24.109632+00	10.00	2018-07-28 16:31:24.109753+00	204
282	2018-07-28 16:31:51.259667+00	2018-07-28 16:31:51.259727+00	20.00	2018-07-28 16:31:51.259845+00	154
283	2018-07-28 16:32:16.555251+00	2018-07-28 16:32:16.555312+00	25.00	2018-07-28 16:32:16.555537+00	272
284	2018-07-28 16:32:48.603263+00	2018-07-28 16:32:48.603319+00	20.00	2018-07-28 16:32:48.603455+00	120
285	2018-07-28 16:32:50.411132+00	2018-07-28 16:32:50.411426+00	8.00	2018-07-28 16:32:50.411978+00	72
286	2018-07-28 16:33:02.168036+00	2018-07-28 16:33:02.168097+00	20.00	2018-07-28 16:33:02.16823+00	197
287	2018-07-28 16:33:19.819764+00	2018-07-28 16:33:19.819819+00	40.00	2018-07-28 16:33:19.819937+00	220
288	2018-07-28 16:33:26.389049+00	2018-07-28 16:33:26.389104+00	14.00	2018-07-28 16:33:26.389221+00	275
289	2018-07-28 16:34:03.013382+00	2018-07-28 16:34:03.013449+00	15.00	2018-07-28 16:34:03.013636+00	138
290	2018-07-28 16:34:09.459072+00	2018-07-28 16:34:09.459132+00	5.00	2018-07-28 16:34:09.459259+00	255
291	2018-07-28 16:34:33.072635+00	2018-07-28 16:34:33.072692+00	20.00	2018-07-28 16:34:33.072813+00	12
292	2018-07-28 16:34:43.38847+00	2018-07-28 16:34:43.388529+00	25.00	2018-07-28 16:34:43.388663+00	138
293	2018-07-28 16:35:10.768518+00	2018-07-28 16:35:10.768577+00	35.00	2018-07-28 16:35:10.768708+00	80
294	2018-07-28 16:36:30.580014+00	2018-07-28 16:36:30.580067+00	17.00	2018-07-28 16:36:30.580271+00	244
295	2018-07-28 16:36:58.596772+00	2018-07-28 16:36:58.596927+00	1.50	2018-07-28 16:36:58.597162+00	220
296	2018-07-28 16:37:11.554743+00	2018-07-28 16:37:11.554803+00	15.00	2018-07-28 16:37:11.554925+00	117
297	2018-07-28 16:37:20.826275+00	2018-07-28 16:37:20.826331+00	6.00	2018-07-28 16:37:20.826448+00	277
298	2018-07-28 16:37:33.762373+00	2018-07-28 16:37:33.762443+00	8.00	2018-07-28 16:37:33.762586+00	184
299	2018-07-28 16:38:05.544581+00	2018-07-28 16:38:05.544643+00	10.00	2018-07-28 16:38:05.544777+00	267
300	2018-07-28 16:38:24.301157+00	2018-07-28 16:38:24.301213+00	9.00	2018-07-28 16:38:24.301337+00	250
301	2018-07-28 16:38:27.974579+00	2018-07-28 16:38:27.974633+00	20.00	2018-07-28 16:38:27.974752+00	276
302	2018-07-28 16:38:45.000036+00	2018-07-28 16:38:45.0001+00	20.00	2018-07-28 16:38:45.000239+00	30
303	2018-07-28 16:39:00.722641+00	2018-07-28 16:39:00.722697+00	12.00	2018-07-28 16:39:00.722806+00	263
304	2018-07-28 16:39:14.13981+00	2018-07-28 16:39:14.139868+00	30.00	2018-07-28 16:39:14.139996+00	123
305	2018-07-28 16:39:53.206354+00	2018-07-28 16:39:53.206407+00	12.00	2018-07-28 16:39:53.206531+00	255
306	2018-07-28 16:40:24.927563+00	2018-07-28 16:40:24.92762+00	40.00	2018-07-28 16:40:24.92775+00	279
307	2018-07-28 16:41:55.546516+00	2018-07-28 16:41:55.546569+00	10.00	2018-07-28 16:41:55.546725+00	149
308	2018-07-28 16:42:47.759897+00	2018-07-28 16:42:47.759956+00	20.00	2018-07-28 16:42:47.760094+00	35
309	2018-07-28 16:43:35.205649+00	2018-07-28 16:43:35.205707+00	1.00	2018-07-28 16:43:35.205832+00	81
310	2018-07-28 16:43:54.168953+00	2018-07-28 16:43:54.169275+00	10.00	2018-07-28 16:43:54.169407+00	277
311	2018-07-28 16:44:20.39309+00	2018-07-28 16:44:20.39336+00	14.00	2018-07-28 16:44:20.393506+00	140
312	2018-07-28 16:44:55.199181+00	2018-07-28 16:44:55.199282+00	20.00	2018-07-28 16:44:55.199461+00	262
313	2018-07-28 16:45:37.859867+00	2018-07-28 16:45:37.859929+00	17.00	2018-07-28 16:45:37.860053+00	283
314	2018-07-28 16:45:59.232203+00	2018-07-28 16:45:59.232264+00	8.00	2018-07-28 16:45:59.232399+00	281
315	2018-07-28 16:46:11.807733+00	2018-07-28 16:46:11.807803+00	13.00	2018-07-28 16:46:11.808185+00	282
316	2018-07-28 16:46:39.591491+00	2018-07-28 16:46:39.591545+00	5.00	2018-07-28 16:46:39.591652+00	256
317	2018-07-28 16:46:53.621692+00	2018-07-28 16:46:53.62178+00	45.00	2018-07-28 16:46:53.621921+00	3
318	2018-07-28 16:47:06.582728+00	2018-07-28 16:47:06.582791+00	25.50	2018-07-28 16:47:06.582935+00	234
319	2018-07-28 16:47:07.115547+00	2018-07-28 16:47:07.115613+00	30.00	2018-07-28 16:47:07.115752+00	98
320	2018-07-28 16:47:18.44159+00	2018-07-28 16:47:18.441652+00	16.00	2018-07-28 16:47:18.441797+00	273
321	2018-07-28 16:47:49.646852+00	2018-07-28 16:47:49.64694+00	15.00	2018-07-28 16:47:49.64712+00	284
322	2018-07-28 16:48:13.742342+00	2018-07-28 16:48:13.742407+00	2.00	2018-07-28 16:48:13.742652+00	174
323	2018-07-28 16:48:31.517934+00	2018-07-28 16:48:31.517991+00	10.00	2018-07-28 16:48:31.518118+00	235
324	2018-07-28 16:49:07.625648+00	2018-07-28 16:49:07.62571+00	7.00	2018-07-28 16:49:07.625832+00	265
325	2018-07-28 16:49:12.148118+00	2018-07-28 16:49:12.14819+00	8.00	2018-07-28 16:49:12.148335+00	286
326	2018-07-28 16:49:40.094836+00	2018-07-28 16:49:40.094896+00	2.00	2018-07-28 16:49:40.095125+00	91
327	2018-07-28 16:49:42.578598+00	2018-07-28 16:49:42.578655+00	30.00	2018-07-28 16:49:42.578776+00	12
328	2018-07-28 16:49:57.998959+00	2018-07-28 16:49:57.999057+00	2.00	2018-07-28 16:49:57.999184+00	269
329	2018-07-28 16:50:07.169674+00	2018-07-28 16:50:07.16991+00	10.00	2018-07-28 16:50:07.17016+00	221
330	2018-07-28 16:51:13.55568+00	2018-07-28 16:51:13.555736+00	15.00	2018-07-28 16:51:13.555862+00	288
331	2018-07-28 16:51:13.621838+00	2018-07-28 16:51:13.621895+00	15.00	2018-07-28 16:51:13.622147+00	280
332	2018-07-28 16:52:17.016397+00	2018-07-28 16:52:17.016455+00	12.00	2018-07-28 16:52:17.016583+00	225
333	2018-07-28 16:52:33.639553+00	2018-07-28 16:52:33.639616+00	20.00	2018-07-28 16:52:33.640137+00	243
335	2018-07-28 16:53:01.937135+00	2018-07-28 16:53:01.937209+00	2.00	2018-07-28 16:53:01.937362+00	228
336	2018-07-28 16:54:47.467565+00	2018-07-28 16:54:47.467905+00	22.00	2018-07-28 16:54:47.468053+00	238
340	2018-07-28 16:57:19.94065+00	2018-07-28 16:57:19.940707+00	22.00	2018-07-28 16:57:19.940839+00	285
334	2018-07-28 16:52:48.779845+00	2018-07-28 16:52:48.7799+00	10.00	2018-07-28 16:52:48.780027+00	270
337	2018-07-28 16:55:53.495768+00	2018-07-28 16:55:53.495822+00	5.00	2018-07-28 16:55:53.495949+00	238
338	2018-07-28 16:56:04.135859+00	2018-07-28 16:56:04.135918+00	15.00	2018-07-28 16:56:04.136053+00	273
339	2018-07-28 16:57:00.020218+00	2018-07-28 16:57:00.020279+00	17.00	2018-07-28 16:57:00.020405+00	290
342	2018-07-28 16:58:32.996812+00	2018-07-28 16:58:32.996873+00	18.00	2018-07-28 16:58:32.997014+00	291
343	2018-07-28 16:59:17.287682+00	2018-07-28 16:59:17.28774+00	11.00	2018-07-28 16:59:17.287859+00	293
344	2018-07-28 16:59:32.444576+00	2018-07-28 16:59:32.444858+00	18.00	2018-07-28 16:59:32.445211+00	206
345	2018-07-28 16:59:32.466761+00	2018-07-28 16:59:32.46681+00	7.00	2018-07-28 16:59:32.466913+00	187
346	2018-07-28 16:59:38.204681+00	2018-07-28 16:59:38.20473+00	12.00	2018-07-28 16:59:38.205675+00	156
347	2018-07-28 16:59:53.078353+00	2018-07-28 16:59:53.07842+00	15.00	2018-07-28 16:59:53.078844+00	294
348	2018-07-28 17:00:45.830147+00	2018-07-28 17:00:45.830209+00	10.00	2018-07-28 17:00:45.830389+00	292
349	2018-07-28 17:01:02.90574+00	2018-07-28 17:01:02.905795+00	35.00	2018-07-28 17:01:02.905925+00	277
350	2018-07-28 17:01:42.826193+00	2018-07-28 17:01:42.826254+00	20.00	2018-07-28 17:01:42.827143+00	295
351	2018-07-28 17:02:19.467765+00	2018-07-28 17:02:19.467819+00	25.00	2018-07-28 17:02:19.46794+00	296
352	2018-07-28 17:02:46.376229+00	2018-07-28 17:02:46.376289+00	30.00	2018-07-28 17:02:46.376419+00	297
353	2018-07-28 17:03:25.444625+00	2018-07-28 17:03:25.444684+00	4.00	2018-07-28 17:03:25.44499+00	193
141	2018-07-28 15:35:19.648626+00	2018-07-28 17:03:32.268372+00	12.00	2018-07-28 15:35:19.648994+00	224
354	2018-07-28 17:03:44.653466+00	2018-07-28 17:03:44.653525+00	2.00	2018-07-28 17:03:44.653725+00	195
355	2018-07-28 17:03:51.202815+00	2018-07-28 17:03:51.202875+00	10.00	2018-07-28 17:03:51.20304+00	118
356	2018-07-28 17:04:09.703148+00	2018-07-28 17:04:09.703198+00	10.00	2018-07-28 17:04:09.703311+00	299
357	2018-07-28 17:04:15.799427+00	2018-07-28 17:04:15.800026+00	10.00	2018-07-28 17:04:15.800569+00	298
358	2018-07-28 17:04:27.550773+00	2018-07-28 17:04:27.550834+00	10.00	2018-07-28 17:04:27.550969+00	278
359	2018-07-28 17:05:05.461519+00	2018-07-28 17:05:05.46158+00	25.00	2018-07-28 17:05:05.461715+00	160
360	2018-07-28 17:05:14.94826+00	2018-07-28 17:05:14.94832+00	2.00	2018-07-28 17:05:14.948455+00	154
361	2018-07-28 17:05:35.771912+00	2018-07-28 17:05:35.771971+00	40.00	2018-07-28 17:05:35.772111+00	300
362	2018-07-28 17:06:02.928428+00	2018-07-28 17:06:02.928554+00	20.00	2018-07-28 17:06:02.929491+00	96
363	2018-07-28 17:08:56.300093+00	2018-07-28 17:08:56.300156+00	4.00	2018-07-28 17:08:56.300294+00	223
365	2018-07-28 17:09:45.243729+00	2018-07-28 17:09:45.243841+00	16.00	2018-07-28 17:09:45.244035+00	301
366	2018-07-28 17:09:57.432176+00	2018-07-28 17:09:57.432361+00	20.00	2018-07-28 17:09:57.432494+00	105
367	2018-07-28 17:11:07.660568+00	2018-07-28 17:11:07.660635+00	2.00	2018-07-28 17:11:07.660777+00	154
368	2018-07-28 17:11:57.286908+00	2018-07-28 17:11:57.292286+00	10.00	2018-07-28 17:11:57.292462+00	144
369	2018-07-28 17:12:23.032938+00	2018-07-28 17:12:23.033221+00	10.00	2018-07-28 17:12:23.033569+00	266
370	2018-07-28 17:12:35.844537+00	2018-07-28 17:12:35.84461+00	6.00	2018-07-28 17:12:35.84483+00	303
371	2018-07-28 17:12:41.893453+00	2018-07-28 17:12:41.893515+00	4.00	2018-07-28 17:12:41.893656+00	96
372	2018-07-28 17:12:50.332814+00	2018-07-28 17:12:50.332874+00	15.00	2018-07-28 17:12:50.333003+00	135
373	2018-07-28 17:14:33.663163+00	2018-07-28 17:14:33.663222+00	13.00	2018-07-28 17:14:33.663348+00	304
374	2018-07-28 17:14:46.431462+00	2018-07-28 17:14:46.431528+00	5.00	2018-07-28 17:14:46.431793+00	305
375	2018-07-28 17:15:48.390768+00	2018-07-28 17:15:48.390822+00	12.00	2018-07-28 17:15:48.390964+00	306
376	2018-07-28 17:16:13.495957+00	2018-07-28 17:16:13.496038+00	0.50	2018-07-28 17:16:13.496167+00	154
377	2018-07-28 17:16:31.33656+00	2018-07-28 17:16:31.33662+00	10.00	2018-07-28 17:16:31.336752+00	307
378	2018-07-28 17:16:45.82855+00	2018-07-28 17:16:45.828773+00	11.00	2018-07-28 17:16:45.829811+00	188
379	2018-07-28 17:17:03.416509+00	2018-07-28 17:17:03.416563+00	10.00	2018-07-28 17:17:03.416683+00	257
380	2018-07-28 17:17:26.746471+00	2018-07-28 17:17:26.746535+00	0.40	2018-07-28 17:17:26.746673+00	168
381	2018-07-28 17:17:53.324527+00	2018-07-28 17:17:53.324582+00	10.00	2018-07-28 17:17:53.324705+00	309
382	2018-07-28 17:17:54.134024+00	2018-07-28 17:17:54.14273+00	10.00	2018-07-28 17:17:54.142889+00	80
383	2018-07-28 17:18:30.507719+00	2018-07-28 17:18:30.507778+00	8.00	2018-07-28 17:18:30.507913+00	308
384	2018-07-28 17:19:12.111229+00	2018-07-28 17:19:12.111286+00	13.00	2018-07-28 17:19:12.11141+00	168
385	2018-07-28 17:19:27.242456+00	2018-07-28 17:19:27.242517+00	12.00	2018-07-28 17:19:27.242658+00	189
386	2018-07-28 17:20:00.393983+00	2018-07-28 17:20:00.394045+00	5.00	2018-07-28 17:20:00.394185+00	220
387	2018-07-28 17:20:42.346827+00	2018-07-28 17:20:42.346883+00	7.00	2018-07-28 17:20:42.347035+00	310
388	2018-07-28 17:20:53.949405+00	2018-07-28 17:20:53.949464+00	8.00	2018-07-28 17:20:53.949633+00	35
389	2018-07-28 17:21:01.86805+00	2018-07-28 17:21:01.868107+00	10.83	2018-07-28 17:21:01.868231+00	80
390	2018-07-28 17:21:12.362145+00	2018-07-28 17:21:12.362204+00	4.00	2018-07-28 17:21:12.362332+00	195
391	2018-07-28 17:21:20.796178+00	2018-07-28 17:21:20.796253+00	25.00	2018-07-28 17:21:20.796402+00	62
392	2018-07-28 17:21:32.331395+00	2018-07-28 17:21:32.331457+00	19.00	2018-07-28 17:21:32.331594+00	230
393	2018-07-28 17:21:53.696687+00	2018-07-28 17:21:53.696744+00	75.00	2018-07-28 17:21:53.696892+00	55
394	2018-07-28 17:22:18.394431+00	2018-07-28 17:22:18.394488+00	25.00	2018-07-28 17:22:18.394698+00	316
395	2018-07-28 17:23:45.619474+00	2018-07-28 17:23:45.619534+00	10.00	2018-07-28 17:23:45.619667+00	265
396	2018-07-28 17:23:48.268007+00	2018-07-28 17:23:48.268063+00	7.00	2018-07-28 17:23:48.26827+00	317
397	2018-07-28 17:23:51.814066+00	2018-07-28 17:23:51.814125+00	18.00	2018-07-28 17:23:51.814257+00	314
398	2018-07-28 17:24:03.582266+00	2018-07-28 17:24:03.582324+00	25.00	2018-07-28 17:24:03.582453+00	268
399	2018-07-28 17:24:11.014022+00	2018-07-28 17:24:11.014093+00	5.00	2018-07-28 17:24:11.014229+00	214
400	2018-07-28 17:24:11.137014+00	2018-07-28 17:24:11.137069+00	6.00	2018-07-28 17:24:11.137198+00	14
401	2018-07-28 17:24:14.089268+00	2018-07-28 17:24:14.089373+00	1.00	2018-07-28 17:24:14.089486+00	193
402	2018-07-28 17:24:22.236552+00	2018-07-28 17:24:22.236658+00	10.00	2018-07-28 17:24:22.23681+00	223
403	2018-07-28 17:24:34.856398+00	2018-07-28 17:24:34.856459+00	1.00	2018-07-28 17:24:34.856599+00	117
404	2018-07-28 17:24:36.912001+00	2018-07-28 17:24:36.912108+00	20.00	2018-07-28 17:24:36.912458+00	287
405	2018-07-28 17:24:39.484686+00	2018-07-28 17:24:39.484747+00	2.00	2018-07-28 17:24:39.48488+00	154
406	2018-07-28 17:24:51.914875+00	2018-07-28 17:24:51.914937+00	20.00	2018-07-28 17:24:51.915098+00	90
407	2018-07-28 17:25:16.627075+00	2018-07-28 17:25:16.627135+00	30.00	2018-07-28 17:25:16.627289+00	318
408	2018-07-28 17:25:26.488227+00	2018-07-28 17:25:26.488286+00	5.00	2018-07-28 17:25:26.488406+00	250
409	2018-07-28 17:25:49.588416+00	2018-07-28 17:25:49.588475+00	10.00	2018-07-28 17:25:49.588649+00	3
410	2018-07-28 17:25:56.852251+00	2018-07-28 17:25:56.852313+00	6.00	2018-07-28 17:25:56.852444+00	81
411	2018-07-28 17:26:47.40773+00	2018-07-28 17:26:47.407828+00	24.00	2018-07-28 17:26:47.407995+00	260
412	2018-07-28 17:27:21.445398+00	2018-07-28 17:27:21.445459+00	18.00	2018-07-28 17:27:21.445913+00	271
413	2018-07-28 17:27:42.08704+00	2018-07-28 17:27:42.087092+00	5.00	2018-07-28 17:27:42.087205+00	320
414	2018-07-28 17:27:50.713584+00	2018-07-28 17:27:50.713646+00	10.00	2018-07-28 17:27:50.713788+00	318
415	2018-07-28 17:28:06.543992+00	2018-07-28 17:28:06.544045+00	20.00	2018-07-28 17:28:06.544168+00	113
416	2018-07-28 17:28:25.173335+00	2018-07-28 17:28:25.173408+00	1.00	2018-07-28 17:28:25.174171+00	4
417	2018-07-28 17:28:35.720847+00	2018-07-28 17:28:35.720908+00	20.00	2018-07-28 17:28:35.721043+00	321
418	2018-07-28 17:28:42.131793+00	2018-07-28 17:28:42.131852+00	2.00	2018-07-28 17:28:42.131978+00	294
419	2018-07-28 17:29:17.168603+00	2018-07-28 17:29:17.16866+00	20.00	2018-07-28 17:29:17.168786+00	302
420	2018-07-28 17:30:01.303964+00	2018-07-28 17:30:01.304023+00	30.00	2018-07-28 17:30:01.30415+00	313
421	2018-07-28 17:32:43.218405+00	2018-07-28 17:32:43.218468+00	2.00	2018-07-28 17:32:43.218611+00	262
422	2018-07-28 17:34:38.334006+00	2018-07-28 17:34:38.334057+00	60.00	2018-07-28 17:34:38.334174+00	12
423	2018-07-28 17:34:53.776247+00	2018-07-28 17:34:53.776304+00	12.00	2018-07-28 17:34:53.77645+00	229
424	2018-07-28 17:35:30.664036+00	2018-07-28 17:35:30.664097+00	15.00	2018-07-28 17:35:30.664458+00	172
425	2018-07-28 17:36:12.992829+00	2018-07-28 17:36:12.992888+00	10.00	2018-07-28 17:36:12.99303+00	324
426	2018-07-28 17:36:27.655896+00	2018-07-28 17:36:27.655954+00	30.00	2018-07-28 17:36:27.656088+00	72
427	2018-07-28 17:36:41.888202+00	2018-07-28 17:36:41.888642+00	10.00	2018-07-28 17:36:41.888786+00	323
428	2018-07-28 17:37:00.60795+00	2018-07-28 17:37:00.608013+00	5.00	2018-07-28 17:37:00.608142+00	281
429	2018-07-28 17:37:22.615764+00	2018-07-28 17:37:22.615821+00	80.00	2018-07-28 17:37:22.615941+00	245
430	2018-07-28 17:37:43.038233+00	2018-07-28 17:37:43.038293+00	90.00	2018-07-28 17:37:43.038654+00	13
431	2018-07-28 17:38:44.020232+00	2018-07-28 17:38:44.020292+00	50.00	2018-07-28 17:38:44.020441+00	319
432	2018-07-28 17:39:01.619514+00	2018-07-28 17:39:01.625206+00	10.00	2018-07-28 17:39:01.627567+00	202
433	2018-07-28 17:39:22.285216+00	2018-07-28 17:39:22.285274+00	5.00	2018-07-28 17:39:22.285891+00	20
434	2018-07-28 17:39:53.927675+00	2018-07-28 17:39:53.927734+00	20.00	2018-07-28 17:39:53.927875+00	260
435	2018-07-28 17:41:01.364093+00	2018-07-28 17:41:01.364153+00	20.00	2018-07-28 17:41:01.364294+00	326
436	2018-07-28 17:41:13.218287+00	2018-07-28 17:41:13.218343+00	80.00	2018-07-28 17:41:13.21847+00	126
437	2018-07-28 17:41:16.647783+00	2018-07-28 17:41:16.647848+00	1.00	2018-07-28 17:41:16.64799+00	2
341	2018-07-28 16:57:55.260521+00	2018-07-28 17:41:32.758039+00	2.00	2018-07-28 16:57:55.261266+00	288
438	2018-07-28 17:42:21.837139+00	2018-07-28 17:42:21.852216+00	30.00	2018-07-28 17:42:21.852382+00	328
439	2018-07-28 17:43:21.830976+00	2018-07-28 17:43:21.910512+00	55.00	2018-07-28 17:43:21.926637+00	83
440	2018-07-28 17:43:32.168859+00	2018-07-28 17:43:32.168924+00	3.00	2018-07-28 17:43:32.169069+00	325
441	2018-07-28 17:44:17.944116+00	2018-07-28 17:44:17.944175+00	10.00	2018-07-28 17:44:17.944308+00	62
442	2018-07-28 17:44:36.957384+00	2018-07-28 17:44:36.957572+00	10.00	2018-07-28 17:44:36.957703+00	330
443	2018-07-28 17:44:44.034786+00	2018-07-28 17:44:44.034916+00	20.00	2018-07-28 17:44:44.035269+00	133
444	2018-07-28 17:44:45.467624+00	2018-07-28 17:44:45.467681+00	2.00	2018-07-28 17:44:45.467808+00	2
445	2018-07-28 17:45:08.917532+00	2018-07-28 17:45:08.917605+00	10.00	2018-07-28 17:45:08.917981+00	231
448	2018-07-28 17:46:03.904226+00	2018-07-28 17:46:03.904289+00	9.00	2018-07-28 17:46:03.904468+00	333
449	2018-07-28 17:46:30.663233+00	2018-07-28 17:46:30.663293+00	10.00	2018-07-28 17:46:30.663428+00	331
451	2018-07-28 17:46:43.248001+00	2018-07-28 17:46:43.248058+00	70.00	2018-07-28 17:46:43.248194+00	171
455	2018-07-28 17:48:02.290645+00	2018-07-28 17:48:02.290837+00	20.00	2018-07-28 17:48:02.290985+00	329
461	2018-07-28 17:49:28.665943+00	2018-07-28 17:49:28.666+00	55.00	2018-07-28 17:49:28.666134+00	289
446	2018-07-28 17:45:19.827222+00	2018-07-28 17:45:19.827279+00	1.00	2018-07-28 17:45:19.827403+00	108
447	2018-07-28 17:45:37.424611+00	2018-07-28 17:45:37.424671+00	13.00	2018-07-28 17:45:37.424795+00	332
450	2018-07-28 17:46:34.900974+00	2018-07-28 17:46:34.901028+00	5.00	2018-07-28 17:46:34.901154+00	20
452	2018-07-28 17:47:07.785883+00	2018-07-28 17:47:07.785939+00	13.00	2018-07-28 17:47:07.786065+00	335
453	2018-07-28 17:47:42.344941+00	2018-07-28 17:47:42.345003+00	10.00	2018-07-28 17:47:42.345134+00	11
454	2018-07-28 17:47:49.647521+00	2018-07-28 17:47:49.647574+00	50.00	2018-07-28 17:47:49.647694+00	273
456	2018-07-28 17:48:04.96385+00	2018-07-28 17:48:04.963909+00	2.00	2018-07-28 17:48:04.96404+00	262
457	2018-07-28 17:48:17.846122+00	2018-07-28 17:48:17.84618+00	7.00	2018-07-28 17:48:17.847891+00	334
458	2018-07-28 17:48:34.548474+00	2018-07-28 17:48:34.548531+00	15.00	2018-07-28 17:48:34.54865+00	279
459	2018-07-28 17:48:50.256984+00	2018-07-28 17:48:50.257041+00	21.50	2018-07-28 17:48:50.257165+00	266
460	2018-07-28 17:49:21.051973+00	2018-07-28 17:49:21.052034+00	6.00	2018-07-28 17:49:21.052166+00	32
462	2018-07-28 17:49:41.987379+00	2018-07-28 17:49:41.987437+00	8.00	2018-07-28 17:49:41.987578+00	337
463	2018-07-28 17:51:00.566546+00	2018-07-28 17:51:00.566596+00	26.00	2018-07-28 17:51:00.566704+00	336
464	2018-07-28 17:51:12.048112+00	2018-07-28 17:51:12.048178+00	30.00	2018-07-28 17:51:12.0483+00	59
465	2018-07-28 17:51:13.096038+00	2018-07-28 17:51:13.096097+00	2.00	2018-07-28 17:51:13.096234+00	262
466	2018-07-28 17:51:16.015883+00	2018-07-28 17:51:16.015939+00	29.00	2018-07-28 17:51:16.016063+00	307
467	2018-07-28 17:51:40.503931+00	2018-07-28 17:51:40.50462+00	6.00	2018-07-28 17:51:40.504774+00	187
468	2018-07-28 17:51:57.903663+00	2018-07-28 17:51:57.903725+00	10.00	2018-07-28 17:51:57.903864+00	339
469	2018-07-28 17:52:19.105815+00	2018-07-28 17:52:19.105875+00	40.00	2018-07-28 17:52:19.106017+00	149
470	2018-07-28 17:52:46.156039+00	2018-07-28 17:52:46.156136+00	10.00	2018-07-28 17:52:46.156299+00	340
471	2018-07-28 17:53:02.357399+00	2018-07-28 17:53:02.357456+00	3.00	2018-07-28 17:53:02.357581+00	273
472	2018-07-28 17:54:04.40245+00	2018-07-28 17:54:04.402511+00	190.00	2018-07-28 17:54:04.402642+00	139
473	2018-07-28 17:54:05.731334+00	2018-07-28 17:54:05.731393+00	5.00	2018-07-28 17:54:05.73152+00	101
474	2018-07-28 17:55:43.427412+00	2018-07-28 17:55:43.427471+00	2.00	2018-07-28 17:55:43.42759+00	329
475	2018-07-28 17:56:27.972833+00	2018-07-28 17:56:27.972896+00	1.00	2018-07-28 17:56:27.973078+00	334
476	2018-07-28 17:56:41.36509+00	2018-07-28 17:56:41.365137+00	155.00	2018-07-28 17:56:41.365259+00	315
477	2018-07-28 17:57:51.556378+00	2018-07-28 17:57:51.556443+00	2.00	2018-07-28 17:57:51.556596+00	262
478	2018-07-28 17:58:17.074304+00	2018-07-28 17:58:17.074362+00	300.00	2018-07-28 17:58:17.074495+00	290
479	2018-07-28 18:00:57.563934+00	2018-07-28 18:00:57.563991+00	10.00	2018-07-28 18:00:57.564117+00	101
480	2018-07-28 18:02:39.04732+00	2018-07-28 18:02:39.047371+00	0.00	2018-07-28 18:02:39.047489+00	2
481	2018-07-28 18:03:13.599483+00	2018-07-28 18:03:13.599539+00	10.00	2018-07-28 18:03:13.599657+00	301
482	2018-07-28 18:04:13.067511+00	2018-07-28 18:04:13.067563+00	15.00	2018-07-28 18:04:13.067681+00	347
483	2018-07-28 18:05:08.425965+00	2018-07-28 18:05:08.426029+00	4.00	2018-07-28 18:05:08.426174+00	345
484	2018-07-28 18:05:15.229354+00	2018-07-28 18:05:15.229611+00	15.00	2018-07-28 18:05:15.229754+00	2
486	2018-07-28 18:06:21.472396+00	2018-07-28 18:06:21.472469+00	22.00	2018-07-28 18:06:21.472607+00	343
487	2018-07-28 18:07:31.507811+00	2018-07-28 18:07:31.507875+00	20.15	2018-07-28 18:07:31.508016+00	348
488	2018-07-28 18:07:45.347154+00	2018-07-28 18:07:45.347214+00	30.00	2018-07-28 18:07:45.347353+00	132
489	2018-07-28 18:08:19.112281+00	2018-07-28 18:08:19.112336+00	10.00	2018-07-28 18:08:19.112466+00	179
490	2018-07-28 18:09:08.663653+00	2018-07-28 18:09:08.663718+00	4.00	2018-07-28 18:09:08.663862+00	187
491	2018-07-28 18:10:04.40799+00	2018-07-28 18:10:04.408049+00	3.00	2018-07-28 18:10:04.408198+00	336
492	2018-07-28 18:10:48.212676+00	2018-07-28 18:10:48.213289+00	21.00	2018-07-28 18:10:48.213411+00	349
493	2018-07-28 18:12:30.397829+00	2018-07-28 18:12:30.397888+00	1.00	2018-07-28 18:12:30.398011+00	272
494	2018-07-28 18:13:31.251748+00	2018-07-28 18:13:31.251848+00	10.00	2018-07-28 18:13:31.252024+00	310
495	2018-07-28 18:13:34.041466+00	2018-07-28 18:13:34.04157+00	2.00	2018-07-28 18:13:34.041833+00	336
496	2018-07-28 18:14:23.474854+00	2018-07-28 18:14:23.474957+00	1.00	2018-07-28 18:14:23.475159+00	305
497	2018-07-28 18:15:06.230224+00	2018-07-28 18:15:06.23028+00	3600.00	2018-07-28 18:15:06.23041+00	123
498	2018-07-28 18:15:28.677084+00	2018-07-28 18:15:28.677146+00	12.00	2018-07-28 18:15:28.677403+00	11
499	2018-07-28 18:15:41.230397+00	2018-07-28 18:15:41.230453+00	10.00	2018-07-28 18:15:41.230572+00	260
500	2018-07-28 18:15:48.323608+00	2018-07-28 18:15:48.323745+00	1.00	2018-07-28 18:15:48.324059+00	272
501	2018-07-28 18:16:08.439934+00	2018-07-28 18:16:08.439998+00	6.00	2018-07-28 18:16:08.440126+00	263
502	2018-07-28 18:17:00.928294+00	2018-07-28 18:17:00.928351+00	15.00	2018-07-28 18:17:00.928491+00	99
503	2018-07-28 18:17:02.928512+00	2018-07-28 18:17:02.928598+00	20.00	2018-07-28 18:17:02.928798+00	276
504	2018-07-28 18:17:11.540328+00	2018-07-28 18:17:11.540389+00	22.50	2018-07-28 18:17:11.540536+00	105
505	2018-07-28 18:18:11.90993+00	2018-07-28 18:18:11.909992+00	15.00	2018-07-28 18:18:11.910147+00	177
506	2018-07-28 18:18:20.684183+00	2018-07-28 18:18:20.684235+00	4.00	2018-07-28 18:18:20.684352+00	11
507	2018-07-28 18:18:27.547741+00	2018-07-28 18:18:27.547796+00	5.00	2018-07-28 18:18:27.547922+00	344
508	2018-07-28 18:18:41.303793+00	2018-07-28 18:18:41.303888+00	6.00	2018-07-28 18:18:41.304292+00	338
509	2018-07-28 18:18:51.247863+00	2018-07-28 18:18:51.247923+00	12.00	2018-07-28 18:18:51.248059+00	321
510	2018-07-28 18:19:14.755831+00	2018-07-28 18:19:14.755889+00	3.00	2018-07-28 18:19:14.756024+00	113
511	2018-07-28 18:19:27.623896+00	2018-07-28 18:19:27.623955+00	15.00	2018-07-28 18:19:27.624089+00	158
512	2018-07-28 18:19:51.16121+00	2018-07-28 18:19:51.16148+00	100.00	2018-07-28 18:19:51.161817+00	249
513	2018-07-28 18:19:52.968063+00	2018-07-28 18:19:52.968118+00	15.00	2018-07-28 18:19:52.96825+00	12
514	2018-07-28 18:20:09.224112+00	2018-07-28 18:20:09.224172+00	100.00	2018-07-28 18:20:09.224304+00	193
515	2018-07-28 18:20:20.922941+00	2018-07-28 18:20:20.923226+00	100.00	2018-07-28 18:20:20.923496+00	253
516	2018-07-28 18:20:23.830305+00	2018-07-28 18:20:23.830356+00	150.00	2018-07-28 18:20:23.830473+00	278
517	2018-07-28 18:20:31.315583+00	2018-07-28 18:20:31.315631+00	100.00	2018-07-28 18:20:31.315756+00	221
518	2018-07-28 18:20:44.732708+00	2018-07-28 18:20:44.732763+00	100.00	2018-07-28 18:20:44.73289+00	164
519	2018-07-28 18:20:46.69363+00	2018-07-28 18:20:46.693692+00	10.00	2018-07-28 18:20:46.693823+00	260
521	2018-07-28 18:21:18.936712+00	2018-07-28 18:21:18.937424+00	100.00	2018-07-28 18:21:18.937865+00	1
522	2018-07-28 18:21:29.524868+00	2018-07-28 18:21:29.52499+00	100.00	2018-07-28 18:21:29.525123+00	275
523	2018-07-28 18:21:34.536531+00	2018-07-28 18:21:34.536584+00	15.00	2018-07-28 18:21:34.536708+00	152
524	2018-07-28 18:21:42.124311+00	2018-07-28 18:21:42.124375+00	200.00	2018-07-28 18:21:42.124517+00	174
525	2018-07-28 18:21:55.12081+00	2018-07-28 18:21:55.120867+00	200.00	2018-07-28 18:21:55.121002+00	270
527	2018-07-28 18:22:02.701363+00	2018-07-28 18:22:02.701421+00	15.00	2018-07-28 18:22:02.702241+00	290
528	2018-07-28 18:22:09.226972+00	2018-07-28 18:22:09.227418+00	200.00	2018-07-28 18:22:09.227605+00	24
529	2018-07-28 18:22:37.163912+00	2018-07-28 18:22:37.163966+00	200.00	2018-07-28 18:22:37.164103+00	228
530	2018-07-28 18:22:47.519808+00	2018-07-28 18:22:47.519858+00	12.00	2018-07-28 18:22:47.519964+00	101
531	2018-07-28 18:22:53.425761+00	2018-07-28 18:22:53.425857+00	50.00	2018-07-28 18:22:53.426951+00	3
532	2018-07-28 18:22:53.892111+00	2018-07-28 18:22:53.892169+00	200.00	2018-07-28 18:22:53.892306+00	62
533	2018-07-28 18:23:16.853804+00	2018-07-28 18:23:16.853862+00	250.00	2018-07-28 18:23:16.853997+00	93
534	2018-07-28 18:23:27.639989+00	2018-07-28 18:23:27.640049+00	2.50	2018-07-28 18:23:27.640182+00	309
535	2018-07-28 18:23:28.39229+00	2018-07-28 18:23:28.39235+00	15.00	2018-07-28 18:23:28.392489+00	62
536	2018-07-28 18:24:21.903994+00	2018-07-28 18:24:21.904118+00	5.00	2018-07-28 18:24:21.904259+00	319
537	2018-07-28 18:24:44.847871+00	2018-07-28 18:24:44.847925+00	11.00	2018-07-28 18:24:44.848051+00	179
538	2018-07-28 18:25:12.867081+00	2018-07-28 18:25:12.867132+00	5.00	2018-07-28 18:25:12.867255+00	267
539	2018-07-28 18:25:14.335305+00	2018-07-28 18:25:14.335357+00	70.00	2018-07-28 18:25:14.335477+00	315
540	2018-07-28 18:25:29.000377+00	2018-07-28 18:25:29.000449+00	250.00	2018-07-28 18:25:29.00058+00	238
541	2018-07-28 18:25:52.432454+00	2018-07-28 18:25:52.432513+00	250.00	2018-07-28 18:25:52.432649+00	149
542	2018-07-28 18:26:05.50799+00	2018-07-28 18:26:05.508049+00	250.00	2018-07-28 18:26:05.508414+00	12
543	2018-07-28 18:26:23.181892+00	2018-07-28 18:26:23.181946+00	250.00	2018-07-28 18:26:23.182072+00	105
544	2018-07-28 18:26:52.715891+00	2018-07-28 18:26:52.715949+00	90.00	2018-07-28 18:26:52.71608+00	182
545	2018-07-28 18:27:57.563857+00	2018-07-28 18:27:57.56392+00	9.00	2018-07-28 18:27:57.564052+00	350
547	2018-07-28 18:29:07.132239+00	2018-07-28 18:29:07.132529+00	12.00	2018-07-28 18:29:07.133084+00	351
548	2018-07-28 18:29:27.878255+00	2018-07-28 18:29:27.878309+00	18.00	2018-07-28 18:29:27.878435+00	321
549	2018-07-28 18:29:41.735223+00	2018-07-28 18:29:41.735275+00	40.00	2018-07-28 18:29:41.7354+00	331
550	2018-07-28 18:29:51.432052+00	2018-07-28 18:29:51.432202+00	1000.00	2018-07-28 18:29:51.432353+00	120
551	2018-07-28 18:30:08.512144+00	2018-07-28 18:30:08.512204+00	1000.00	2018-07-28 18:30:08.512527+00	58
552	2018-07-28 18:30:15.685088+00	2018-07-28 18:30:15.685156+00	5.00	2018-07-28 18:30:15.689975+00	98
553	2018-07-28 18:30:34.87802+00	2018-07-28 18:30:34.878079+00	420.00	2018-07-28 18:30:34.87829+00	142
554	2018-07-28 18:30:56.689244+00	2018-07-28 18:30:56.689304+00	10.00	2018-07-28 18:30:56.689443+00	341
555	2018-07-28 18:30:57.729997+00	2018-07-28 18:30:57.730059+00	5.00	2018-07-28 18:30:57.730244+00	204
556	2018-07-28 18:31:40.154651+00	2018-07-28 18:31:40.154709+00	2.00	2018-07-28 18:31:40.154842+00	263
557	2018-07-28 18:31:54.355653+00	2018-07-28 18:31:54.355712+00	10.00	2018-07-28 18:31:54.355847+00	293
558	2018-07-28 18:31:58.962433+00	2018-07-28 18:31:58.962488+00	500.00	2018-07-28 18:31:58.962622+00	342
559	2018-07-28 18:32:10.726328+00	2018-07-28 18:32:10.726388+00	70.00	2018-07-28 18:32:10.726524+00	83
485	2018-07-28 18:06:14.256071+00	2018-07-28 19:46:40.655715+00	152.00	2018-07-28 18:06:14.256275+00	105
560	2018-07-28 18:32:16.586047+00	2018-07-28 18:32:16.586116+00	500.00	2018-07-28 18:32:16.586272+00	83
563	2018-07-28 18:32:41.136116+00	2018-07-28 18:32:41.136174+00	10.00	2018-07-28 18:32:41.136315+00	276
564	2018-07-28 18:32:48.140209+00	2018-07-28 18:32:48.140269+00	500.00	2018-07-28 18:32:48.140388+00	190
570	2018-07-28 18:34:10.641084+00	2018-07-28 18:34:10.641136+00	500.00	2018-07-28 18:34:10.641255+00	139
571	2018-07-28 18:34:10.915039+00	2018-07-28 18:34:10.915105+00	400.00	2018-07-28 18:34:10.915238+00	99
573	2018-07-28 18:34:41.203897+00	2018-07-28 18:34:41.203954+00	300.00	2018-07-28 18:34:41.20409+00	81
574	2018-07-28 18:35:10.836708+00	2018-07-28 18:35:10.836768+00	300.00	2018-07-28 18:35:10.836899+00	91
575	2018-07-28 18:35:24.196285+00	2018-07-28 18:35:24.196345+00	300.00	2018-07-28 18:35:24.196479+00	133
577	2018-07-28 18:35:54.899926+00	2018-07-28 18:35:54.899981+00	80.00	2018-07-28 18:35:54.900111+00	99
583	2018-07-28 18:39:06.653912+00	2018-07-28 18:39:06.653965+00	300.00	2018-07-28 18:39:06.654091+00	99
561	2018-07-28 18:32:28.914525+00	2018-07-28 18:32:28.914611+00	10.00	2018-07-28 18:32:28.915457+00	113
562	2018-07-28 18:32:32.349449+00	2018-07-28 18:32:32.349511+00	500.00	2018-07-28 18:32:32.349709+00	60
565	2018-07-28 18:33:09.353618+00	2018-07-28 18:33:09.353682+00	500.00	2018-07-28 18:33:09.353802+00	4
567	2018-07-28 18:33:33.435811+00	2018-07-28 18:33:33.435861+00	6.00	2018-07-28 18:33:33.435974+00	154
568	2018-07-28 18:33:41.194968+00	2018-07-28 18:33:41.195079+00	500.00	2018-07-28 18:33:41.195207+00	55
569	2018-07-28 18:34:04.983145+00	2018-07-28 18:34:04.983242+00	0.50	2018-07-28 18:34:04.983578+00	331
572	2018-07-28 18:34:24.460276+00	2018-07-28 18:34:24.460337+00	500.00	2018-07-28 18:34:24.460474+00	38
576	2018-07-28 18:35:53.100362+00	2018-07-28 18:35:53.100424+00	300.00	2018-07-28 18:35:53.100572+00	59
578	2018-07-28 18:36:08.927865+00	2018-07-28 18:36:08.927924+00	15.00	2018-07-28 18:36:08.92805+00	315
579	2018-07-28 18:37:44.311759+00	2018-07-28 18:37:44.311815+00	8.00	2018-07-28 18:37:44.311948+00	353
580	2018-07-28 18:37:46.0719+00	2018-07-28 18:37:46.071967+00	15.00	2018-07-28 18:37:46.072101+00	8
581	2018-07-28 18:38:39.063834+00	2018-07-28 18:38:39.063882+00	300.00	2018-07-28 18:38:39.064002+00	72
582	2018-07-28 18:38:53.628667+00	2018-07-28 18:38:53.62872+00	300.00	2018-07-28 18:38:53.628957+00	229
584	2018-07-28 18:39:07.354035+00	2018-07-28 18:39:07.354157+00	55.00	2018-07-28 18:39:07.35428+00	185
585	2018-07-28 18:40:08.977367+00	2018-07-28 18:40:08.977416+00	300.00	2018-07-28 18:40:08.977541+00	30
586	2018-07-28 18:40:34.543501+00	2018-07-28 18:40:34.543568+00	300.00	2018-07-28 18:40:34.543751+00	260
587	2018-07-28 18:40:49.484587+00	2018-07-28 18:40:49.48467+00	300.00	2018-07-28 18:40:49.484812+00	295
588	2018-07-28 18:41:19.555993+00	2018-07-28 18:41:19.556054+00	50.00	2018-07-28 18:41:19.556319+00	215
589	2018-07-28 18:41:39.608248+00	2018-07-28 18:41:39.608517+00	50.00	2018-07-28 18:41:39.608882+00	337
590	2018-07-28 18:41:44.130591+00	2018-07-28 18:41:44.130646+00	300.00	2018-07-28 18:41:44.130775+00	133
591	2018-07-28 18:41:55.184022+00	2018-07-28 18:41:55.184075+00	50.00	2018-07-28 18:41:55.184201+00	26
592	2018-07-28 18:41:56.960584+00	2018-07-28 18:41:56.960642+00	0.00	2018-07-28 18:41:56.960761+00	354
593	2018-07-28 18:42:17.955455+00	2018-07-28 18:42:17.955518+00	50.00	2018-07-28 18:42:17.95567+00	319
594	2018-07-28 18:42:34.253452+00	2018-07-28 18:42:34.253509+00	50.00	2018-07-28 18:42:34.25368+00	103
595	2018-07-28 18:42:38.168263+00	2018-07-28 18:42:38.168318+00	5.00	2018-07-28 18:42:38.168439+00	354
596	2018-07-28 18:42:57.292238+00	2018-07-28 18:42:57.292291+00	2.00	2018-07-28 18:42:57.292409+00	3
597	2018-07-28 18:43:20.641785+00	2018-07-28 18:43:20.641839+00	5.00	2018-07-28 18:43:20.64197+00	251
598	2018-07-28 18:43:44.212008+00	2018-07-28 18:43:44.21207+00	210.00	2018-07-28 18:43:44.212201+00	265
599	2018-07-28 18:44:03.694294+00	2018-07-28 18:44:03.694362+00	50.00	2018-07-28 18:44:03.694561+00	311
600	2018-07-28 18:44:24.727162+00	2018-07-28 18:44:24.72725+00	50.00	2018-07-28 18:44:24.727428+00	56
601	2018-07-28 18:44:40.665945+00	2018-07-28 18:44:40.665996+00	50.00	2018-07-28 18:44:40.666118+00	142
602	2018-07-28 18:44:52.515938+00	2018-07-28 18:44:52.515997+00	12.00	2018-07-28 18:44:52.516131+00	20
603	2018-07-28 18:44:54.326649+00	2018-07-28 18:44:54.326709+00	50.00	2018-07-28 18:44:54.326866+00	171
604	2018-07-28 18:45:11.403605+00	2018-07-28 18:45:11.403668+00	25.00	2018-07-28 18:45:11.403808+00	13
605	2018-07-28 18:45:24.886211+00	2018-07-28 18:45:24.886269+00	25.00	2018-07-28 18:45:24.886405+00	178
606	2018-07-28 18:45:41.284333+00	2018-07-28 18:45:41.284392+00	25.00	2018-07-28 18:45:41.284529+00	312
607	2018-07-28 18:45:48.66794+00	2018-07-28 18:45:48.667996+00	390.00	2018-07-28 18:45:48.668124+00	105
608	2018-07-28 18:46:12.177811+00	2018-07-28 18:46:12.177873+00	100.00	2018-07-28 18:46:12.178007+00	271
609	2018-07-28 18:46:34.040911+00	2018-07-28 18:46:34.04096+00	100.00	2018-07-28 18:46:34.04107+00	9
610	2018-07-28 18:46:48.618714+00	2018-07-28 18:46:48.618769+00	60.00	2018-07-28 18:46:48.618886+00	59
611	2018-07-28 18:46:49.93643+00	2018-07-28 18:46:49.936479+00	100.00	2018-07-28 18:46:49.936585+00	217
612	2018-07-28 18:47:06.293676+00	2018-07-28 18:47:06.293958+00	100.00	2018-07-28 18:47:06.294315+00	292
613	2018-07-28 18:48:18.578895+00	2018-07-28 18:48:18.578945+00	25.00	2018-07-28 18:48:18.579107+00	204
614	2018-07-28 18:48:39.41586+00	2018-07-28 18:48:39.415917+00	210.00	2018-07-28 18:48:39.416056+00	55
615	2018-07-28 18:49:02.503095+00	2018-07-28 18:49:02.503149+00	250.00	2018-07-28 18:49:02.503269+00	96
616	2018-07-28 18:49:41.719943+00	2018-07-28 18:49:41.719988+00	25.00	2018-07-28 18:49:41.720109+00	143
617	2018-07-28 18:49:54.898832+00	2018-07-28 18:49:54.898905+00	25.00	2018-07-28 18:49:54.900528+00	267
618	2018-07-28 18:50:52.589427+00	2018-07-28 18:50:52.589485+00	50.00	2018-07-28 18:50:52.589615+00	60
619	2018-07-28 18:50:53.289802+00	2018-07-28 18:50:53.289864+00	25.00	2018-07-28 18:50:53.290048+00	327
620	2018-07-28 18:51:15.647533+00	2018-07-28 18:51:15.647587+00	25.00	2018-07-28 18:51:15.647675+00	314
621	2018-07-28 18:51:39.227399+00	2018-07-28 18:51:39.227447+00	25.00	2018-07-28 18:51:39.227562+00	246
622	2018-07-28 18:51:54.060246+00	2018-07-28 18:51:54.060294+00	25.00	2018-07-28 18:51:54.060407+00	251
623	2018-07-28 18:52:28.907386+00	2018-07-28 18:52:28.907481+00	20.00	2018-07-28 18:52:28.907846+00	83
624	2018-07-28 18:54:00.651067+00	2018-07-28 18:54:00.651127+00	5.00	2018-07-28 18:54:00.651258+00	354
625	2018-07-28 18:54:40.268028+00	2018-07-28 18:54:40.268064+00	400.00	2018-07-28 18:54:40.268159+00	342
626	2018-07-28 18:54:43.304012+00	2018-07-28 18:54:43.30407+00	440.00	2018-07-28 18:54:43.304206+00	30
627	2018-07-28 18:56:39.72585+00	2018-07-28 18:56:39.725899+00	310.00	2018-07-28 18:56:39.726092+00	62
628	2018-07-28 18:57:38.311364+00	2018-07-28 18:57:38.311432+00	3.00	2018-07-28 18:57:38.311582+00	4
629	2018-07-28 18:57:58.562457+00	2018-07-28 18:57:58.562515+00	1.00	2018-07-28 18:57:58.56264+00	3
630	2018-07-28 18:58:01.887947+00	2018-07-28 18:58:01.888004+00	90.00	2018-07-28 18:58:01.888131+00	296
631	2018-07-28 18:59:44.986417+00	2018-07-28 18:59:44.986484+00	250.00	2018-07-28 18:59:44.98663+00	8
634	2018-07-28 19:01:53.101858+00	2018-07-28 19:01:53.10192+00	50.00	2018-07-28 19:01:53.102052+00	2
635	2018-07-28 19:03:14.139285+00	2018-07-28 19:03:14.139332+00	20.00	2018-07-28 19:03:14.139515+00	4
636	2018-07-28 19:04:13.664731+00	2018-07-28 19:04:13.664833+00	5.00	2018-07-28 19:04:13.66518+00	133
637	2018-07-28 19:04:24.342498+00	2018-07-28 19:04:24.342693+00	14.00	2018-07-28 19:04:24.343064+00	238
638	2018-07-28 19:04:48.154748+00	2018-07-28 19:04:48.15481+00	0.00	2018-07-28 19:04:48.154946+00	289
639	2018-07-28 19:05:28.14395+00	2018-07-28 19:05:28.144005+00	20.00	2018-07-28 19:05:28.144119+00	187
640	2018-07-28 19:05:49.264696+00	2018-07-28 19:05:49.264839+00	10.00	2018-07-28 19:05:49.265493+00	98
641	2018-07-28 19:06:00.09874+00	2018-07-28 19:06:00.100279+00	100.00	2018-07-28 19:06:00.100435+00	133
643	2018-07-28 19:08:27.244007+00	2018-07-28 19:08:27.244063+00	60.00	2018-07-28 19:08:27.251353+00	292
644	2018-07-28 19:09:05.351356+00	2018-07-28 19:09:05.351535+00	550.00	2018-07-28 19:09:05.352108+00	313
646	2018-07-28 19:10:14.512747+00	2018-07-28 19:10:14.512801+00	60.00	2018-07-28 19:10:14.512922+00	234
647	2018-07-28 19:10:38.516054+00	2018-07-28 19:10:38.516109+00	35.00	2018-07-28 19:10:38.516239+00	9
648	2018-07-28 19:11:12.027983+00	2018-07-28 19:11:12.028043+00	10.00	2018-07-28 19:11:12.02817+00	238
649	2018-07-28 19:11:17.610046+00	2018-07-28 19:11:17.610104+00	8.00	2018-07-28 19:11:17.610685+00	101
650	2018-07-28 19:11:24.274624+00	2018-07-28 19:11:24.274678+00	50.00	2018-07-28 19:11:24.274852+00	59
651	2018-07-28 19:11:46.889391+00	2018-07-28 19:11:46.889467+00	105.00	2018-07-28 19:11:46.891209+00	175
652	2018-07-28 19:12:17.493053+00	2018-07-28 19:12:17.493338+00	80.00	2018-07-28 19:12:17.493532+00	330
653	2018-07-28 19:12:27.141254+00	2018-07-28 19:12:27.141306+00	44.62	2018-07-28 19:12:27.141424+00	344
654	2018-07-28 19:12:41.98916+00	2018-07-28 19:12:41.989217+00	40.00	2018-07-28 19:12:41.989343+00	218
655	2018-07-28 19:12:50.775357+00	2018-07-28 19:12:50.775425+00	12.00	2018-07-28 19:12:50.775586+00	154
656	2018-07-28 19:13:08.327844+00	2018-07-28 19:13:08.327906+00	8.00	2018-07-28 19:13:08.328254+00	185
657	2018-07-28 19:14:07.74859+00	2018-07-28 19:14:07.748648+00	25.00	2018-07-28 19:14:07.748947+00	193
658	2018-07-28 19:14:18.639917+00	2018-07-28 19:14:18.639965+00	20.00	2018-07-28 19:14:18.640075+00	313
659	2018-07-28 19:14:26.639803+00	2018-07-28 19:14:26.639857+00	230.00	2018-07-28 19:14:26.639981+00	322
660	2018-07-28 19:14:37.749552+00	2018-07-28 19:14:37.749815+00	12.00	2018-07-28 19:14:37.750143+00	357
661	2018-07-28 19:15:18.931135+00	2018-07-28 19:15:18.931192+00	55.00	2018-07-28 19:15:18.93133+00	260
662	2018-07-28 19:18:57.287642+00	2018-07-28 19:18:57.287701+00	130.00	2018-07-28 19:18:57.287834+00	234
663	2018-07-28 19:19:42.960091+00	2018-07-28 19:19:42.960151+00	2.00	2018-07-28 19:19:42.960293+00	153
664	2018-07-28 19:20:31.152058+00	2018-07-28 19:20:31.152114+00	130.00	2018-07-28 19:20:31.152239+00	230
665	2018-07-28 19:22:20.996749+00	2018-07-28 19:22:20.99681+00	5.00	2018-07-28 19:22:20.996947+00	92
666	2018-07-28 19:23:41.762399+00	2018-07-28 19:23:41.762455+00	11.00	2018-07-28 19:23:41.762582+00	336
667	2018-07-28 19:26:54.936812+00	2018-07-28 19:26:54.936872+00	5.00	2018-07-28 19:26:54.937026+00	181
668	2018-07-28 19:27:38.999445+00	2018-07-28 19:27:38.999513+00	2.50	2018-07-28 19:27:38.99974+00	336
669	2018-07-28 19:27:41.238253+00	2018-07-28 19:27:41.238317+00	20.00	2018-07-28 19:27:41.238545+00	340
670	2018-07-28 19:29:50.862024+00	2018-07-28 19:29:50.862083+00	6.00	2018-07-28 19:29:50.862212+00	45
671	2018-07-28 19:30:01.177555+00	2018-07-28 19:30:01.177614+00	460.00	2018-07-28 19:30:01.177906+00	27
672	2018-07-28 19:31:59.190196+00	2018-07-28 19:31:59.190253+00	260.00	2018-07-28 19:31:59.190392+00	296
673	2018-07-28 19:32:55.575953+00	2018-07-28 19:32:55.576011+00	2.00	2018-07-28 19:32:55.576141+00	272
674	2018-07-28 19:33:59.917092+00	2018-07-28 19:33:59.917149+00	150.00	2018-07-28 19:33:59.917284+00	120
675	2018-07-28 19:34:58.031825+00	2018-07-28 19:34:58.031881+00	110.00	2018-07-28 19:34:58.032007+00	260
676	2018-07-28 19:35:16.820497+00	2018-07-28 19:35:16.820553+00	23.00	2018-07-28 19:35:16.820664+00	98
677	2018-07-28 19:35:24.379233+00	2018-07-28 19:35:24.379507+00	10.00	2018-07-28 19:35:24.379736+00	70
678	2018-07-28 19:36:04.102797+00	2018-07-28 19:36:04.102858+00	70.00	2018-07-28 19:36:04.103765+00	99
679	2018-07-28 19:36:35.260403+00	2018-07-28 19:36:35.260465+00	20.00	2018-07-28 19:36:35.260601+00	231
680	2018-07-28 19:39:18.725524+00	2018-07-28 19:39:18.725626+00	35.00	2018-07-28 19:39:18.725779+00	296
681	2018-07-28 19:39:47.435962+00	2018-07-28 19:39:47.436018+00	120.00	2018-07-28 19:39:47.436149+00	290
682	2018-07-28 19:40:16.236528+00	2018-07-28 19:40:16.236595+00	60.00	2018-07-28 19:40:16.236888+00	123
683	2018-07-28 19:42:29.865148+00	2018-07-28 19:42:29.865188+00	190.00	2018-07-28 19:42:29.865273+00	117
684	2018-07-28 19:43:20.508424+00	2018-07-28 19:43:20.508484+00	5.00	2018-07-28 19:43:20.508627+00	322
685	2018-07-28 19:43:34.823459+00	2018-07-28 19:43:34.823749+00	10.00	2018-07-28 19:43:34.824276+00	333
686	2018-07-28 19:43:49.543579+00	2018-07-28 19:43:49.543635+00	15.00	2018-07-28 19:43:49.543766+00	238
687	2018-07-28 19:44:17.766723+00	2018-07-28 19:44:17.766785+00	1.00	2018-07-28 19:44:17.766912+00	260
688	2018-07-28 19:44:56.22856+00	2018-07-28 19:44:56.22863+00	5.00	2018-07-28 19:44:56.228767+00	80
689	2018-07-28 19:45:02.252593+00	2018-07-28 19:45:02.252663+00	2.00	2018-07-28 19:45:02.252807+00	182
690	2018-07-28 19:45:11.215985+00	2018-07-28 19:45:11.216045+00	150.00	2018-07-28 19:45:11.216184+00	296
691	2018-07-28 19:45:41.432139+00	2018-07-28 19:45:41.432198+00	2.00	2018-07-28 19:45:41.432332+00	274
692	2018-07-28 19:46:15.316242+00	2018-07-28 19:46:15.316304+00	1.00	2018-07-28 19:46:15.316576+00	223
693	2018-07-28 19:46:20.287155+00	2018-07-28 19:46:20.287225+00	100.00	2018-07-28 19:46:20.287368+00	20
694	2018-07-28 19:46:26.043997+00	2018-07-28 19:46:26.044059+00	7.00	2018-07-28 19:46:26.044191+00	183
695	2018-07-28 19:48:26.39979+00	2018-07-28 19:48:26.399846+00	2.00	2018-07-28 19:48:26.399979+00	223
696	2018-07-28 19:49:55.07615+00	2018-07-28 19:49:55.076279+00	475.00	2018-07-28 19:49:55.076621+00	39
697	2018-07-28 19:52:03.518419+00	2018-07-28 19:52:03.518457+00	3.00	2018-07-28 19:52:03.518543+00	310
699	2018-07-28 19:53:19.240692+00	2018-07-28 19:53:19.240754+00	2.00	2018-07-28 19:53:19.240969+00	323
700	2018-07-28 19:54:38.651381+00	2018-07-28 19:54:38.651441+00	2.00	2018-07-28 19:54:38.651578+00	126
701	2018-07-28 19:55:13.72486+00	2018-07-28 19:55:13.724918+00	2.00	2018-07-28 19:55:13.725045+00	126
702	2018-07-28 19:55:17.544021+00	2018-07-28 19:55:17.54408+00	70.00	2018-07-28 19:55:17.544217+00	273
703	2018-07-28 19:55:54.682873+00	2018-07-28 19:55:54.683993+00	2150.00	2018-07-28 19:55:54.685582+00	4
704	2018-07-28 19:56:10.394162+00	2018-07-28 19:56:10.39421+00	4.00	2018-07-28 19:56:10.394327+00	116
705	2018-07-28 19:56:15.513502+00	2018-07-28 19:56:15.513564+00	50.00	2018-07-28 19:56:15.513691+00	174
706	2018-07-28 19:56:30.055841+00	2018-07-28 19:56:30.055902+00	12.00	2018-07-28 19:56:30.056038+00	238
708	2018-07-28 19:57:13.135996+00	2018-07-28 19:57:13.136056+00	0.90	2018-07-28 19:57:13.136188+00	154
709	2018-07-28 19:58:27.847925+00	2018-07-28 19:58:27.847981+00	4.00	2018-07-28 19:58:27.848146+00	146
710	2018-07-28 19:59:29.358234+00	2018-07-28 19:59:29.358291+00	0.50	2018-07-28 19:59:29.358421+00	336
712	2018-07-28 20:01:17.409822+00	2018-07-28 20:01:44.328449+00	100.00	2018-07-28 20:01:17.410016+00	24
713	2018-07-28 20:01:52.86261+00	2018-07-28 20:01:52.862665+00	50.00	2018-07-28 20:01:52.862797+00	221
714	2018-07-28 20:02:05.813314+00	2018-07-28 20:02:05.813373+00	50.00	2018-07-28 20:02:05.813524+00	292
715	2018-07-28 20:02:08.44399+00	2018-07-28 20:02:08.444055+00	80.00	2018-07-28 20:02:08.444184+00	171
716	2018-07-28 20:02:14.873103+00	2018-07-28 20:02:14.873163+00	100.00	2018-07-28 20:02:14.87329+00	1
717	2018-07-28 20:02:36.693745+00	2018-07-28 20:02:36.693804+00	150.00	2018-07-28 20:02:36.693956+00	303
718	2018-07-28 20:03:21.084156+00	2018-07-28 20:03:21.084216+00	5.64	2018-07-28 20:03:21.084354+00	4
719	2018-07-28 20:03:39.983976+00	2018-07-28 20:03:39.984034+00	50.00	2018-07-28 20:03:39.984174+00	62
720	2018-07-28 20:03:53.244112+00	2018-07-28 20:03:53.244164+00	45.07	2018-07-28 20:03:53.244274+00	220
721	2018-07-28 20:05:02.604587+00	2018-07-28 20:05:02.604643+00	240.00	2018-07-28 20:05:02.60477+00	296
722	2018-07-28 20:05:03.96696+00	2018-07-28 20:05:03.967052+00	10.00	2018-07-28 20:05:03.967183+00	96
724	2018-07-28 20:05:56.617589+00	2018-07-28 20:05:56.617636+00	1.00	2018-07-28 20:05:56.61774+00	272
725	2018-07-28 20:06:06.291927+00	2018-07-28 20:06:06.291979+00	25.00	2018-07-28 20:06:06.292103+00	260
726	2018-07-28 20:08:05.179762+00	2018-07-28 20:08:05.179817+00	50.00	2018-07-28 20:08:05.17994+00	301
728	2018-07-28 20:08:36.675912+00	2018-07-28 20:08:36.675972+00	25.00	2018-07-28 20:08:36.676201+00	274
729	2018-07-28 20:08:39.257271+00	2018-07-28 20:08:39.257337+00	200.00	2018-07-28 20:08:39.258006+00	134
730	2018-07-28 20:09:15.928458+00	2018-07-28 20:09:15.928512+00	6.00	2018-07-28 20:09:15.928634+00	340
731	2018-07-28 20:09:45.727912+00	2018-07-28 20:09:45.727968+00	60.00	2018-07-28 20:09:45.728091+00	62
732	2018-07-28 20:09:50.990198+00	2018-07-28 20:09:50.990254+00	2.00	2018-07-28 20:09:50.990381+00	226
733	2018-07-28 20:10:35.299889+00	2018-07-28 20:10:35.299944+00	30.00	2018-07-28 20:10:35.300071+00	142
734	2018-07-28 20:11:05.481783+00	2018-07-28 20:11:05.481837+00	90.00	2018-07-28 20:11:05.482236+00	260
735	2018-07-28 20:11:38.425327+00	2018-07-28 20:11:38.425386+00	8.00	2018-07-28 20:11:38.425522+00	27
736	2018-07-28 20:12:09.434764+00	2018-07-28 20:12:09.434822+00	4.00	2018-07-28 20:12:09.434959+00	340
737	2018-07-28 20:13:06.906052+00	2018-07-28 20:13:06.906106+00	20.00	2018-07-28 20:13:06.906231+00	70
738	2018-07-28 20:13:12.316059+00	2018-07-28 20:13:12.316114+00	1400.00	2018-07-28 20:13:12.316282+00	290
739	2018-07-28 20:17:26.864657+00	2018-07-28 20:17:26.864711+00	150.00	2018-07-28 20:17:26.864843+00	83
740	2018-07-28 20:17:46.871329+00	2018-07-28 20:17:46.871387+00	110.00	2018-07-28 20:17:46.872412+00	149
741	2018-07-28 20:18:40.99418+00	2018-07-28 20:18:40.994295+00	2.00	2018-07-28 20:18:40.994429+00	98
742	2018-07-28 20:18:46.804329+00	2018-07-28 20:18:46.804385+00	55.00	2018-07-28 20:18:46.804507+00	132
743	2018-07-28 20:19:39.747825+00	2018-07-28 20:19:39.747885+00	55.00	2018-07-28 20:19:39.748016+00	355
744	2018-07-28 20:20:48.468088+00	2018-07-28 20:20:48.468142+00	1850.00	2018-07-28 20:20:48.468279+00	59
745	2018-07-28 20:22:00.437091+00	2018-07-28 20:22:00.437147+00	200.00	2018-07-28 20:22:00.437289+00	59
746	2018-07-28 20:23:36.017034+00	2018-07-28 20:23:36.017091+00	50.00	2018-07-28 20:23:36.017216+00	99
747	2018-07-28 20:24:07.864005+00	2018-07-28 20:24:07.864067+00	16.00	2018-07-28 20:24:07.864201+00	83
748	2018-07-28 20:24:35.94325+00	2018-07-28 20:24:35.943307+00	23.22	2018-07-28 20:24:35.943427+00	345
749	2018-07-28 20:24:36.076412+00	2018-07-28 20:24:36.076592+00	55.00	2018-07-28 20:24:36.076735+00	164
750	2018-07-28 20:26:06.172311+00	2018-07-28 20:26:06.172372+00	15.10	2018-07-28 20:26:06.172505+00	354
751	2018-07-28 20:26:16.402818+00	2018-07-28 20:26:16.402873+00	10.00	2018-07-28 20:26:16.403096+00	81
752	2018-07-28 20:26:35.232579+00	2018-07-28 20:26:35.232639+00	5.00	2018-07-28 20:26:35.232842+00	345
753	2018-07-28 20:26:35.36258+00	2018-07-28 20:26:35.362633+00	20.00	2018-07-28 20:26:35.367096+00	149
754	2018-07-28 20:26:41.04731+00	2018-07-28 20:26:41.047368+00	50.00	2018-07-28 20:26:41.047478+00	99
755	2018-07-28 20:27:36.210267+00	2018-07-28 20:27:36.210319+00	10.00	2018-07-28 20:27:36.210432+00	171
756	2018-07-28 20:29:04.178055+00	2018-07-28 20:29:04.178106+00	40.00	2018-07-28 20:29:04.17822+00	289
757	2018-07-28 20:29:22.200012+00	2018-07-28 20:29:22.20007+00	3.00	2018-07-28 20:29:22.200192+00	212
758	2018-07-28 20:29:53.556997+00	2018-07-28 20:29:53.557056+00	6.00	2018-07-28 20:29:53.557229+00	147
759	2018-07-28 20:30:34.801489+00	2018-07-28 20:30:34.801548+00	50.00	2018-07-28 20:30:34.801685+00	99
760	2018-07-28 20:31:00.568237+00	2018-07-28 20:31:00.568299+00	2.00	2018-07-28 20:31:00.568434+00	147
761	2018-07-28 20:31:24.977574+00	2018-07-28 20:31:24.97763+00	6.00	2018-07-28 20:31:24.977755+00	147
762	2018-07-28 20:32:29.458381+00	2018-07-28 20:32:29.458431+00	2.00	2018-07-28 20:32:29.458543+00	29
763	2018-07-28 20:32:50.282206+00	2018-07-28 20:32:50.282261+00	25.00	2018-07-28 20:32:50.282393+00	62
764	2018-07-28 20:32:57.173057+00	2018-07-28 20:32:57.173113+00	6.00	2018-07-28 20:32:57.173225+00	181
765	2018-07-28 20:33:28.601939+00	2018-07-28 20:33:28.601984+00	3.00	2018-07-28 20:33:28.6021+00	29
766	2018-07-28 20:33:38.141715+00	2018-07-28 20:33:38.141777+00	400.00	2018-07-28 20:33:38.141921+00	211
767	2018-07-28 20:33:49.675865+00	2018-07-28 20:33:49.675925+00	120.00	2018-07-28 20:33:49.676069+00	99
768	2018-07-28 20:34:56.417809+00	2018-07-28 20:34:56.417866+00	100.00	2018-07-28 20:34:56.418105+00	99
769	2018-07-28 20:35:13.866186+00	2018-07-28 20:35:13.866306+00	210.00	2018-07-28 20:35:13.866429+00	9
770	2018-07-28 20:36:20.310797+00	2018-07-28 20:36:20.310843+00	15.00	2018-07-28 20:36:20.310949+00	292
771	2018-07-28 20:37:26.463981+00	2018-07-28 20:37:26.464039+00	55.00	2018-07-28 20:37:26.464178+00	211
772	2018-07-28 20:37:27.648696+00	2018-07-28 20:37:27.648971+00	110.00	2018-07-28 20:37:27.649329+00	296
773	2018-07-28 20:37:59.583878+00	2018-07-28 20:37:59.583935+00	55.00	2018-07-28 20:37:59.584071+00	211
774	2018-07-28 20:38:15.21584+00	2018-07-28 20:38:15.215904+00	16.03	2018-07-28 20:38:15.216041+00	355
775	2018-07-28 20:40:37.566958+00	2018-07-28 20:40:37.567112+00	16.75	2018-07-28 20:40:37.567251+00	58
776	2018-07-28 20:47:39.704552+00	2018-07-28 20:47:39.704608+00	30.00	2018-07-28 20:47:39.704745+00	354
777	2018-07-28 20:49:38.831891+00	2018-07-28 20:49:38.831947+00	1200.00	2018-07-28 20:49:38.832073+00	99
778	2018-07-28 20:53:00.664+00	2018-07-28 20:53:00.664056+00	500.00	2018-07-28 20:53:00.66418+00	29
779	2018-07-28 20:53:25.247048+00	2018-07-28 20:53:25.24736+00	40.50	2018-07-28 20:53:25.247913+00	143
780	2018-07-28 20:54:16.664173+00	2018-07-28 20:54:16.664244+00	14.00	2018-07-28 20:54:16.66445+00	60
781	2018-07-28 20:54:44.185036+00	2018-07-28 20:54:44.185088+00	25.00	2018-07-28 20:54:44.185214+00	264
782	2018-07-28 21:03:59.659345+00	2018-07-28 21:03:59.6594+00	0.50	2018-07-28 21:03:59.659525+00	234
783	2018-07-28 21:26:35.792496+00	2018-07-28 21:26:35.792558+00	300.00	2018-07-28 21:26:35.792702+00	123
784	2018-07-28 21:26:42.315199+00	2018-07-28 21:26:42.315373+00	15.00	2018-07-28 21:26:42.315506+00	123
785	2018-07-28 21:57:48.209776+00	2018-07-28 21:57:48.209826+00	60.00	2018-07-28 21:57:48.209939+00	62
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.auth_group (id, name) FROM stdin;
1	checkout
2	auction_managers
3	account_managers
4	admins
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add priced item	7	add_priceditem
20	Can change priced item	7	change_priceditem
21	Can delete priced item	7	delete_priceditem
22	Can add auction item	8	add_auctionitem
23	Can change auction item	8	change_auctionitem
24	Can delete auction item	8	delete_auctionitem
25	Can add auction item image	9	add_auctionitemimage
26	Can change auction item image	9	change_auctionitemimage
27	Can delete auction item image	9	delete_auctionitemimage
28	Can add patron	10	add_patron
29	Can change patron	10	change_patron
30	Can delete patron	10	delete_patron
31	Can add payment	11	add_payment
32	Can change payment	11	change_payment
33	Can delete payment	11	delete_payment
34	Can add fee	12	add_fee
35	Can change fee	12	change_fee
36	Can delete fee	12	delete_fee
37	Can add purchase	13	add_purchase
38	Can change purchase	13	change_purchase
39	Can delete purchase	13	delete_purchase
40	Can add booth	14	add_booth
41	Can change booth	14	change_booth
42	Can delete booth	14	delete_booth
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$100000$uRbBWKKnOErP$+6vA4rJpKmPiluC6hL3AD4oivMjD/XopDzgorOhfZ9M=	\N	f	food	Food	Court	food@example.com	t	t	2018-07-28 04:00:31.490647+00
8	pbkdf2_sha256$100000$6Apetvj7Pvxi$k/wyijj58Y/WH9iMN+0FsyX3ZHk7o4hQy2W0GGGMmbw=	\N	f	bidding	Bidding		bidding@example.com	t	t	2018-07-28 04:00:31.570589+00
7	pbkdf2_sha256$100000$kpx2Lq9m3S3G$ZgpgIC8cKrL7vTDRjivi9ZORjpyEH/s/myQFRLnHM/0=	2018-07-28 13:02:44.021969+00	f	auction	Auction		auction@example.com	t	t	2018-07-28 04:00:31.556701+00
1	pbkdf2_sha256$100000$STSMwMsr1DCi$+EjKO6hNafP35Ztt5dPKQIyc7fTPxisqF/Z+pUTDzNw=	2018-07-28 13:48:45.884099+00	f	baked	Baked	Goods	baked@example.com	t	t	2018-07-28 04:00:31.467322+00
9	pbkdf2_sha256$100000$qFGzgW49YRqB$a5J+30g8LOOW5R9ohO93t0RoHy1xTD5gB/3qs48b1qw=	2018-07-28 13:55:57.380426+00	f	accounts	Accounts		accounts@example.com	t	t	2018-07-28 04:00:31.588389+00
3	pbkdf2_sha256$100000$F0uKt4I9RMqp$tkiWiW04jOSsEDvNftFmvNsNOOuYijIFMRiIagl9Nzw=	2018-07-28 13:56:14.669879+00	f	crafts	Crafts		crafts@example.com	t	t	2018-07-28 04:00:31.515224+00
5	pbkdf2_sha256$100000$6Li26pGTyDgv$wFQ61rJaJ3NRefTuT1A42BLE2uL+Dav06DsZ22R2t6Q=	2018-07-28 14:01:41.380276+00	f	etc	Etc		etc@example.com	t	t	2018-07-28 04:00:31.540685+00
4	pbkdf2_sha256$100000$MWmiEmAZOYLA$E341ILo2TPZwIO+CtwVdX7wecBNa7fAv9e6YpTfxjUM=	2018-07-28 14:03:22.419439+00	f	produce	Produce		produce@example.com	t	t	2018-07-28 04:00:31.527843+00
6	pbkdf2_sha256$100000$Wxloy3zj8Gzs$8TaiJeCI+WFu38Umdw8p1aH6oVNMo37CJI/kcXA/MoU=	2018-07-28 17:58:24.475375+00	f	tickets	Tickets		tickets@example.com	t	t	2018-07-28 04:00:31.548893+00
10	pbkdf2_sha256$100000$DPOXZgeQCwcm$gUTEaxgEisY9ptU9QdErMlAgHBnP2c01Ys3F/KE5TJc=	2018-07-28 21:54:35.170064+00	t	portman	Paul	Ortman	paul.ortman@gmail.com	t	t	2018-07-28 04:00:31.781733+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
23	1	1
24	2	1
25	3	1
26	4	1
27	5	1
28	6	1
29	7	2
30	8	2
31	9	3
32	10	1
33	10	2
34	10	3
35	10	4
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	auction	priceditem
8	auction	auctionitem
9	auction	auctionitemimage
10	auction	patron
11	auction	payment
12	auction	fee
13	auction	purchase
14	auction	booth
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-04-24 18:05:18.948476+00
2	auth	0001_initial	2018-04-24 18:05:19.258091+00
3	admin	0001_initial	2018-04-24 18:05:19.329272+00
4	admin	0002_logentry_remove_auto_add	2018-04-24 18:05:19.355871+00
5	auction	0001_initial	2018-04-24 18:05:19.714594+00
6	contenttypes	0002_remove_content_type_name	2018-04-24 18:05:19.817518+00
7	auth	0002_alter_permission_name_max_length	2018-04-24 18:05:19.85243+00
8	auth	0003_alter_user_email_max_length	2018-04-24 18:05:19.905017+00
9	auth	0004_alter_user_username_opts	2018-04-24 18:05:19.934266+00
10	auth	0005_alter_user_last_login_null	2018-04-24 18:05:19.972985+00
11	auth	0006_require_contenttypes_0002	2018-04-24 18:05:19.9804+00
12	auth	0007_alter_validators_add_error_messages	2018-04-24 18:05:20.007789+00
13	auth	0008_alter_user_username_max_length	2018-04-24 18:05:20.279813+00
14	auth	0009_alter_user_last_name_max_length	2018-04-24 18:05:20.477587+00
15	sessions	0001_initial	2018-04-24 18:05:20.521735+00
16	auction	0002_auto_20180424_2004	2018-04-24 20:12:51.433927+00
17	auction	0003_auto_20180608_1514	2018-06-27 04:43:09.645706+00
18	auction	0004_auto_20180625_0413	2018-06-27 04:43:09.678498+00
19	auction	0005_auctionitem_category	2018-07-01 03:37:42.349766+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: ysoautxkgdqrjc
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
xy9jm1uuv7chptn29dpbf53wo4uj45zd	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:00:03.488527+00
rrvzku90n2dfhz3xuvvdlfpa8wuweivd	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:04:01.953494+00
o877p0wtyw19uef9s1qmez8vtqzqjfsc	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:08:03.134615+00
bk3u8zlulc0qbekizxldip3dfmehswwd	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:12:01.819178+00
i3r2fypqo84cy1pxha2hyz0x5rf64upk	ZDlmNTZiMGJiNjRkYmNlMzA0MTZjY2RlMDc4ODI2NTUxN2YzNDI0Mjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvTG9zX0FuZ2VsZXMifQ==	2018-08-11 04:40:01.807473+00
ahrj6demej7g2ogujhdc41t43q7tfryx	ZDlmNTZiMGJiNjRkYmNlMzA0MTZjY2RlMDc4ODI2NTUxN2YzNDI0Mjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvTG9zX0FuZ2VsZXMifQ==	2018-08-11 04:40:01.807625+00
9umxkpc3ph6io1099g7kw5bd8eerchp2	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:40:02.036582+00
5ccih5fzamxs6abp07g80nn8tpnu4tmz	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:44:01.499182+00
t4tjjq4bzd5nen6zvn3ciphw7lyy7mex	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:48:01.933065+00
ilossaawr7s808uariogv7y5tzmtc1h5	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:52:02.51809+00
2mg1ki4ixtyuuo8gsd0gib0y9h4jd68z	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:56:01.974301+00
v995yo70z2yc217xam3wd5f2zvqzwrd4	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:00:02.36654+00
g34mgc2h2fodeh8ca6tx70lwp8nuiidt	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:04:02.05694+00
gqgophvccskafy8pdcpq6m151qphshkh	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:08:01.461565+00
rq17xx5hktaqwhz7jldkl0yanep7lwkt	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:12:01.916207+00
9qg6xkl92bkoe4xj0dgbjserv1cc3ug1	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:16:02.857373+00
0eu1y28ktlqp949sezr04u5lkjc9yslp	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:08:02.193577+00
q1u6tay1io9d5xvkvijtrzhtodfq9exy	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:16:01.915397+00
5zey2olzdzv7f230f8tdzxha1ndn41v3	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:20:02.282092+00
sv3cr6jkjyf3z2zmh7unbmbbxjjavax8	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:44:02.052036+00
orfb3fy13lwvl6s3qv1afruj0h0ygfzr	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:48:01.512283+00
vdfbkogz37n00org6aywotxio3n9rlvf	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:36:02.152435+00
zzq11wlmedbjva3dlg2qz93bjcql5qnu	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:40:01.64801+00
8vntr6qvaob70pd69bdn8mng6lhbnydm	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:20:02.310685+00
z7gfp5ot5e1kn6hmnv2biuwh8158m3g0	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:52:01.873878+00
0ahs0jcfdk57i9ssokpgj1jx46k8f7ki	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:00:02.247541+00
989x2i40bdgoc8skpux2rjvq8o2e432g	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:16:02.764243+00
iu5tw6adrf8oi9zu6s6556o0qzbnh3p0	OGM4ZDIxOWQ0ZjdjZWE1OGJlNDJlZjE0OTRiYzZlYzIxZDhlODViOTp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjBiMzBmMjdkYmFjNGU1YWMyOGQzNWM4NWVkMmQxZmViMGUxODIwZiIsInB1cmNoYXNlX2Zvcm1zIjpbeyJwcmljZSI6IjEwLjAwIiwicXVhbnRpdHkiOjF9LHsicHJpY2UiOiIxMC4wMCIsInF1YW50aXR5IjoxfV0sInB1cmNoYXNlX3RvdGFsIjoiMjAuMDAifQ==	2018-08-11 05:21:56.024316+00
h2zx9xqerpcev981p58vqhjf6ukdz1z8	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:24:01.684251+00
n7ynoue36p3uq8hltdeoq0louozvkuq1	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:28:02.376104+00
0t9wuslb2x8f83dnwtkx1c1uxdmw38pc	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:32:01.882759+00
zggwiyy3xs6vuftw2wj600iypblk41dq	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:36:03.3968+00
h11ixtn85j5vs9pcgnuz5zn25dg3liuk	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:40:01.783363+00
diquyuhaa0kccw7l8hm1p25erzlnlibc	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:44:02.250703+00
f28ed538u97lef6hvvh84zbk9o55x6o2	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:20:02.106631+00
qtmk1a11neypd4y4j2gyo09av9wy08i8	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:22:13.543439+00
3e4zrq39fmnum2663v6vz2wx2nxrnhkb	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:24:01.569995+00
pm2dirlcl43ebqv4qab3rix6a0r409rg	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:28:01.977092+00
77d4l2ozyti1an61jrfcjx65ti1pbw4s	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:32:02.649356+00
ze3sq27e0qk0g28au7tiqd3ggtufjaef	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:32:12.171179+00
p6phaku9uqpb7l134obg8klga71brd7s	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:48:01.856738+00
e8vl8zj4u97m0kancy48rgl43rydjjdo	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 04:36:03.582144+00
o4tv6fa2kzf74o31p2r9w0nrdn81n5ew	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:52:02.321579+00
mesecucii050do1t76l2nq600h5k9u3a	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 05:56:01.701558+00
dmw1u8qgh9s4xr2sj041cc9qsfrrqnb5	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:00:02.149022+00
i8sscukys40hdvg1kkaf7vmkgjh18vm4	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:04:01.55624+00
y6le2x7kxpv2c4tbjvo8i3o6ukxy5kcd	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:08:02.008885+00
3sllumyfvnjwskgmmcoshg2zq26b2yyw	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:12:01.623643+00
4nvd9tmt4zhjf9qu5ng9ln3r05ecuioo	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:16:02.10464+00
b1gr78x3zskoz5poee7kpnwqe3q7x3df	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:20:01.528995+00
577zjvebl19lc3kheegwd6926qzs6j7g	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:24:02.006101+00
n0ejepaahytpqx6n86613c38wl5t2jym	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:28:01.408025+00
7g2z5ea7xo3dqusk85swrxykzjwcq5qn	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:32:02.086127+00
gyef58fdaczyol0m8kaw369n3b7yepb1	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:36:01.692398+00
n09xghburjtw5cocwst7grd0twhc1qct	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:40:02.154493+00
m2bpl4youlws44jh01qg812w0wg85w93	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:44:01.549756+00
ioxqlgp94w6pxdd5snszove8v3u0r5fd	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:48:02.243601+00
acagogvse4mzb3morcpwvruii1wxmm8j	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:52:01.639858+00
h8808o3czelawjtpxhpl2gbnc0r2bgsz	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 06:56:02.092935+00
ya2z5m8hp1fns75v2m4w521exuqnwqpu	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:00:01.5139+00
s2u8u8prd4q74juwzrk7knoxvq3yts12	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:04:01.968221+00
3avq31eduz7kpqf6qnzj7xl5u919beqm	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:08:01.373673+00
3oku07t4vww1333mcsmvqjbvjtzxax2j	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:12:01.830681+00
i7sjt9be163bb20t9gowodbvu9xvilr3	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:16:02.219167+00
fw0o6isvlp0tkwlwfkdy6xhzv1opolp7	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:20:01.682725+00
4v2rpdfddqg3o0oiipyadcz2aq58rmva	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:24:02.347489+00
uuoig87f0cc84oc6t747etu11gjoo5gi	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:28:01.919772+00
2sobk6fct00e136xaqq06fkuu5b87oyd	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:32:02.322655+00
im5wtunr2muhg1oun9859tsj7ao0020l	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:36:01.771645+00
uonocyvsii6rogi8qryq610syw4lbzoj	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:40:02.174976+00
7v84e6k8x7g8upnb41qv55nyocy1b3hu	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:44:01.61953+00
1k5fin3gw01ro6ir4xw718qtqavj1me0	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:48:02.013239+00
fmtkp2yubh7la5xzni9l7b4tesux9tr3	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:52:01.473258+00
yfh1311yeruv2otj7jm77lkld20849w3	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 07:56:01.863435+00
wsu2we3nzl92zo1jitv15t3djy1z8ttf	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:00:02.891737+00
3angnwzzopui0gqx5ootyrw5vikevent	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:04:02.295291+00
zkp8p83udpz08lnqsysns3m8ndjxctjw	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:08:01.749607+00
iccj7c78jkeymqi140ju7tpxjkf3j6g0	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:12:02.132856+00
xor440w7lsjhsfgjx7qyqsnkrrkyf71d	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:16:01.83243+00
jq4xbtqyqtv37nyiawh36wlijlfqws6n	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:20:02.244732+00
ynjwd67pc5ef9pb2av8yn4qxnin12ltf	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:24:01.71156+00
zaz0hs3d8lekn2et3qpvug8ic0z0aa1h	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:28:02.12791+00
s31l0172j2c3lec78pugn9x1x8vnr8cn	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:32:01.595411+00
mxgiw1w2a5q1g9k4z1ujeg6rytindkuy	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:36:02.003307+00
q1nixtc1ml7jgkk4vh8535wnfq8u1z70	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:40:01.431314+00
scdcvqohdzbwu4kc2pf28v35d9u039pc	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:44:01.852264+00
qdd4vgpj5sqclfuwgknjx07bdd6ibuf4	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:48:02.299758+00
d5s6iy186vyg5i3aceu036j9zefud0ep	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:52:01.750348+00
q61upqlwin15aluqf53cdpdzve2v7bl7	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 08:56:02.204165+00
fmh235hdt3zqs2ifwevjclhxv77pb996	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:00:01.697239+00
xeuyu8hgiaer4bxbzpycyhsm8nncmbsj	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:04:02.177492+00
128mnfzk1j9gudpuk4r4gywvmv7bbu9z	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:08:01.554709+00
gbpktd8p6q5bdztxhd2oun1ssanokev7	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:12:02.001215+00
32jwt7kmcos35s1ym9qbkjrevmjeszuw	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:16:01.409236+00
17olotjx4x698ikav7e0sp8gaaqk1pmd	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:20:01.895046+00
n1dsuu0qhmxi50uae7d2ha4wgc28gzux	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:24:02.282975+00
hjrlu0hia2j2n74q22ij2w8xw610k88y	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:28:01.757165+00
1jqnxlync4rqn20h44mj711ut5cabwfx	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:32:02.141938+00
y948vsqnvt1b4q2nw8xx3iqyemi9z2lw	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:36:01.809767+00
o7ii5mq0xqsohddmhzt8qxa4plgq1i7m	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:40:02.21001+00
aukuus97aefgglx9vhm0yum8gkzrgqcx	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:44:01.8852+00
ydn5ng9ojudutlpg7aamol6li3bt9aq1	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:48:02.296815+00
i29golr1dss1wq6seozamvhiof0qlxhl	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:52:01.748266+00
2jfwk19bbaxs0ydf7h21votqeu1cotcz	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 09:56:02.116018+00
s93u939a2utf7n6ebp6df6dltxmzwp1e	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:00:01.610191+00
kjwsf9me4q33wf1x8by16phmqou8bq7u	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:04:02.028042+00
g71pcvnc0oocd4wzkhuuvec7anl44qa8	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:08:01.480685+00
2xdtv4e4b5txj7zpt0tsu068ao32a9ie	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:12:01.872579+00
x1msvh4ctn40571iwdqsn0sojmlq9d4k	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:16:02.335938+00
p4oqi772z83cimwktqcw69mkd1osvgjp	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:20:01.725616+00
yzeec41oo20l0il7ze5crarbdw49vwew	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:24:02.157719+00
km3crr8elw5mk3hurmgndfdgoiwo1vk9	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:28:01.538982+00
z03f4s63tgguyfpg56a4wtcmk6vinrj0	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:32:02.015658+00
tqcg0xjxmdmeci6lw45yqsmw53dkczsq	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:36:01.423052+00
n14stpocknvslax983js8v9hv6mph3xn	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:40:01.894423+00
hl6e4rba6panrifhs50eq4h5bwgsdm23	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:44:02.305997+00
9ncdv98ttlzxj0a6gtt46pczhg3f5fwt	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:48:01.771976+00
c6ev5leb3p2uvs7ap6t2721f174z62qd	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:52:02.171648+00
mtxl4uke1lslxskevyaxkoopo0zbwn1u	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 10:56:01.621616+00
8mncoe7elgrh0eb0lorhgzjt012qcm39	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:00:02.013721+00
cdh80zkyskwqv4u94ad1k2rc4c94d16h	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:04:01.481245+00
l8xm2afhh63js3nfpbrxh16tdyv7f6io	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:08:01.863335+00
7xv5rasfoafv7neizgdgjxqw46qgmstp	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:12:02.354462+00
l6yalcd3jldvjbkhakh1gs7ftau5a2lp	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:16:01.768567+00
dr12vowwu7z9j9cmvedstk14frb7dx6g	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:20:02.293415+00
jj223oohfw8bt1mdb0089b3dfozvzqbt	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:24:01.693861+00
6olgqkc5khrftxmp61j1jy4w3rrno8gq	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:28:02.173376+00
rk2sclmefhcd5fvb8fsv36xxyir5g8aw	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:32:01.558332+00
42gku36voogfl4i5sup8r8449zlscnvp	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:36:02.029314+00
ojnb81nxvqc6fprymddwyew0cv55rjrv	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:40:01.440371+00
r4vcr9iueh4jkr0o5tud3686pr7hbo2e	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:44:02.128015+00
8acqvrpmte0ejwu7a1scvqmxtgoe574u	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:48:01.521384+00
8vc72ne5s6gqdpc7hc72ewpq25y3fj02	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:52:02.026711+00
de4uaj94f378suhtwx4rpq6mxb8i862q	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 11:56:01.428751+00
n0quvw7kaywsbar8g17944dtepelr6my	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:00:01.908859+00
wqotzcx51qjm7afzpn19mkeygex3k11y	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:04:02.34636+00
9zt07smuzfv0xrutf9z1zim7jdbbryr6	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:08:01.806132+00
2n9nrqeme866twzboa9fprbkiuojlthy	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:12:02.272962+00
b7sbtluxltae62ehr1fbaocu6d1uhet9	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:16:01.690636+00
gk3uua45xd2s9pk4imxxpgfurzu42qp2	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:20:02.128201+00
2dxwr39h9z0bf0szfp9e7zpm9no5ur2p	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:24:01.601849+00
nf4u0h4e10aoef4i5jfnwa7hx84on712	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:28:02.048211+00
kllbu2de0tt03vjnxmpp2dktj2kkheuw	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:32:01.559887+00
nltglwxqd7igj7y04hta05pkb0f0crkh	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:36:01.959314+00
8kzv61ufj35edki5ifsxnsbbj14fh1sn	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:40:01.419223+00
oz7jcbnp6iwpdrlib5itwtcpi0dpi4dr	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:44:01.823544+00
qlxldel40bt2phrk178ed9k6we3qblyn	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:48:02.278162+00
f13udmlslghb1wsdng8rt2j9zbt520u5	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:52:01.675869+00
b400ms97dudh71so0hqcax0t9yamh7xb	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:48:02.024352+00
gqrkerzq2b96dwmd7yg4lcdfh45fj65g	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:08:02.213498+00
mrtya39y5phudpxzvk47l95ikim5tbwe	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:12:01.77367+00
4su5kx7eytzj3z3v2c5cpp02vo6gv7bp	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 12:56:02.020724+00
e4ozk1t55jdznm5b5zuxovb1nm6h4cgx	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:04:02.113323+00
i2psq7fkm89cruuh4uxsl364w3otik4n	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:16:02.151936+00
uefq1hfleg6xqua1hpfcn2f9jhp9u612	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:44:01.903365+00
e2jnga53bauycqt3busnrerbivvuvs3i	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:48:02.29217+00
k8w5stipftf4xkgaicik84gft2kdgjhi	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:56:01.795961+00
p1kbde2ubdeka5o1ify631zg7bbe9jnf	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:04:02.043423+00
67gnujb196d9gts7shj6vigikfy2tu8a	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:44:02.019574+00
yzhok1p6wxq0v3i9kydjiu14h00ebzrd	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:08:01.455386+00
st3ydvbeqhcc19tvwaspbx333lx268s6	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:00:01.403921+00
o23l4as57f3miecs86hp86ayt3csihwt	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:56:02.279643+00
1glqsysy0wo10so7vjlw7fvtk4vus5wb	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:20:01.576941+00
j8c0i6bwgoionszlmrwo2dq7j6o0pv1o	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:24:01.652065+00
xmpulhrvqk8jjqee2autf3pg38w0h5b4	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:28:02.065691+00
yvslduzfp56z8wd0irjnr7ysao1a2ah7	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:32:06.94347+00
isl49wp0gell9ptfevs0i5pvewr416ei	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:04:01.742964+00
jb9yyqynq7i69m9t5enw0x0fszah46td	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:12:01.797152+00
nbb8w1prv3nbmli76nt34wyou8k1goul	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:16:02.141166+00
7hqcwirwk26dmal73394car52pxiz5u7	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:32:01.724771+00
fuowiy5zgylzgij38qwh81yjx6231qs4	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:12:01.513916+00
xogxewtgmxyazehgyyewuzgrqiqqnosj	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:51:33.005563+00
xve54dnndl780xw08b75delc21m0c1yk	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:40:01.705204+00
4ev1pue3qzlpew5cu8f6x9mrkfnbk8hd	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:36:02.345849+00
53ca3qolbrklmrizwurxgex6w3hhavam	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:40:01.507473+00
zanuuxmneisjw0ojf82qqthc07mttoaq	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:52:01.714824+00
wleeuxayk16fwfsvf4f5ustv9czt4y0l	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:56:02.075348+00
xfs85kiawq1exei8goy9r74motkac1vb	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:00:01.470126+00
uwwr4cfrumv9841cd1yau0o0yum4zg7k	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:04:01.830379+00
hqdpxju5ormv3wwauyyz8cbru8kkx0v9	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:08:02.304089+00
wrfe29md8qtb5t2beexs0fsl2mcu7h3s	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:24:01.974304+00
hhqx2edooj8dlcsv37tw9vojlr92mtg0	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:16:02.071461+00
vhnth0kjvhxn66f10jm90bci090orv2k	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:52:01.88634+00
e6yfhi404jct6jxmj4d3ymr6lvogjgup	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:19:12.937384+00
bv8ipq1ai69x7b7qqu90io3nb86k4vq2	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:36:02.088014+00
64d77pw0jx9onfp4d22x96pyvl4c7x7k	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:28:01.53215+00
1nrulu4q8970129amdkbzsf4kig3kp8x	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:32:02.032286+00
py9mtmh9n8q759shicwf4tq5083dwrof	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:32:03.410742+00
39sgfqg7iff1k3fscr697dvr4y7gd102	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:40:01.793871+00
xrmmanyl2fzsznb0tarrv4tr9p1sx2x2	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:20:01.799327+00
3mpcls3c1ohcgr01w1695dre4zrvq5pr	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:24:02.152529+00
l9p3cb35tsf9yvwyvm6mbul8pwj351o7	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:00:01.609136+00
0aaktp6o1q44zx4c9000zrh4ex56ipqi	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:16:02.239338+00
ps4aohgx0t044g8rp080ah16i38h8j7w	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:08:01.364342+00
c13v9emn52zkx9ej5driis8dah394n3s	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:00:01.671581+00
kqvtx6681o8ic2ivjjt0eglajlqnftcc	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:12:01.822074+00
wdvc9ypgjh9nhojg6i2xt4oac34cj1l8	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:04:01.837128+00
ohmhmivt3qu2pww1gskx0w5hnmqs3usy	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:44:01.674025+00
1456z2sqi1b2xmrauqb59byao82yn87i	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 13:56:02.281336+00
kumsa5ftetzafo4w80kz1alfxr9i6zq3	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:24:02.159054+00
xmf49e2hh9ad1mysjgghw1u9hk3qu12w	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:20:01.519333+00
x1mae8k9273nqsp1b3yekh5spgcwb6vp	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:24:02.067109+00
30qcwicxcnv64ylvk2ca709klfkhuixu	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:28:02.339686+00
z8i1yvvfthc6qg7gdevrf52m0pf45z6q	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:32:01.721846+00
smu87kt51kecqva92mgbmygqyayt4w0j	NmExZDg1ZTEzNDIzMDRlMjcwMTBjNWU4YzY1ZGUwN2I2NTBkYWE1MTp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjlhNmVjY2FmODZmYmQxOGUyMmI4N2UyZTJmODlmYzIzNWFkODI0IiwicHVyY2hhc2VfZm9ybXMiOlt7InByaWNlIjoiNS4wMCIsInF1YW50aXR5IjoxfV0sInB1cmNoYXNlX3RvdGFsIjoiNS4wMCJ9	2018-08-11 14:28:23.214011+00
d7upecm80p8j4z7iimymx1aohptm7vdv	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:28:01.483077+00
xvyc5cjh1ky0zcqnt7h4jjas0wglm2go	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 16:28:01.362178+00
wls9b5nfg0bqzkhwx2frvc10fqtqu9if	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:40:02.248222+00
lkochtzz6ctl5cpwmeuxcbnblx86amvq	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:36:01.835463+00
sc213s0sa5x7oiq5jb0rz62ndkn3mtag	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:08:01.454045+00
jo781gmjevg5jz0tvh569zi8lx8t59p2	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:48:01.445509+00
sjg57u9qddg2tdvqervep5c4p0qpe3lq	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:20:01.674921+00
vfc7u0bfruqg58negzhxhm2c8vecfub5	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 14:24:01.927338+00
t71lej9sjodx1xh5pb4m8olk7494zjk5	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:00:01.680501+00
gkp23zfiqe44h1uk1crs8hvivwvn9ih0	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:48:01.667823+00
idcxui34r3112ayo154iihbikohwn4uu	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:08:01.707493+00
301k9gda665zmd9kojvps7doxg2978mb	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:48:01.475777+00
nharweqlt8bcrw8lw1voe88bhw5ux7tq	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:24:01.881111+00
hwarrxe3707duc5n05owskt377yq4l23	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:32:01.633787+00
3nrpwv3uczhvbtz3jqlgjcf385bxn9pw	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:36:01.97475+00
0wvnhse0vnmjeo6f8krktpetwotelz4u	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:40:01.347804+00
c4erzo5e5v5s3u7iu66xv1wnfr6gjgzq	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:16:02.071315+00
c8qospgfl6uck53x3xubq6z1nt18xtpi	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:24:02.256397+00
yw5vb141ti8cj0x73j8jkgxw7iit3kyg	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:12:01.718789+00
pysd157jiwa3p4et6ymnfxffy9t5xemu	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:08:01.529644+00
i8bqvyvpa4yi5og4hgwzwi7pbwoxer0z	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:40:01.767306+00
ytyaw30i8vdnaxu7d1ak3ohfw0eqw60c	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:28:01.515299+00
9t1lym6zg7ab3s7avgly3oshll4u3qzx	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:52:01.959925+00
efml95nb70szfa1o2ylgrabg6w05s6rt	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:36:01.403436+00
a9in9gzgy167ht9fq24pjl5vboj2223k	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:40:01.879438+00
8e74aur652ookro7q0t8jux17kxsywxf	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:16:01.503336+00
uijddvhtb8b5p0iwgam7ho0lhw9wlsoc	ZWVhODE1YzM1YjUxZDAzMzQxYWNkNGM4OTU1NzczMGJhODI0YmZjYzp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjlhNmVjY2FmODZmYmQxOGUyMmI4N2UyZTJmODlmYzIzNWFkODI0In0=	2018-08-11 19:27:41.494997+00
aamms91boo22xkaqlfdi2spqplywwoc5	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 15:52:01.414254+00
qknpw5i09nvohmryhx93xdl4cak6mkr8	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:12:01.707543+00
x3xaabhfzhcwee7ls7d6xbo323j3nl4l	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:12:01.967397+00
rmdczh5a6rd483wjqe7n66m0xmo5abeb	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:32:02.043473+00
prieh16zzk2l1lm0m50p6kohwxd43jv9	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:00:01.763738+00
2xb6vyqqg387t1s4x8uavwc3cvkpcjty	NTYxY2VlYmE3YzY3MzhmMGM1NDViNzdiNzZlNmVjMjY5YTMyOGU3NTp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmMjY4Yzg3MWYyZjZmY2I3ZjA3MWVkN2MzYzcwYzUwYWZiYjY0NDg4In0=	2018-08-11 18:14:23.708464+00
d6c64e8b3gnj3v60g58o0g3h65r49c3k	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:36:01.406702+00
62ej8acwc39u8wxr0r0prsmfmd3cd1aa	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:36:01.472075+00
vx5mx31sbizhtw0ti8zics9bf96u7zat	NDdkMTM4MjAyNGRlYTQ2YzAzYTNkZTkwMzA5NjIwZmFjOGYwYjU3ODp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkZTYwNDRiM2ZkZmI2MzhlYzU2YTY3MzViN2MwZjRlODhjYmI4Zjk4In0=	2018-08-11 17:12:50.573512+00
i67xdeubrzgzpeqhnam0qg7w0sndwo1b	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:48:01.57542+00
0koq0zpjh9h19fsbay7p7n2q992dlqo4	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:44:02.233555+00
px5hlazkfwofzf7gp9xefxtbg9jek82o	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:02:26.316817+00
84l3gtn893krdkua7iqa48678g0kfzdl	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:44:02.211436+00
e0gb9gzwuhm3qfx7lrhwlgcr55apbfj2	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:56:01.372093+00
il29kttnwtx2ppeo865u1rizkq9a2i1c	NDdkMTM4MjAyNGRlYTQ2YzAzYTNkZTkwMzA5NjIwZmFjOGYwYjU3ODp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkZTYwNDRiM2ZkZmI2MzhlYzU2YTY3MzViN2MwZjRlODhjYmI4Zjk4In0=	2018-08-11 17:56:06.413159+00
a3wl2oci0lmrifyefq0hk2n25zedzpi7	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:04:02.148152+00
wf4gdrn7qgo3wvba8mobg33cf0txke9z	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 17:20:01.731132+00
yt6zb55w2fznywbc5fghfd16y2uastu0	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 21:12:01.585167+00
3hz8bd1ghtzhs7587di5248me292afzp	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 02:32:16.782028+00
enb0vkz2vijxbnxghflqm8tuzuv43au1	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 02:36:02.062005+00
f1nbpxa5p0viouvnjezspuo6ef39n1ck	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 21:20:01.427263+00
rv4rpb37rfg2hnc77n10f2fwu9txzu14	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:56:01.976608+00
w3kchfwqglfq4cg2kfzzznfvwj1uc6hh	NDdkMTM4MjAyNGRlYTQ2YzAzYTNkZTkwMzA5NjIwZmFjOGYwYjU3ODp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkZTYwNDRiM2ZkZmI2MzhlYzU2YTY3MzViN2MwZjRlODhjYmI4Zjk4In0=	2018-08-11 18:30:15.90405+00
uzjzdt1grnqritczzd5f1w0adfemm7yy	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:32:02.020406+00
j2h3m8nnlnc3iohbp8mp9npkng1drqs6	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:00:01.834941+00
yme2fel6pbboi5a6ve07m0qxcqp1yidy	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:52:02.0839+00
m7wepy98mfesu646j1u6hky47qdryamq	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:04:01.996962+00
wn0duo64c553wv9u2nckqywjdlvgcd7n	MTgwOTM5NGI4NzZlYmY4ODgzYmE3ZDc2MTJlODNiZTBhNThmMDNlMjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiI5IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYzdkMjRhYmViZWI2NzJhYjU2OGI3NDk3YTlmNmM5Yzk1ODcxZjZlIn0=	2018-08-11 21:44:58.386695+00
8dydbjrv809boe0uwnfk0r0oe7ugb7od	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:16:01.394987+00
h2twz1hkcw9saqwh199dihmk3trrr91u	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:52:01.846894+00
24g4tkloi7c6ug1xxln16txrggr81jf0	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:04:02.248536+00
m868j7fee7h74x2wvieshrppmucyfk0s	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 18:56:01.455571+00
uanqghsp3znf26yau3k53639iwac6dax	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:28:01.623196+00
58cldtxvmihif1xbvxua3s120s931tnw	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:20:01.878914+00
y65smynaqlziluooptiev7reedlm0h90	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:48:02.202536+00
r6bnohnf1y10ga05yn1o2fr5el8toutk	MDkwOTg3ZmUxZjk5MmVlZjcwY2Y4YTJiNWIyNDk0MWE5N2M3MTNlODp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjBiMzBmMjdkYmFjNGU1YWMyOGQzNWM4NWVkMmQxZmViMGUxODIwZiJ9	2018-08-11 20:26:16.872049+00
452hd0v1sbtcdi6y6d9yj9a0m6epyhgs	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:44:02.118132+00
uuc8vr0jhxrhwo8667t89u6mbzdd2eji	MmM3MTJmNzk4MDhhYWVkOGNhM2M2MDhhYzRhODNlNTQ1ZTMxNDRkOTp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyNGM3MjY5Y2M1MDdkZjk4NGJmNTEwY2EyNzRiZmVkMTRkN2ZjN2YwIn0=	2018-08-11 20:42:44.140708+00
xi50r8fqysul53mq7q0mp7vvtggo020k	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:20:01.508501+00
t08tfko9vj2wyplhacj501d140azk0h3	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 21:04:01.755895+00
58gwn4q522rcbly225z78dzy5r8alxhf	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:12:02.07936+00
6s4x2t4gdn3ngnptptcfp40krkdjlhul	MmU2Y2UwYTEyNDZlNDVmYjQ4NDc2ZjY1YjQwNjIxYzJmZWExMzlhYzp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjMzMzNzZlNzBmNzE2MTc2YWEyZThhMDczMTM5MDJmYmVhNDc1ZWI4In0=	2018-08-11 20:38:00.009152+00
muf6z9pirrb2bjvs5mgbvomui0lr9qpk	MTgwOTM5NGI4NzZlYmY4ODgzYmE3ZDc2MTJlODNiZTBhNThmMDNlMjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiI5IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYzdkMjRhYmViZWI2NzJhYjU2OGI3NDk3YTlmNmM5Yzk1ODcxZjZlIn0=	2018-08-11 21:08:54.694096+00
hhrzwptzmvp1i4k6flhngw8hsjgifooc	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:44:01.835274+00
bdgxcphuuvv7ssqg9m4ax2tfrf48mmh7	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:28:02.253038+00
6ap5sbmddkfkmal2eafch9vt4y6ojfbd	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 19:56:02.199961+00
4921cvoj75brbkk8pp9x1j8agbpbcett	NTYxY2VlYmE3YzY3MzhmMGM1NDViNzdiNzZlNmVjMjY5YTMyOGU3NTp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmMjY4Yzg3MWYyZjZmY2I3ZjA3MWVkN2MzYzcwYzUwYWZiYjY0NDg4In0=	2018-08-11 19:46:20.525613+00
3j5qtpw1hvtk0e038uw7c3umfab94ovr	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 20:52:01.604562+00
65mmxyxtkjb0tocxijs4c4dalax524m6	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 21:16:01.982375+00
y2upacqj60iisp8i6fatfnkilhqplwcz	NjM5MTUzZWQ3MjI5YmQ4NWI5MjQ2OTAzNTY4ODQ1OGE5Yjk1ODA1MDp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1MmFkYTVjMDU2ZGUyNWEwYzk5MmVjODMyMzEzYzI0NDg4ZTc3MmM2In0=	2018-08-11 20:53:25.508254+00
3lysbvv682m5faiosfphnhe15sap21zw	MDkwOTg3ZmUxZjk5MmVlZjcwY2Y4YTJiNWIyNDk0MWE5N2M3MTNlODp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjBiMzBmMjdkYmFjNGU1YWMyOGQzNWM4NWVkMmQxZmViMGUxODIwZiJ9	2018-08-11 21:58:16.45791+00
2cant9ai9f12pbu3r5q6qswwmcihuhvm	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 02:40:01.413692+00
yhc44dcowqps4zp4nnbfzm1sayk9bnqv	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 21:00:01.338838+00
d6j06ohf08v537scjr76ujt2knmwa7t6	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 02:44:01.825327+00
zzm35c8r6q0ddi5rg5xj65woboa7fsfo	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 02:48:03.353839+00
uaxfn2evtx5vwxuywewwg62b6sgi6yx1	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 02:52:01.545274+00
boqcw2voo149vifwmusciz2vsvvvjupl	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 02:56:01.920706+00
cyze3qawh59joh6mnkw7m8mq18blm301	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 03:00:02.46331+00
z8yjvwqpw3c16bd5d4iihrbg877t3ont	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 03:04:01.824541+00
moamxa8tc9gf28rahf8gpz2kg6bl3nx8	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 03:08:02.136974+00
1m7yuwdkfqfg85iyogc89m2e14t1gryz	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 03:12:01.475121+00
kebkftqfw75gj8nmsgtvas3fjzmh20t4	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 03:16:01.878907+00
swtso9vnmf8bmgqmhm5k3ygyvrxcmabk	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 03:20:02.304357+00
p8ftvbr7g5pk4f8eij6ifb9tp4ozig4t	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 21:24:01.843057+00
1cs2xhqm7okd6pdfa4ob16zs4prrgu9a	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 21:28:02.283491+00
y0xggnssjgop1h7psbklgx101ei9ds9k	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 21:08:02.115319+00
lkyuc56miqvtfbb3malj6x0p3hrvsphm	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 21:32:01.711522+00
44492bytt4tpi49qvtj0j8hjf0ehqx8t	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 21:36:02.145723+00
bbk4j9w4e0nijxllj3qxd4nqh0ncthkh	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 21:40:01.515175+00
a5gb100zgwy3q91uzewb6ne810bbt4um	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 21:44:01.999382+00
0ou613sx7vg17nr4xmwd5iosla9fyel8	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-11 21:48:01.416511+00
qz0b5lx3uksb8nboxkkjwfx0huw0afv2	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 03:24:01.584674+00
089ebmt8nhc73fhxeb4kv7x53jk7z3e3	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 03:28:02.024344+00
al1h0domqomuhch3qhvob9x47ass5ty6	MDkwOTg3ZmUxZjk5MmVlZjcwY2Y4YTJiNWIyNDk0MWE5N2M3MTNlODp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyIsIl9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjBiMzBmMjdkYmFjNGU1YWMyOGQzNWM4NWVkMmQxZmViMGUxODIwZiJ9	2018-08-12 03:31:10.184564+00
vktz5b65i2nsvp49hjg9xwqniqiqsbbw	MTk4MjFhZmJlZGM1YmYwM2M3NTFlNmMwMjY0MjU1MzA2YzIyNWIwZjp7ImRqYW5nb190aW1lem9uZSI6IkFtZXJpY2EvQ2hpY2FnbyJ9	2018-08-12 03:32:01.313218+00
\.


--
-- Name: auction_auctionitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.auction_auctionitem_id_seq', 111, true);


--
-- Name: auction_auctionitemimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.auction_auctionitemimage_id_seq', 1, false);


--
-- Name: auction_booth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.auction_booth_id_seq', 6, true);


--
-- Name: auction_fee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.auction_fee_id_seq', 50, true);


--
-- Name: auction_patron_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.auction_patron_id_seq', 362, true);


--
-- Name: auction_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.auction_payment_id_seq', 266, true);


--
-- Name: auction_priceditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.auction_priceditem_id_seq', 672, true);


--
-- Name: auction_purchase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.auction_purchase_id_seq', 785, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 4, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 42, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 35, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 10, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 14, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ysoautxkgdqrjc
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 19, true);


--
-- Name: auction_auctionitem auction_auctionitem_item_number_key; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_auctionitem
    ADD CONSTRAINT auction_auctionitem_item_number_key UNIQUE (item_number);


--
-- Name: auction_auctionitem auction_auctionitem_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_auctionitem
    ADD CONSTRAINT auction_auctionitem_pkey PRIMARY KEY (id);


--
-- Name: auction_auctionitem auction_auctionitem_purchase_id_key; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_auctionitem
    ADD CONSTRAINT auction_auctionitem_purchase_id_key UNIQUE (purchase_id);


--
-- Name: auction_auctionitemimage auction_auctionitemimage_item_id_sort_order_eab16643_uniq; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_auctionitemimage
    ADD CONSTRAINT auction_auctionitemimage_item_id_sort_order_eab16643_uniq UNIQUE (item_id, sort_order);


--
-- Name: auction_auctionitemimage auction_auctionitemimage_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_auctionitemimage
    ADD CONSTRAINT auction_auctionitemimage_pkey PRIMARY KEY (id);


--
-- Name: auction_booth auction_booth_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_booth
    ADD CONSTRAINT auction_booth_pkey PRIMARY KEY (id);


--
-- Name: auction_fee auction_fee_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_fee
    ADD CONSTRAINT auction_fee_pkey PRIMARY KEY (id);


--
-- Name: auction_patron auction_patron_buyer_num_key; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_patron
    ADD CONSTRAINT auction_patron_buyer_num_key UNIQUE (buyer_num);


--
-- Name: auction_patron auction_patron_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_patron
    ADD CONSTRAINT auction_patron_pkey PRIMARY KEY (id);


--
-- Name: auction_payment auction_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_payment
    ADD CONSTRAINT auction_payment_pkey PRIMARY KEY (id);


--
-- Name: auction_priceditem auction_priceditem_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_priceditem
    ADD CONSTRAINT auction_priceditem_pkey PRIMARY KEY (id);


--
-- Name: auction_priceditem auction_priceditem_purchase_id_key; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_priceditem
    ADD CONSTRAINT auction_priceditem_purchase_id_key UNIQUE (purchase_id);


--
-- Name: auction_purchase auction_purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_purchase
    ADD CONSTRAINT auction_purchase_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: auction_auctionitem_booth_id_588d4355; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auction_auctionitem_booth_id_588d4355 ON public.auction_auctionitem USING btree (booth_id);


--
-- Name: auction_auctionitem_donor_id_da2f5ac0; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auction_auctionitem_donor_id_da2f5ac0 ON public.auction_auctionitem USING btree (donor_id);


--
-- Name: auction_auctionitemimage_item_id_ba9ecbc7; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auction_auctionitemimage_item_id_ba9ecbc7 ON public.auction_auctionitemimage USING btree (item_id);


--
-- Name: auction_booth_slug_144623c4; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auction_booth_slug_144623c4 ON public.auction_booth USING btree (slug);


--
-- Name: auction_booth_slug_144623c4_like; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auction_booth_slug_144623c4_like ON public.auction_booth USING btree (slug varchar_pattern_ops);


--
-- Name: auction_fee_patron_id_89c432c7; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auction_fee_patron_id_89c432c7 ON public.auction_fee USING btree (patron_id);


--
-- Name: auction_patron_buyer_num_b637ff14_like; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auction_patron_buyer_num_b637ff14_like ON public.auction_patron USING btree (buyer_num varchar_pattern_ops);


--
-- Name: auction_payment_patron_id_df70aa1f; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auction_payment_patron_id_df70aa1f ON public.auction_payment USING btree (patron_id);


--
-- Name: auction_priceditem_booth_id_61ca6a9f; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auction_priceditem_booth_id_61ca6a9f ON public.auction_priceditem USING btree (booth_id);


--
-- Name: auction_purchase_patron_id_6e2e679e; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auction_purchase_patron_id_6e2e679e ON public.auction_purchase USING btree (patron_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: ysoautxkgdqrjc
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: auction_auctionitem auction_auctionitem_booth_id_588d4355_fk_auction_booth_id; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_auctionitem
    ADD CONSTRAINT auction_auctionitem_booth_id_588d4355_fk_auction_booth_id FOREIGN KEY (booth_id) REFERENCES public.auction_booth(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auction_auctionitem auction_auctionitem_donor_id_da2f5ac0_fk_auction_patron_id; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_auctionitem
    ADD CONSTRAINT auction_auctionitem_donor_id_da2f5ac0_fk_auction_patron_id FOREIGN KEY (donor_id) REFERENCES public.auction_patron(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auction_auctionitem auction_auctionitem_purchase_id_cf4d44b7_fk_auction_purchase_id; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_auctionitem
    ADD CONSTRAINT auction_auctionitem_purchase_id_cf4d44b7_fk_auction_purchase_id FOREIGN KEY (purchase_id) REFERENCES public.auction_purchase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auction_auctionitemimage auction_auctionitemi_item_id_ba9ecbc7_fk_auction_a; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_auctionitemimage
    ADD CONSTRAINT auction_auctionitemi_item_id_ba9ecbc7_fk_auction_a FOREIGN KEY (item_id) REFERENCES public.auction_auctionitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auction_fee auction_fee_patron_id_89c432c7_fk_auction_patron_id; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_fee
    ADD CONSTRAINT auction_fee_patron_id_89c432c7_fk_auction_patron_id FOREIGN KEY (patron_id) REFERENCES public.auction_patron(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auction_payment auction_payment_patron_id_df70aa1f_fk_auction_patron_id; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_payment
    ADD CONSTRAINT auction_payment_patron_id_df70aa1f_fk_auction_patron_id FOREIGN KEY (patron_id) REFERENCES public.auction_patron(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auction_priceditem auction_priceditem_booth_id_61ca6a9f_fk_auction_booth_id; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_priceditem
    ADD CONSTRAINT auction_priceditem_booth_id_61ca6a9f_fk_auction_booth_id FOREIGN KEY (booth_id) REFERENCES public.auction_booth(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auction_priceditem auction_priceditem_purchase_id_4f6763bf_fk_auction_purchase_id; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_priceditem
    ADD CONSTRAINT auction_priceditem_purchase_id_4f6763bf_fk_auction_purchase_id FOREIGN KEY (purchase_id) REFERENCES public.auction_purchase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auction_purchase auction_purchase_patron_id_6e2e679e_fk_auction_patron_id; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auction_purchase
    ADD CONSTRAINT auction_purchase_patron_id_6e2e679e_fk_auction_patron_id FOREIGN KEY (patron_id) REFERENCES public.auction_patron(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk; Type: FK CONSTRAINT; Schema: public; Owner: ysoautxkgdqrjc
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: ysoautxkgdqrjc
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO ysoautxkgdqrjc;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON LANGUAGE plpgsql TO ysoautxkgdqrjc;


--
-- PostgreSQL database dump complete
--

