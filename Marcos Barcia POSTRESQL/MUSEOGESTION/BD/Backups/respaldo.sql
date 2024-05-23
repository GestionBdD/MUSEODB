--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

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
-- Name: compra_select(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.compra_select()
    LANGUAGE plpgsql
    AS $$
    BEGIN
        CREATE TEMP TABLE temp_result AS SELECT * FROM compra;
    END;
    $$;


ALTER PROCEDURE public.compra_select() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: artista; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artista (
    artistaid integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    cedula character varying(10),
    nacionalidad character varying(50),
    fechanacimiento date,
    bibliografia character varying(100)
);


ALTER TABLE public.artista OWNER TO postgres;

--
-- Name: artista_artistaid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.artista_artistaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.artista_artistaid_seq OWNER TO postgres;

--
-- Name: artista_artistaid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.artista_artistaid_seq OWNED BY public.artista.artistaid;


--
-- Name: compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compra (
    compraid integer NOT NULL,
    fechacompra date,
    total numeric(10,2) NOT NULL,
    visitanteid integer
);


ALTER TABLE public.compra OWNER TO postgres;

--
-- Name: compra_compraid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.compra_compraid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.compra_compraid_seq OWNER TO postgres;

--
-- Name: compra_compraid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.compra_compraid_seq OWNED BY public.compra.compraid;


--
-- Name: donacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.donacion (
    donacionid integer NOT NULL,
    descripcion character varying(100),
    fechadonacion date,
    museoid integer,
    donanteid integer
);


ALTER TABLE public.donacion OWNER TO postgres;

--
-- Name: donacion_donacionid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.donacion_donacionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.donacion_donacionid_seq OWNER TO postgres;

--
-- Name: donacion_donacionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.donacion_donacionid_seq OWNED BY public.donacion.donacionid;


--
-- Name: donante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.donante (
    donanteid integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100),
    cedula character varying(10),
    celular character varying(15),
    fechanacimiento date
);


ALTER TABLE public.donante OWNER TO postgres;

--
-- Name: donante_donanteid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.donante_donanteid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.donante_donanteid_seq OWNER TO postgres;

--
-- Name: donante_donanteid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.donante_donanteid_seq OWNED BY public.donante.donanteid;


--
-- Name: empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empleado (
    empleadoid integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    cedula character varying(10) NOT NULL,
    salario numeric(10,2) NOT NULL,
    fechaingreso date,
    fechasalida date,
    museoid integer,
    rolid integer
);


ALTER TABLE public.empleado OWNER TO postgres;

--
-- Name: empleado_empleadoid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.empleado_empleadoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.empleado_empleadoid_seq OWNER TO postgres;

--
-- Name: empleado_empleadoid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empleado_empleadoid_seq OWNED BY public.empleado.empleadoid;


--
-- Name: entrada; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entrada (
    entradaid integer NOT NULL,
    fechaentrada date,
    precio numeric(10,2) NOT NULL,
    museoid integer
);


ALTER TABLE public.entrada OWNER TO postgres;

--
-- Name: entrada_entradaid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entrada_entradaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.entrada_entradaid_seq OWNER TO postgres;

--
-- Name: entrada_entradaid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entrada_entradaid_seq OWNED BY public.entrada.entradaid;


--
-- Name: incidente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.incidente (
    incidenteid integer NOT NULL,
    tipo character varying(50) NOT NULL,
    descripcion character varying(100),
    fechaincidente date,
    museoid integer
);


ALTER TABLE public.incidente OWNER TO postgres;

--
-- Name: incidente_incidenteid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.incidente_incidenteid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.incidente_incidenteid_seq OWNER TO postgres;

--
-- Name: incidente_incidenteid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.incidente_incidenteid_seq OWNED BY public.incidente.incidenteid;


--
-- Name: mantenimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mantenimiento (
    mantenimientoid integer NOT NULL,
    tipo character varying(50) NOT NULL,
    descripcion character varying(100),
    fechamantenimiento date,
    museoid integer
);


ALTER TABLE public.mantenimiento OWNER TO postgres;

