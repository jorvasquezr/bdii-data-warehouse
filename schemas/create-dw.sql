USE [DW]

CREATE TABLE DIM_ITEMS (
    id VARCHAR(10) PRIMARY KEY,
    idAdicional VARCHAR(7) NOT NULL UNIQUE,
    descripcion VARCHAR(200),
    grupo VARCHAR(40),
    categoria VARCHAR(100),
    division VARCHAR(40)
)

CREATE TABLE DIM_CLIENTES (
    codigoSN VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(14),
    codCondicionesPago VARCHAR(200),
    limiteCredito INT,
    monedaSN VARCHAR(4),
    destinatarioFactura VARCHAR(2),
    idZona INT,
    nombreZona VARCHAR(80),
    plazoZona INT,
    ruta VARCHAR(40),
    idCanal INT,
    nombreCanal VARCHAR(20),
    prioridadCanal VARCHAR(20)
)

CREATE TABLE DIM_VENDEDOR (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    porcentajeComision INT,
    bloquado VARCHAR(1) NOT NULL CHECK (bloquado IN('Y', 'N')),
    activo VARCHAR(1) NOT NULL CHECK (activo IN('Y', 'N')),
    email VARCHAR(200),
    isCobrador VARCHAR(1) NOT NULL CHECK (isCobrador IN('Y', 'N')),
    isPromotor VARCHAR(1) NOT NULL CHECK (isPromotor IN('Y', 'N')),
    tipo VARCHAR(80),
    canal VARCHAR(40)
)

CREATE TABLE FACT_VENTAS (
    id INT IDENTITY(1,1),
    idFactura INT,     -- 57716
    idFecha DATE FOREIGN KEY REFERENCES DIM_DATE([date]),             -- 29/05/2019
    idFechaVencimiento DATE FOREIGN KEY REFERENCES DIM_DATE([date]),  -- 29/06/2019
    idCliente VARCHAR(5) FOREIGN KEY REFERENCES DIM_CLIENTES(codigoSN),      -- C4342
    idProducto VARCHAR(7) FOREIGN KEY REFERENCES DIM_ITEMS(idAdicional),     -- 0000054
    cantidad FLOAT,         --6.00
    moneda VARCHAR(4),         -- CRC
    precio FLOAT,           -- 5,494.5000
    total FLOAT,            -- 32,967.00
    idAlmacen INT,          -- 01
    idVendedor INT FOREIGN KEY REFERENCES DIM_VENDEDOR(id),         -- -1
    totalUsd FLOAT,         -- 0
    impuesto FLOAT,         -- 4,285.71
    impuestoUsd FLOAT,      -- 0
    ganancia FLOAT,         -- 17,361.9500
    gananciaUsd FLOAT,       -- 0
    PRIMARY KEY(id, idFactura)
)
GO
CREATE PROCEDURE actualizarDatosDeDolares
AS

UPDATE
    FACT_VENTAS
SET
    gananciaUsd = v.ganancia/d.VentaDolar,
	totalUSD = v.total/d.VentaDolar,
    impuestoUsd= v.impuesto/d.VentaDolar
FROM
    DIM_DATE as d
    INNER JOIN FACT_VENTAS AS v
        ON  d.Date= v.idFecha
GO