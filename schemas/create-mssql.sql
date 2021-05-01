USE [ventas_db]
CREATE TABLE [dbo].[GRUPO_ITEMS](
	[id] [varchar](50) NOT NULL PRIMARY KEY,
	[categoria] [varchar](50) NOT NULL,
	[division] [varchar](50) NOT NULL,
)

CREATE TABLE [dbo].[ITEMS](
	[id] [varchar](10) NOT NULL PRIMARY KEY,
	[idAdicional] [varchar](7) UNIQUE NOT NULL,
	[descripcion] [varchar](50) NULL,
	[idGrupo] [varchar](50) NULL,
)
CREATE TABLE VENTAS (
    id INT IDENTITY(1,1),
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

GO
ALTER TABLE [dbo].[ITEMS]  WITH CHECK ADD  CONSTRAINT [FK_ITEMS_GRUPO_ITEMS] FOREIGN KEY([idGrupo])
REFERENCES [dbo].[GRUPO_ITEMS] ([id])
GO
ALTER TABLE [dbo].[ITEMS] CHECK CONSTRAINT [FK_ITEMS_GRUPO_ITEMS]
GO
ALTER TABLE [dbo].[VENTAS]  WITH CHECK ADD  CONSTRAINT [FK_VENTAS_ITEMS] FOREIGN KEY([idProducto])
REFERENCES [dbo].[ITEMS] ([idAdicional])
GO
ALTER TABLE [dbo].[VENTAS] CHECK CONSTRAINT [FK_VENTAS_ITEMS]
GO