--
-- Name: mantenimiento_mantenimientoid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mantenimiento_mantenimientoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mantenimiento_mantenimientoid_seq OWNER TO postgres;

--
-- Name: mantenimiento_mantenimientoid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mantenimiento_mantenimientoid_seq OWNED BY public.mantenimiento.mantenimientoid;


--
-- Name: museo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.museo (
    museoid integer NOT NULL,
    nombre character varying(100) NOT NULL,
    ubicacion character varying(100)
);


ALTER TABLE public.museo OWNER TO postgres;

--
-- Name: museo_museoid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.museo_museoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.museo_museoid_seq OWNER TO postgres;

--
-- Name: museo_museoid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.museo_museoid_seq OWNED BY public.museo.museoid;


--
-- Name: obradearte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.obradearte (
    obraid integer NOT NULL,
    titulo character varying(100) NOT NULL,
    tipo character varying(30),
    descripcion character varying(100),
    fechacreacion date,
    museoid integer,
    artistaid integer,
    ubicacionobraid integer,
    donacionid integer
);


ALTER TABLE public.obradearte OWNER TO postgres;

--
-- Name: obradearte_obraid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.obradearte_obraid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.obradearte_obraid_seq OWNER TO postgres;

--
-- Name: obradearte_obraid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.obradearte_obraid_seq OWNED BY public.obradearte.obraid;


--
-- Name: patrocinador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patrocinador (
    patrocinadorid integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100),
    descripcion character varying(100),
    museoid integer
);


ALTER TABLE public.patrocinador OWNER TO postgres;

--
-- Name: patrocinador_patrocinadorid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patrocinador_patrocinadorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.patrocinador_patrocinadorid_seq OWNER TO postgres;

--
-- Name: patrocinador_patrocinadorid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patrocinador_patrocinadorid_seq OWNED BY public.patrocinador.patrocinadorid;


--
-- Name: prestador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prestador (
    prestadorid integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100),
    cedula character varying(10),
    nacionalidad character varying(100)
);


ALTER TABLE public.prestador OWNER TO postgres;

--
-- Name: prestador_prestadorid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prestador_prestadorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prestador_prestadorid_seq OWNER TO postgres;

--
-- Name: prestador_prestadorid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prestador_prestadorid_seq OWNED BY public.prestador.prestadorid;


--
-- Name: prestamo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prestamo (
    prestamoid integer NOT NULL,
    fechaprestamo date,
    fechadevolucion date,
    motivo character varying(100),
    museoid integer,
    prestadorid integer,
    obraid integer
);


ALTER TABLE public.prestamo OWNER TO postgres;

--
-- Name: prestamo_prestamoid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prestamo_prestamoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prestamo_prestamoid_seq OWNER TO postgres;

--
-- Name: prestamo_prestamoid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prestamo_prestamoid_seq OWNED BY public.prestamo.prestamoid;


