
CREATE TABLE ventas_db.VENTAS (
	id INT AUTO_INCREMENT,
    idFactura INT,     -- 57716
    fecha DATE,             -- 29/05/2019
    fechaVencimiento DATE,  -- 29/06/2019
    idCliente VARCHAR(5),      -- C4342
    idProducto VARCHAR(7),     -- 0000054
    cantidad FLOAT,         
    moneda VARCHAR(4),         -- CRC
    precio FLOAT,           -- 5,494.5000
    total FLOAT,            -- 32,967.00
    idAlmacen INT,          -- 01
    idVendedor INT,         -- -1
    totalUsd FLOAT,         -- 0
    impuesto FLOAT,         -- 4,285.71
    impuestoUsd FLOAT,      -- 0
    tipoCambio FLOAT,       -- 1.00
    ganancia FLOAT,         -- 17,361.9500
    gananciaUsd FLOAT,       -- 0
    PRIMARY KEY (id, idFactura)
)