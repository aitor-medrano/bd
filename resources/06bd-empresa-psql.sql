-- Crear la base de datos (ejecutar separadamente si es necesario)
CREATE DATABASE empresa WITH ENCODING 'UTF8';

-- Conectar a la base de datos empresa
\c empresa;

-- Eliminar tablas si existen (en orden inverso a las dependencias)
DROP TABLE IF EXISTS "habemp" CASCADE;
DROP TABLE IF EXISTS "hijo" CASCADE;
DROP TABLE IF EXISTS "empleado" CASCADE;
DROP TABLE IF EXISTS "departamento" CASCADE;
DROP TABLE IF EXISTS "centro" CASCADE;
DROP TABLE IF EXISTS "habilidad" CASCADE;

-- Tabla habilidad
CREATE TABLE "habilidad" (
  "CodHab" CHAR(5) PRIMARY KEY,
  "DesHab" VARCHAR(30) UNIQUE
);

-- Tabla centro
CREATE TABLE "centro" (
  "CodCen" CHAR(4) PRIMARY KEY,
  "CodEmpDir" INTEGER,
  "NomCen" VARCHAR(30) NOT NULL UNIQUE,
  "DirCen" VARCHAR(50),
  "PobCen" VARCHAR(15)
);

-- Tabla departamento
CREATE TABLE "departamento" (
  "CodDep" CHAR(5) PRIMARY KEY,
  "CodEmpDir" INTEGER,
  "CodDepDep" CHAR(5),
  "CodCen" CHAR(4),
  "NomDep" VARCHAR(40) NOT NULL UNIQUE,
  "PreAnu" DECIMAL(12,2),
  "TiDir" CHAR(1) CHECK ("TiDir" IN ('F','P'))
);

-- Tabla empleado
CREATE TABLE "empleado" (
  "CodEmp" SERIAL PRIMARY KEY,
  "CodDep" CHAR(5),
  "ExTelEmp" VARCHAR(9),
  "FecInEmp" DATE,
  "FecNaEmp" DATE,
  "NifEmp" VARCHAR(9),
  "NomEmp" VARCHAR(40),
  "NumHi" INTEGER CHECK ("NumHi" >= 0 AND "NumHi" <= 9),
  "SalEmp" DECIMAL(12,2)
);

-- Tabla habemp
CREATE TABLE "habemp" (
  "CodHab" CHAR(5),
  "CodEmp" INTEGER,
  "NivHab" SMALLINT,
  PRIMARY KEY ("CodEmp", "CodHab")
);

-- Tabla hijo
CREATE TABLE "hijo" (
  "CodEmp" INTEGER,
  "NumHij" INTEGER CHECK ("NumHij" >= 0 AND "NumHij" <= 9),
  "FecNaHi" DATE,
  "NomHi" VARCHAR(40),
  PRIMARY KEY ("CodEmp", "NumHij")
);

-- Añadir claves foráneas
ALTER TABLE "departamento"
ADD CONSTRAINT "fk_dep_cen" FOREIGN KEY ("CodCen") REFERENCES "centro"("CodCen")
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "departamento"
ADD CONSTRAINT "fk_dep_emp" FOREIGN KEY ("CodEmpDir") REFERENCES "empleado"("CodEmp")
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "departamento"
ADD CONSTRAINT "fk_dep_dep" FOREIGN KEY ("CodDepDep") REFERENCES "departamento"("CodDep")
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "empleado"
ADD CONSTRAINT "fk_emp_dep" FOREIGN KEY ("CodDep") REFERENCES "departamento"("CodDep")
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "centro"
ADD CONSTRAINT "fk_cen_emp" FOREIGN KEY ("CodEmpDir") REFERENCES "empleado"("CodEmp")
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "hijo"
ADD CONSTRAINT "fk_hij_emp" FOREIGN KEY ("CodEmp") REFERENCES "empleado"("CodEmp")
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "habemp"
ADD CONSTRAINT "fk_habemp_emp" FOREIGN KEY ("CodEmp") REFERENCES "empleado"("CodEmp")
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "habemp"
ADD CONSTRAINT "fk_habemp_hab" FOREIGN KEY ("CodHab") REFERENCES "habilidad"("CodHab")
ON DELETE NO ACTION ON UPDATE CASCADE;

-- Iniciar transacción y deshabilitar temporalmente las restricciones de claves foráneas
BEGIN;
SET CONSTRAINTS ALL DEFERRED;

-- Insertar datos en habilidad
INSERT INTO "habilidad" ("CodHab", "DesHab") VALUES
 ('FONTA','Fontanería'),
 ('GEREN','Gerencia'),
 ('GESCO','Gestión Contable'),
 ('MARKE','Marketing'),
 ('MECAN','Mecanografía'),
 ('RELPU','Relaciones Públicas'),
 ('TELEF','Telefonista'),
 ('INFOR','INFORMATICA');