--
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto (
    productoid integer NOT NULL,
    compraid integer,
    nombre character varying(100) NOT NULL,
    precio numeric(10,2) NOT NULL,
    descripcion character varying(100)
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- Name: producto_productoid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.producto_productoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.producto_productoid_seq OWNER TO postgres;

--
-- Name: producto_productoid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.producto_productoid_seq OWNED BY public.producto.productoid;


--
-- Name: productotienda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productotienda (
    productoid integer NOT NULL,
    tiendaid integer,
    nombre character varying(100) NOT NULL,
    precio numeric(10,2) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.productotienda OWNER TO postgres;

--
-- Name: productotienda_productoid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productotienda_productoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productotienda_productoid_seq OWNER TO postgres;

--
-- Name: productotienda_productoid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productotienda_productoid_seq OWNED BY public.productotienda.productoid;


--
-- Name: propietario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.propietario (
    propietarioid integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    cedula character varying(10)
);


ALTER TABLE public.propietario OWNER TO postgres;

--
-- Name: propietario_propietarioid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.propietario_propietarioid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.propietario_propietarioid_seq OWNER TO postgres;

--
-- Name: propietario_propietarioid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.propietario_propietarioid_seq OWNED BY public.propietario.propietarioid;


--
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rol (
    rolid integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(100)
);


ALTER TABLE public.rol OWNER TO postgres;

--
-- Name: rol_rolid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rol_rolid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rol_rolid_seq OWNER TO postgres;

--
-- Name: rol_rolid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rol_rolid_seq OWNED BY public.rol.rolid;


--
-- Name: tienda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tienda (
    tiendaid integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion character varying(100) NOT NULL,
    ubicacion character varying(100) NOT NULL,
    museoid integer,
    propietarioid integer
);


ALTER TABLE public.tienda OWNER TO postgres;

--
-- Name: tienda_tiendaid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tienda_tiendaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tienda_tiendaid_seq OWNER TO postgres;

--
-- Name: tienda_tiendaid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tienda_tiendaid_seq OWNED BY public.tienda.tiendaid;


--
-- Name: ubicacionobra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ubicacionobra (
    ubicacionobraid integer NOT NULL,
    piso character varying(20) NOT NULL,
    seccion character varying(30),
    referencia character varying(100)
);


ALTER TABLE public.ubicacionobra OWNER TO postgres;

--
-- Name: ubicacionobra_ubicacionobraid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ubicacionobra_ubicacionobraid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ubicacionobra_ubicacionobraid_seq OWNER TO postgres;

--
-- Name: ubicacionobra_ubicacionobraid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ubicacionobra_ubicacionobraid_seq OWNED BY public.ubicacionobra.ubicacionobraid;


--
-- Name: visitante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visitante (
    visitanteid integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    cedula character varying(10),
    fechavisita date,
    museoid integer
);


ALTER TABLE public.visitante OWNER TO postgres;

--
-- Name: visitante_visitanteid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.visitante_visitanteid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.visitante_visitanteid_seq OWNER TO postgres;

--
-- Name: visitante_visitanteid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.visitante_visitanteid_seq OWNED BY public.visitante.visitanteid;


--
-- Name: voluntario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.voluntario (
    voluntarioid integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    cedula character varying(10) NOT NULL,
    fechainicio date,
    fechafin date,
    museoid integer
);


ALTER TABLE public.voluntario OWNER TO postgres;

--
-- Name: voluntario_voluntarioid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.voluntario_voluntarioid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.voluntario_voluntarioid_seq OWNER TO postgres;

--
-- Name: voluntario_voluntarioid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.voluntario_voluntarioid_seq OWNED BY public.voluntario.voluntarioid;


--
-- Name: artista artistaid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artista ALTER COLUMN artistaid SET DEFAULT nextval('public.artista_artistaid_seq'::regclass);


--
-- Name: compra compraid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra ALTER COLUMN compraid SET DEFAULT nextval('public.compra_compraid_seq'::regclass);


--
-- Name: donacion donacionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donacion ALTER COLUMN donacionid SET DEFAULT nextval('public.donacion_donacionid_seq'::regclass);


--
-- Name: donante donanteid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donante ALTER COLUMN donanteid SET DEFAULT nextval('public.donante_donanteid_seq'::regclass);


--
-- Name: empleado empleadoid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado ALTER COLUMN empleadoid SET DEFAULT nextval('public.empleado_empleadoid_seq'::regclass);


--
-- Name: entrada entradaid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrada ALTER COLUMN entradaid SET DEFAULT nextval('public.entrada_entradaid_seq'::regclass);


--
-- Name: incidente incidenteid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidente ALTER COLUMN incidenteid SET DEFAULT nextval('public.incidente_incidenteid_seq'::regclass);


--
-- Name: mantenimiento mantenimientoid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mantenimiento ALTER COLUMN mantenimientoid SET DEFAULT nextval('public.mantenimiento_mantenimientoid_seq'::regclass);


--
-- Name: museo museoid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.museo ALTER COLUMN museoid SET DEFAULT nextval('public.museo_museoid_seq'::regclass);


--
-- Name: obradearte obraid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obradearte ALTER COLUMN obraid SET DEFAULT nextval('public.obradearte_obraid_seq'::regclass);


--
-- Name: patrocinador patrocinadorid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinador ALTER COLUMN patrocinadorid SET DEFAULT nextval('public.patrocinador_patrocinadorid_seq'::regclass);


--
-- Name: prestador prestadorid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestador ALTER COLUMN prestadorid SET DEFAULT nextval('public.prestador_prestadorid_seq'::regclass);


--
-- Name: prestamo prestamoid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo ALTER COLUMN prestamoid SET DEFAULT nextval('public.prestamo_prestamoid_seq'::regclass);


--
-- Name: producto productoid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto ALTER COLUMN productoid SET DEFAULT nextval('public.producto_productoid_seq'::regclass);


--
-- Name: productotienda productoid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productotienda ALTER COLUMN productoid SET DEFAULT nextval('public.productotienda_productoid_seq'::regclass);


--
-- Name: propietario propietarioid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.propietario ALTER COLUMN propietarioid SET DEFAULT nextval('public.propietario_propietarioid_seq'::regclass);


--
-- Name: rol rolid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol ALTER COLUMN rolid SET DEFAULT nextval('public.rol_rolid_seq'::regclass);


--
-- Name: tienda tiendaid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tienda ALTER COLUMN tiendaid SET DEFAULT nextval('public.tienda_tiendaid_seq'::regclass);


--
-- Name: ubicacionobra ubicacionobraid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubicacionobra ALTER COLUMN ubicacionobraid SET DEFAULT nextval('public.ubicacionobra_ubicacionobraid_seq'::regclass);


--
-- Name: visitante visitanteid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitante ALTER COLUMN visitanteid SET DEFAULT nextval('public.visitante_visitanteid_seq'::regclass);


--
-- Name: voluntario voluntarioid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voluntario ALTER COLUMN voluntarioid SET DEFAULT nextval('public.voluntario_voluntarioid_seq'::regclass);


--
-- Data for Name: artista; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.artista (artistaid, nombre, apellido, cedula, nacionalidad, fechanacimiento, bibliografia) FROM stdin;
1	Frida	Kahlo	1234567890	Mexicana	1907-07-06	Pintora reconocida mundialmente.
2	Leonardo	da Vinci	0987654321	Italiana	1452-04-15	Renacentista, pintor de la Mona Lisa.
3	Frida	Kahlo	1234567890	Mexicana	1907-07-06	Pintora reconocida mundialmente.
4	Leonardo	da Vinci	0987654321	Italiana	1452-04-15	Renacentista, pintor de la Mona Lisa.
\.


--
-- Data for Name: compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compra (compraid, fechacompra, total, visitanteid) FROM stdin;
1	2024-05-20	25.50	1
2	2024-05-21	30.75	2
\.


--
-- Data for Name: donacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.donacion (donacionid, descripcion, fechadonacion, museoid, donanteid) FROM stdin;
1	Colección de pinturas modernas	2023-05-10	1	1
2	Esculturas clásicas	2022-10-20	2	2
\.


--
-- Data for Name: donante; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.donante (donanteid, nombre, apellido, cedula, celular, fechanacimiento) FROM stdin;
1	Juan	Pérez	11223344	555-123-4567	1980-01-15
2	María	González	55443322	555-987-6543	1975-05-20
3	Juan	Pérez	11223344	555-123-4567	1980-01-15
4	María	González	55443322	555-987-6543	1975-05-20
5	Juan	Pérez	11223344	555-123-4567	1980-01-15
6	María	González	55443322	555-987-6543	1975-05-20
\.


--
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empleado (empleadoid, nombre, apellido, cedula, salario, fechaingreso, fechasalida, museoid, rolid) FROM stdin;
1	Roberto	Sánchez	22334455	2500.00	2020-01-10	\N	1	1
2	Ana	García	33445566	3000.00	2019-03-15	\N	2	2
\.


--
-- Data for Name: entrada; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entrada (entradaid, fechaentrada, precio, museoid) FROM stdin;
1	2024-05-20	15.99	1
2	2024-05-21	20.50	2
\.


--
-- Data for Name: incidente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.incidente (incidenteid, tipo, descripcion, fechaincidente, museoid) FROM stdin;
\.


--
-- Data for Name: mantenimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mantenimiento (mantenimientoid, tipo, descripcion, fechamantenimiento, museoid) FROM stdin;
\.


--
-- Data for Name: museo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.museo (museoid, nombre, ubicacion) FROM stdin;
1	Museo de Arte Moderno	Ciudad de México
2	Museo del Louvre	París
3	Museo de Arte Moderno	Ciudad de México
4	Museo del Louvre	París
\.


--
-- Data for Name: obradearte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.obradearte (obraid, titulo, tipo, descripcion, fechacreacion, museoid, artistaid, ubicacionobraid, donacionid) FROM stdin;
1	La persistencia de la memoria	Pintura	Óleo sobre lienzo	1931-01-01	1	1	1	1
2	La Gioconda	Pintura	Óleo sobre tabla	1503-01-01	2	2	2	2
\.


--
-- Data for Name: patrocinador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patrocinador (patrocinadorid, nombre, apellido, descripcion, museoid) FROM stdin;
\.


--
-- Data for Name: prestador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prestador (prestadorid, nombre, apellido, cedula, nacionalidad) FROM stdin;
\.


--
-- Data for Name: prestamo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prestamo (prestamoid, fechaprestamo, fechadevolucion, motivo, museoid, prestadorid, obraid) FROM stdin;
\.


--
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producto (productoid, compraid, nombre, precio, descripcion) FROM stdin;
1	1	Libro de arte	12.99	Guía de la colección
2	2	Réplica escultura	18.95	Miniatura de una escultura famosa
\.


--
-- Data for Name: productotienda; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productotienda (productoid, tiendaid, nombre, precio, descripcion) FROM stdin;
1	1	Taza con diseño de pintura famosa	9.99	Colección de tazas
2	2	Impresión en lienzo	49.95	Reproducción de una obra local
\.


--
-- Data for Name: propietario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.propietario (propietarioid, nombre, apellido, cedula) FROM stdin;
1	Pedro	Martínez	66778899
2	María	López	99887766
\.


--
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rol (rolid, nombre, descripcion) FROM stdin;
1	Guía	Encargado de dar recorridos a los visitantes
2	Administrador	Responsable de la gestión general del museo
\.


--
-- Data for Name: tienda; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tienda (tiendaid, nombre, descripcion, ubicacion, museoid, propietarioid) FROM stdin;
1	Tienda de regalos	Ofrece souvenirs y recuerdos	Planta baja	1	1
2	Boutique de arte	Obras de artistas locales	Piso 2	2	2
\.


--
-- Data for Name: ubicacionobra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ubicacionobra (ubicacionobraid, piso, seccion, referencia) FROM stdin;
1	Piso 1	Sala Principal	Cerca de la entrada
2	Piso 2	Ala Este	En la sección de esculturas
3	Piso 1	Sala Principal	Cerca de la entrada
4	Piso 2	Ala Este	En la sección de esculturas
\.


--
-- Data for Name: visitante; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.visitante (visitanteid, nombre, apellido, cedula, fechavisita, museoid) FROM stdin;
1	Laura	Martínez	99887766	2024-05-20	1
2	Carlos	López	66778899	2024-05-21	2
\.


--
-- Data for Name: voluntario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.voluntario (voluntarioid, nombre, apellido, cedula, fechainicio, fechafin, museoid) FROM stdin;
\.


--
-- Name: artista_artistaid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.artista_artistaid_seq', 4, true);


--
-- Name: compra_compraid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.compra_compraid_seq', 2, true);


--
-- Name: donacion_donacionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.donacion_donacionid_seq', 2, true);


--
-- Name: donante_donanteid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.donante_donanteid_seq', 6, true);


--
-- Name: empleado_empleadoid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empleado_empleadoid_seq', 2, true);


--
-- Name: entrada_entradaid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entrada_entradaid_seq', 2, true);


--
-- Name: incidente_incidenteid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.incidente_incidenteid_seq', 1, false);


--
-- Name: mantenimiento_mantenimientoid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mantenimiento_mantenimientoid_seq', 1, false);


--
-- Name: museo_museoid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.museo_museoid_seq', 4, true);


--
-- Name: obradearte_obraid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.obradearte_obraid_seq', 2, true);


--
-- Name: patrocinador_patrocinadorid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patrocinador_patrocinadorid_seq', 1, false);


--
-- Name: prestador_prestadorid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prestador_prestadorid_seq', 1, false);


--
-- Name: prestamo_prestamoid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prestamo_prestamoid_seq', 1, false);


--
-- Name: producto_productoid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.producto_productoid_seq', 2, true);


--
-- Name: productotienda_productoid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productotienda_productoid_seq', 2, true);


--
-- Name: propietario_propietarioid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.propietario_propietarioid_seq', 2, true);


--
-- Name: rol_rolid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rol_rolid_seq', 2, true);


--
-- Name: tienda_tiendaid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tienda_tiendaid_seq', 2, true);


--
-- Name: ubicacionobra_ubicacionobraid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ubicacionobra_ubicacionobraid_seq', 4, true);


--
-- Name: visitante_visitanteid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.visitante_visitanteid_seq', 2, true);


--
-- Name: voluntario_voluntarioid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.voluntario_voluntarioid_seq', 1, false);


--
-- Name: artista artista_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artista
    ADD CONSTRAINT artista_pkey PRIMARY KEY (artistaid);


--
-- Name: compra compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_pkey PRIMARY KEY (compraid);


--
-- Name: donacion donacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donacion
    ADD CONSTRAINT donacion_pkey PRIMARY KEY (donacionid);


--
-- Name: donante donante_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donante
    ADD CONSTRAINT donante_pkey PRIMARY KEY (donanteid);


--
-- Name: empleado empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (empleadoid);


--
-- Name: entrada entrada_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrada
    ADD CONSTRAINT entrada_pkey PRIMARY KEY (entradaid);


--
-- Name: incidente incidente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidente
    ADD CONSTRAINT incidente_pkey PRIMARY KEY (incidenteid);


--
-- Name: mantenimiento mantenimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mantenimiento
    ADD CONSTRAINT mantenimiento_pkey PRIMARY KEY (mantenimientoid);


--
-- Name: museo museo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.museo
    ADD CONSTRAINT museo_pkey PRIMARY KEY (museoid);


--
-- Name: obradearte obradearte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obradearte
    ADD CONSTRAINT obradearte_pkey PRIMARY KEY (obraid);


--
-- Name: patrocinador patrocinador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinador
    ADD CONSTRAINT patrocinador_pkey PRIMARY KEY (patrocinadorid);


--
-- Name: prestador prestador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestador
    ADD CONSTRAINT prestador_pkey PRIMARY KEY (prestadorid);


--
-- Name: prestamo prestamo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT prestamo_pkey PRIMARY KEY (prestamoid);


--
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (productoid);


--
-- Name: productotienda productotienda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productotienda
    ADD CONSTRAINT productotienda_pkey PRIMARY KEY (productoid);


--
-- Name: propietario propietario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.propietario
    ADD CONSTRAINT propietario_pkey PRIMARY KEY (propietarioid);


--
-- Name: rol rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (rolid);


--
-- Name: tienda tienda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tienda
    ADD CONSTRAINT tienda_pkey PRIMARY KEY (tiendaid);


--
-- Name: ubicacionobra ubicacionobra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubicacionobra
    ADD CONSTRAINT ubicacionobra_pkey PRIMARY KEY (ubicacionobraid);


--
-- Name: visitante visitante_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitante
    ADD CONSTRAINT visitante_pkey PRIMARY KEY (visitanteid);


--
-- Name: voluntario voluntario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voluntario
    ADD CONSTRAINT voluntario_pkey PRIMARY KEY (voluntarioid);


--
-- Name: compra compra_visitanteid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_visitanteid_fkey FOREIGN KEY (visitanteid) REFERENCES public.visitante(visitanteid);


--
-- Name: donacion donacion_donanteid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donacion
    ADD CONSTRAINT donacion_donanteid_fkey FOREIGN KEY (donanteid) REFERENCES public.donante(donanteid);


--
-- Name: donacion donacion_museoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donacion
    ADD CONSTRAINT donacion_museoid_fkey FOREIGN KEY (museoid) REFERENCES public.museo(museoid);


--
-- Name: empleado empleado_museoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_museoid_fkey FOREIGN KEY (museoid) REFERENCES public.museo(museoid);


--
-- Name: empleado empleado_rolid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_rolid_fkey FOREIGN KEY (rolid) REFERENCES public.rol(rolid);


--
-- Name: entrada entrada_museoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrada
    ADD CONSTRAINT entrada_museoid_fkey FOREIGN KEY (museoid) REFERENCES public.museo(museoid);


--
-- Name: incidente incidente_museoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidente
    ADD CONSTRAINT incidente_museoid_fkey FOREIGN KEY (museoid) REFERENCES public.museo(museoid);


--
-- Name: mantenimiento mantenimiento_museoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mantenimiento
    ADD CONSTRAINT mantenimiento_museoid_fkey FOREIGN KEY (museoid) REFERENCES public.museo(museoid);


--
-- Name: obradearte obradearte_artistaid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obradearte
    ADD CONSTRAINT obradearte_artistaid_fkey FOREIGN KEY (artistaid) REFERENCES public.artista(artistaid);


--
-- Name: obradearte obradearte_donacionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obradearte
    ADD CONSTRAINT obradearte_donacionid_fkey FOREIGN KEY (donacionid) REFERENCES public.donacion(donacionid);


--
-- Name: obradearte obradearte_museoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obradearte
    ADD CONSTRAINT obradearte_museoid_fkey FOREIGN KEY (museoid) REFERENCES public.museo(museoid);


--
-- Name: obradearte obradearte_ubicacionobraid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obradearte
    ADD CONSTRAINT obradearte_ubicacionobraid_fkey FOREIGN KEY (ubicacionobraid) REFERENCES public.ubicacionobra(ubicacionobraid);


--
-- Name: patrocinador patrocinador_museoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinador
    ADD CONSTRAINT patrocinador_museoid_fkey FOREIGN KEY (museoid) REFERENCES public.museo(museoid);


--
-- Name: prestamo prestamo_museoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT prestamo_museoid_fkey FOREIGN KEY (museoid) REFERENCES public.museo(museoid);


--
-- Name: prestamo prestamo_obraid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT prestamo_obraid_fkey FOREIGN KEY (obraid) REFERENCES public.obradearte(obraid);


--
-- Name: prestamo prestamo_prestadorid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT prestamo_prestadorid_fkey FOREIGN KEY (prestadorid) REFERENCES public.prestador(prestadorid);


--
-- Name: producto producto_compraid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_compraid_fkey FOREIGN KEY (compraid) REFERENCES public.compra(compraid);


--
-- Name: productotienda productotienda_tiendaid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productotienda
    ADD CONSTRAINT productotienda_tiendaid_fkey FOREIGN KEY (tiendaid) REFERENCES public.tienda(tiendaid);


--
-- Name: tienda tienda_museoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tienda
    ADD CONSTRAINT tienda_museoid_fkey FOREIGN KEY (museoid) REFERENCES public.museo(museoid);


--
-- Name: tienda tienda_propietarioid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tienda
    ADD CONSTRAINT tienda_propietarioid_fkey FOREIGN KEY (propietarioid) REFERENCES public.propietario(propietarioid);


--
-- Name: visitante visitante_museoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitante
    ADD CONSTRAINT visitante_museoid_fkey FOREIGN KEY (museoid) REFERENCES public.museo(museoid);


--
-- Name: voluntario voluntario_museoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voluntario
    ADD CONSTRAINT voluntario_museoid_fkey FOREIGN KEY (museoid) REFERENCES public.museo(museoid);


--
-- PostgreSQL database dump complete
--

