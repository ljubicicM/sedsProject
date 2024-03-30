CREATE TABLE mlj_dw_city (
    cityid               INTEGER NOT NULL,
    cityname             VARCHAR2(30 CHAR) NOT NULL,
    mlj_dw_regi_regionid INTEGER NOT NULL
);

ALTER TABLE mlj_dw_city ADD CONSTRAINT mlj_dw_city_pk PRIMARY KEY ( cityid );

CREATE TABLE mlj_dw_country (
    coid        INTEGER NOT NULL,
    countryname VARCHAR2(20 CHAR) NOT NULL
);

ALTER TABLE mlj_dw_country ADD CONSTRAINT mlj_dw_country_pk PRIMARY KEY ( coid );

CREATE TABLE mlj_dw_craft (
    mlj_dw_craft_t_crafttypeid INTEGER NOT NULL,
    craftid                    INTEGER NOT NULL,
    craftname                  VARCHAR2(20 CHAR) NOT NULL,
    artisanname                VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE mlj_dw_craft ADD CONSTRAINT mlj_dw_craft_pk PRIMARY KEY ( craftid );

CREATE TABLE mlj_dw_craft_t (
    crafttypeid   INTEGER NOT NULL,
    crafttypename VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE mlj_dw_craft_t ADD CONSTRAINT mlj_dw_craft_t_pk PRIMARY KEY ( crafttypeid );

CREATE TABLE mlj_dw_customer (
    mlj_dw_city_cityid INTEGER NOT NULL,
    customerid         INTEGER NOT NULL,
    name               VARCHAR2(50 CHAR) NOT NULL,
    adress             VARCHAR2(50 CHAR) NOT NULL,
    age                INTEGER NOT NULL
);

ALTER TABLE mlj_dw_customer ADD CONSTRAINT mlj_dw_customer_pk PRIMARY KEY ( customerid );

CREATE TABLE mlj_dw_paym_t (
    paymenttypeid   INTEGER NOT NULL,
    paymenttypename VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE mlj_dw_paym_t ADD CONSTRAINT mlj_dw_paym_t_pk PRIMARY KEY ( paymenttypeid );

CREATE TABLE mlj_dw_regi (
    regionid            INTEGER NOT NULL,
    regionname          VARCHAR2(30 CHAR) NOT NULL,
    mlj_dw_country_coid INTEGER NOT NULL
);

ALTER TABLE mlj_dw_regi ADD CONSTRAINT mlj_dw_regi_pk PRIMARY KEY ( regionid );

CREATE TABLE mlj_dw_sale (
    mlj_dw_customer_customerid  INTEGER NOT NULL,
    mlj_dw_time_timeid          INTEGER NOT NULL,
    saleid                      INTEGER NOT NULL,
    mlj_dw_craft_craftid        INTEGER NOT NULL,
    orderdate                   DATE NOT NULL,
    totalearnings               VARCHAR2(20) NOT NULL,
    paymentdate                 DATE NOT NULL,
    mlj_dw_paym_t_paymenttypeid INTEGER NOT NULL
);

ALTER TABLE mlj_dw_sale ADD CONSTRAINT mlj_dw_sale_pk PRIMARY KEY ( saleid );

CREATE TABLE mlj_dw_storing (
    mlj_dw_wh_whid       INTEGER NOT NULL,
    storingid            INTEGER NOT NULL,
    mlj_dw_time_timeid   INTEGER NOT NULL,
    mlj_dw_craft_craftid INTEGER NOT NULL,
    datestored           DATE NOT NULL,
    dateordered          DATE NOT NULL,
    daysstored           INTEGER NOT NULL,
    weightclass          VARCHAR2(30) NOT NULL
);

ALTER TABLE mlj_dw_storing ADD CONSTRAINT mlj_dw_storing_pk PRIMARY KEY ( storingid );

CREATE TABLE mlj_dw_time (
    timeid INTEGER NOT NULL,
    "date" DATE NOT NULL,
    day    INTEGER NOT NULL,
    month  INTEGER NOT NULL,
    year   INTEGER NOT NULL
);

ALTER TABLE mlj_dw_time ADD CONSTRAINT mlj_dw_time_pk PRIMARY KEY ( timeid );

CREATE TABLE mlj_dw_wh (
    mlj_dw_city_cityid INTEGER NOT NULL,
    whid               INTEGER NOT NULL,
    adress             VARCHAR2(50 CHAR) NOT NULL,
    capacity           INTEGER NOT NULL,
    noemployees        INTEGER NOT NULL
);

ALTER TABLE mlj_dw_wh ADD CONSTRAINT mlj_dw_wh_pk PRIMARY KEY ( whid );

ALTER TABLE mlj_dw_city
    ADD CONSTRAINT mlj_dw_city_mlj_dw_regi_fk FOREIGN KEY ( mlj_dw_regi_regionid )
        REFERENCES mlj_dw_regi ( regionid );

ALTER TABLE mlj_dw_craft
    ADD CONSTRAINT mlj_dw_craft_mlj_dw_craft_t_fk FOREIGN KEY ( mlj_dw_craft_t_crafttypeid )
        REFERENCES mlj_dw_craft_t ( crafttypeid );

ALTER TABLE mlj_dw_customer
    ADD CONSTRAINT mlj_dw_customer_mlj_dw_city_fk FOREIGN KEY ( mlj_dw_city_cityid )
        REFERENCES mlj_dw_city ( cityid );

ALTER TABLE mlj_dw_regi
    ADD CONSTRAINT mlj_dw_regi_mlj_dw_country_fk FOREIGN KEY ( mlj_dw_country_coid )
        REFERENCES mlj_dw_country ( coid );

ALTER TABLE mlj_dw_sale
    ADD CONSTRAINT mlj_dw_sale_mlj_dw_craft_fk FOREIGN KEY ( mlj_dw_craft_craftid )
        REFERENCES mlj_dw_craft ( craftid );

ALTER TABLE mlj_dw_sale
    ADD CONSTRAINT mlj_dw_sale_mlj_dw_customer_fk FOREIGN KEY ( mlj_dw_customer_customerid )
        REFERENCES mlj_dw_customer ( customerid );

ALTER TABLE mlj_dw_sale
    ADD CONSTRAINT mlj_dw_sale_mlj_dw_paym_t_fk FOREIGN KEY ( mlj_dw_paym_t_paymenttypeid )
        REFERENCES mlj_dw_paym_t ( paymenttypeid );

ALTER TABLE mlj_dw_sale
    ADD CONSTRAINT mlj_dw_sale_mlj_dw_time_fk FOREIGN KEY ( mlj_dw_time_timeid )
        REFERENCES mlj_dw_time ( timeid );

ALTER TABLE mlj_dw_storing
    ADD CONSTRAINT mlj_dw_storing_mlj_dw_craft_fk FOREIGN KEY ( mlj_dw_craft_craftid )
        REFERENCES mlj_dw_craft ( craftid );

ALTER TABLE mlj_dw_storing
    ADD CONSTRAINT mlj_dw_storing_mlj_dw_time_fk FOREIGN KEY ( mlj_dw_time_timeid )
        REFERENCES mlj_dw_time ( timeid );

ALTER TABLE mlj_dw_storing
    ADD CONSTRAINT mlj_dw_storing_mlj_dw_wh_fk FOREIGN KEY ( mlj_dw_wh_whid )
        REFERENCES mlj_dw_wh ( whid );

ALTER TABLE mlj_dw_wh
    ADD CONSTRAINT mlj_dw_wh_mlj_dw_city_fk FOREIGN KEY ( mlj_dw_city_cityid )
        REFERENCES mlj_dw_city ( cityid );
commit;