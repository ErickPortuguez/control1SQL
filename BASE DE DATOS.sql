--Crear una base de datos SQL Server

CREATE DATABASE FRUCSEDIS
GO
--Crear una base de datos si no existe

IF DB_ID('FRUCSEDIS') IS NULL
CREATE DATABASE FRUCSEDIS
PRINT 'Se ha creado la base de datos testDatabase'
GO
--Eliminar base de datos existente

DROP DATABASE FRUCSEDIS
GO
--Validar si existe una base de datos y eliminarla

IF DB_ID('FRUCSEDIS') IS NOT NULL
DROP DATABASE FRUCSEDIS;
PRINT 'Base de datos encontrada y eliminada'
GO
--Poner en uso base de datos

USE FRUCSEDIS
GO
--Creación y gestión de tablas
--Crear tabla CLIENTE

CREATE TABLE CLIENTE
(
    CODCLI CHAR(4),
    NOMCLI NCHAR(60),
    APECLI NCHAR(80),
    DNICLI CHAR(8),
    ESTCLI CHAR(1) DEFAULT 'A', -- Agrega por default el estado A (activo)
    CONSTRAINT CLI_PK PRIMARY KEY (CODCLI) -- Definiendo clave principal
)
GO
--Agregar campos a tabla CLIENTE

ALTER TABLE CLIENTE 
    ADD UBICLI CHAR(6)
GO
--Ver columnas de tabla CLIENTE

EXEC sp_columns @table_name='CLIENTE'
GO
--Eliminar columna de tabla CLIENTE

ALTER TABLE CLIENTE 
    DROP COLUMN UBICLI
GO
--Ver columnas de tabla CLIENTE

EXEC sp_columns @table_name='CLIENTE'
GO
--Eliminar tabla CLIENTE

DROP TABLE CLIENTE 
GO
--Gestión de registros
--Insertar un registro tabla CLIENTE

INSERT INTO CLIENTE
(CODCLI, NOMCLI, APECLI, DNICLI)
VALUES
('C001', 'Alberto', 'Campos Barrios', '12659874')
GO
--Insertar más de un registro en una tabla CLIENTE

INSERT INTO CLIENTE
(CODCLI, NOMCLI, APECLI, DNICLI)
VALUES
('C002', 'Juana', 'Zavala Olaya', '98542631'),
('C003', 'Marcos', 'Arredondo Palomino', '45123697'),
('C004', 'Ramón', 'Stark Ríos', '25361478')
GO
--Listar registros tabla CLIENTE

SELECT * FROM CLIENTE 
GO
--Modificar o actualizar registro

UPDATE CLIENTE
    SET NOMCLI = 'Alexander'
    WHERE CODCLI = 'C001'
GO
--Eliminar registros de tabla CLIENTE

DELETE FROM CLIENTE
    WHERE CODCLI = 'C002'
GO
--Relacionar tablas
--Tabla PERSONA

CREATE TABLE PERSONA
(
    IDPER INT IDENTITY(1,1),
    NOMPER VARCHAR(60),
    APEPER VARCHAR(80),
    EMAPER VARCHAR(80),
    TIPPER CHAR(1),
    FECNACPER DATE,
    ESTPER CHAR(1) DEFAULT 'A',
    CONSTRAINT PER_PK PRIMARY KEY (IDPER)
)
GO
--Tabla VENTA

CREATE TABLE VENTA 
(
    IDVEN INT IDENTITY(1,1),
    IDPERVEN INT,
    IDPERCLI INT,
    FECVEN DATETIME DEFAULT GETDATE(), 
    ESTVEN CHAR(1) DEFAULT 'A',
    CONSTRAINT VEN_PK PRIMARY KEY (IDVEN)
)
GO
--Establecer relación entre tablas VENTA - PERSONA (VENDEDOR)

ALTER TABLE VENTA 
ADD CONSTRAINT VENTVEN_FK FOREIGN KEY (IDPERVEN)
REFERENCES PERSONA (IDPER)
GO
--Establecer relación entre tablas VENTA - PERSONA (CLIENTE)

ALTER TABLE VENTA 
ADD CONSTRAINT VENTCLI_FK FOREIGN KEY (IDPERCLI)
REFERENCES PERSONA (IDPER)
GO
--Gestionando FECHAS en SQL SERVER
--Ver idioma en que se ha instalado MS SQL Server

SELECT @@language as 'Idioma de SQL Server'
GO
--Ver el formato de fecha de acuerdo al idioma de MS SQL Server

SELECT SYSDATETIME() AS 'Fecha y hora de SQL Server'
GO
--Establecer el formato de fecha en DMY (día/mes/año)

SET DATEFORMAT dmy
GO
--Probamos la inserción de fechas en tabla

CREATE TABLE TEST (FECHA DATE)
GO
SET DATEFORMAT dmy
GO
INSERT INTO TEST VALUES ('20/12/1999')
GO
SELECT * FROM TEST
GO
SELECT FORMAT(FECHA, 'd/MM/yyy')  AS 'Listar fecha'
FROM TEST
GO
--Gestión de registros en tablas RELACIONADAS
--Ver estructura de tabla PERSONA

EXEC sp_columns @table_name='PERSONA'
GO
--Insertar registros en tabla PERSONA

SET DATEFORMAT dmy 
GO

INSERT INTO PERSONA
(NOMPER, APEPER, EMAPER, TIPPER, FECNACPER)
VALUES
('Juan', 'Palomino Hernández', 'juan.palomino@miempresa.com', 'V','01/03/1995'),
('Alberto', 'Jiménez Urrutia', 'alberto.urrutia@miempresa.com', 'V','15/07/1998'),
('María', 'Ávila Chumpitaz', 'maria.avila@miempresa.com', 'C','22/05/1997'),
('Claudia', 'Aparicio Mendoza', 'claudia.aparicio@gmail.com', 'C','02/12/1999'),
('Marcos', 'Tarazona Guerra', 'marcos.tarazona@yahoo.com', 'C','02/11/1997'),
('Damian', 'Farfán Solano', 'damian.farfan@hotmail.com', 'C','20/08/2000')
('Leo', 'Torres Solano', 'leo.torres@hotmail.com', 'C','10/08/2003')
('Alexander', 'Portuguez Zavala', 'alexander.portuguez@hotmail.com', 'C','2/08/2004')
('Fabion', 'Farfán Porras', 'fabio.farfan@hotmail.com', 'C','15/08/2007')
('Ignacio', 'Farfán Sanchez', 'ignacio.farfan@hotmail.com', 'C','16/08/2003')
GO
--Listar registros de tabla PERSONA

SELECT 
    NOMPER AS 'Nombre', 
    APEPER AS 'Apellidos', 
    TIPPER AS 'Tipo Persona', 
    FORMAT(FECNACPER, 'dd/MM/yyyy') AS 'Fecha Nacimiento'
FROM PERSONA
GO
--Ver estructura de tabla VENTA

EXEC sp_columns @table_name='VENTA'
GO
--Insertar registros tabla VENTA

SET DATEFORMAT dmy 
GO

INSERT INTO VENTA
(IDPERVEN, IDPERCLI)
VALUES
(1, 3),
(1, 6),
(2, 5),
(2, 4),
(1, 5)
GO
--Listar registros de tabla VENTA

SELECT * FROM VENTA
GO