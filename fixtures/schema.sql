CREATE TABLE roads (
    tlid character varying(255),
    fullname character varying(255),
    lfromadd character varying(255),
    ltoadd character varying(255),
    rfromadd character varying(255),
    rtoadd character varying(255),
    geom geometry(LineString)
);