-- Paso 1: Insertar centros SIN directores (CodEmpDir = NULL temporalmente)
INSERT INTO "centro" ("CodCen", "CodEmpDir", "NomCen", "DirCen", "PobCen") VALUES
 ('DIGE',NULL,'Dirección General','Av. Constitución 88','Murcia'),
 ('FAZS',NULL,'Fábrica Zona Sur','Pol. Ind. Gral. Bastarreche','Cartagena'),
 ('OFZS',NULL,'Oficinas Zona Sur','Pl. España 14','Cartagena');

-- Paso 2: Insertar departamentos SIN directores (CodEmpDir = NULL temporalmente)
INSERT INTO "departamento" ("CodDep", "CodEmpDir", "CodDepDep", "CodCen", "NomDep", "PreAnu", "TiDir") VALUES
 ('ADMZS',NULL,NULL,'OFZS','Administración Zona Sur',14000000,'P'),
 ('DIRGE',NULL,NULL,'DIGE','Dirección General',26000000,'P'),
 ('IN&DI',NULL,'DIRGE','DIGE','Investigación y Diseño',25000000,'P'),
 ('JEFZS',NULL,NULL,'FAZS','Jefatura Fábrica Zona Sur',6200000,'F'),
 ('PROZS',NULL,'JEFZS','FAZS','Producción Zona Sur',108000000,'P'),
 ('VENZS',NULL,'ADMZS','OFZS','Ventas Zona Sur',13500000,'F');

-- Paso 3: Insertar empleados
INSERT INTO "empleado" ("CodEmp", "CodDep", "ExTelEmp", "FecInEmp", "FecNaEmp", "NifEmp", "NomEmp", "NumHi", "SalEmp") VALUES
 (1,'DIRGE','1111','1972-07-01','1961-08-07','21451451V','Saladino Mandamás, Augusto',1,7200000),
 (2,'IN&DI','2233','1991-06-14','1970-06-08','21231347K','Manrique Bacterio, Luisa',0,4500000),
 (3,'VENZS','2133','1984-06-08','1965-12-07','23823930D','Monforte Cid, Roldán',1,5200000),
 (4,'VENZS','3838','1990-08-09','1975-02-21','38293923L','Topaz Illán, Carlos',0,3200000),
 (5,'ADMZS','1239','1976-08-07','1958-03-08','38223923T','Alada Veraz, Juana',1,6200000),
 (6,'JEFZS','23838','1991-08-01','1969-06-03','26454122D','Gozque Altanero, Cándido',1,5000000),
 (7,'PROZS',NULL,'1994-06-30','1975-08-07','47123132D','Forzado López, Galeote',0,1600000),
 (8,'PROZS',NULL,'1994-08-15','1976-06-15','32132154H','Mascullas Alto, Eloísa',1,1600000),
 (9,'PROZS','12124','1982-06-10','1968-07-19','11312121D','Mando Correa, Rosa',2,3100000),
 (10,'PROZS',NULL,'1993-11-02','1975-01-07','32939393D','Mosc Amuerta, Mario',0,1300000);

-- Actualizar la secuencia de empleado para que continúe desde el ID correcto
SELECT setval('"empleado_CodEmp_seq"', (SELECT MAX("CodEmp") FROM "empleado"));

-- Paso 4: Actualizar centros con sus directores
UPDATE "centro" SET "CodEmpDir" = 1 WHERE "CodCen" = 'DIGE';
UPDATE "centro" SET "CodEmpDir" = 6 WHERE "CodCen" = 'FAZS';
UPDATE "centro" SET "CodEmpDir" = 5 WHERE "CodCen" = 'OFZS';

-- Paso 5: Actualizar departamentos con sus directores
UPDATE "departamento" SET "CodEmpDir" = 5 WHERE "CodDep" = 'ADMZS';
UPDATE "departamento" SET "CodEmpDir" = 1 WHERE "CodDep" = 'DIRGE';
UPDATE "departamento" SET "CodEmpDir" = 2 WHERE "CodDep" = 'IN&DI';
UPDATE "departamento" SET "CodEmpDir" = 6 WHERE "CodDep" = 'JEFZS';
UPDATE "departamento" SET "CodEmpDir" = 9 WHERE "CodDep" = 'PROZS';
UPDATE "departamento" SET "CodEmpDir" = 3 WHERE "CodDep" = 'VENZS';

-- Insertar datos en hijo
INSERT INTO "hijo" ("CodEmp", "NumHij", "FecNaHi", "NomHi") VALUES
 (1,1,'1989-06-07','Saladino Oropel, Flavia'),
 (3,1,'1990-09-12','Monforte Lemos, Jesús'),
 (5,1,'1982-03-06','Pastora Alada, Mateo'),
 (8,1,'1994-03-14','Fuerte Mascullas, Anacleto'),
 (9,1,'1988-02-28','León Mando, Elvira'),
 (9,2,'1990-07-18','León Mando, Plácido');

-- Insertar datos en habemp
INSERT INTO "habemp" ("CodHab", "CodEmp", "NivHab") VALUES
 ('GEREN',1,10),
 ('RELPU',1,9),
 ('MARKE',3,9),
 ('GESCO',5,9),
 ('RELPU',5,8),
 ('FONTA',8,7);

-- Reactivar las restricciones y confirmar la transacción
COMMIT;