CREATE TABLE mlj_artisan (
    artisanid       INTEGER NOT NULL,
    artisanname     VARCHAR2(20 CHAR) NOT NULL,
    artisanlastname VARCHAR2(20 CHAR) NOT NULL,
    artisanemail    VARCHAR2(30 CHAR) NOT NULL,
    specialization  VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE mlj_artisan ADD CONSTRAINT mlj_artisan_pk PRIMARY KEY ( artisanid );

CREATE TABLE mlj_city (
    mlj_region_regionid INTEGER NOT NULL,
    cityid              INTEGER NOT NULL,
    cityname            VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE mlj_city ADD CONSTRAINT mlj_city_pk PRIMARY KEY ( cityid );

CREATE TABLE mlj_craft (
    mlj_artisan_artisanid     INTEGER NOT NULL,
    craftid                   INTEGER NOT NULL,
    mlj_warehouse_warehouseid INTEGER NOT NULL,
    craftname                 VARCHAR2(30 CHAR) NOT NULL,
    unitprice                 INTEGER NOT NULL,
    unitweightkg              INTEGER NOT NULL,
    datestored                DATE NOT NULL
);

ALTER TABLE mlj_craft ADD CONSTRAINT mlj_craft_pk PRIMARY KEY ( craftid );

CREATE TABLE mlj_customer (
    mlj_city_cityid INTEGER NOT NULL,
    customerid      INTEGER NOT NULL,
    dateofbirth     DATE NOT NULL,
    customerName            VARCHAR2(20 CHAR) NOT NULL,
    CustomerLastName        VARCHAR2(30 CHAR) NOT NULL,
    adress          VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE mlj_customer ADD CONSTRAINT mlj_customer_pk PRIMARY KEY ( customerid );

CREATE TABLE mlj_order (
    orderid                 INTEGER NOT NULL,
    mlj_customer_customerid INTEGER NOT NULL,
    orderdate               DATE NOT NULL
);

ALTER TABLE mlj_order ADD CONSTRAINT mlj_order_pk PRIMARY KEY ( orderid );

CREATE TABLE mlj_orderitem (
    mlj_craft_craftid INTEGER NOT NULL,
    mlj_order_orderid INTEGER NOT NULL,
    orderitemid       INTEGER NOT NULL,
    quantity          INTEGER NOT NULL
);

ALTER TABLE mlj_orderitem ADD CONSTRAINT mlj_orderitem_pk PRIMARY KEY ( orderitemid );

CREATE TABLE mlj_payment (
    mlj_order_orderid INTEGER NOT NULL,
    paymentid         INTEGER NOT NULL,
    paymentdate       DATE NOT NULL,
    paymenttype       VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE mlj_payment ADD CONSTRAINT mlj_payment_pk PRIMARY KEY ( paymentid );

CREATE TABLE mlj_region (
    regionid    INTEGER NOT NULL,
    regionname  VARCHAR2(30 CHAR) NOT NULL,
    countryname VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE mlj_region ADD CONSTRAINT mlj_region_pk PRIMARY KEY ( regionid );

CREATE TABLE mlj_warehouse (
    mlj_city_cityid INTEGER NOT NULL,
    warehouseid     INTEGER NOT NULL,
    adress          VARCHAR2(50 CHAR) NOT NULL,
    phonenumber     VARCHAR2(20 CHAR) NOT NULL,
    capacity        INTEGER NOT NULL,
    noemployees     INTEGER NOT NULL
);

ALTER TABLE mlj_warehouse ADD CONSTRAINT mlj_warehouse_pk PRIMARY KEY ( warehouseid );

ALTER TABLE mlj_city
    ADD CONSTRAINT mlj_city_mlj_region_fk FOREIGN KEY ( mlj_region_regionid )
        REFERENCES mlj_region ( regionid );

ALTER TABLE mlj_craft
    ADD CONSTRAINT mlj_craft_mlj_artisan_fk FOREIGN KEY ( mlj_artisan_artisanid )
        REFERENCES mlj_artisan ( artisanid );

ALTER TABLE mlj_craft
    ADD CONSTRAINT mlj_craft_mlj_warehouse_fk FOREIGN KEY ( mlj_warehouse_warehouseid )
        REFERENCES mlj_warehouse ( warehouseid );

ALTER TABLE mlj_customer
    ADD CONSTRAINT mlj_customer_mlj_city_fk FOREIGN KEY ( mlj_city_cityid )
        REFERENCES mlj_city ( cityid );

ALTER TABLE mlj_order
    ADD CONSTRAINT mlj_order_mlj_customer_fk FOREIGN KEY ( mlj_customer_customerid )
        REFERENCES mlj_customer ( customerid );

ALTER TABLE mlj_orderitem
    ADD CONSTRAINT mlj_orderitem_mlj_craft_fk FOREIGN KEY ( mlj_craft_craftid )
        REFERENCES mlj_craft ( craftid );

ALTER TABLE mlj_orderitem
    ADD CONSTRAINT mlj_orderitem_mlj_order_fk FOREIGN KEY ( mlj_order_orderid )
        REFERENCES mlj_order ( orderid );

ALTER TABLE mlj_payment
    ADD CONSTRAINT mlj_payment_mlj_order_fk FOREIGN KEY ( mlj_order_orderid )
        REFERENCES mlj_order ( orderid );

ALTER TABLE mlj_warehouse
    ADD CONSTRAINT mlj_warehouse_mlj_city_fk FOREIGN KEY ( mlj_city_cityid )
        REFERENCES mlj_city ( cityid );