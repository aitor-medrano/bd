-- Tabla DEPARTAMENTO con UUID como clave primaria
CREATE TABLE DEPARTAMENTO (
    codD UUID PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direcc VARCHAR(200)
);

-- Tabla EMPLEADO con UUID como clave foránea
CREATE TABLE EMPLEADO (
    dni VARCHAR(20) PRIMARY KEY,
    nombrec VARCHAR(100) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    direcc VARCHAR(200),
    departamento UUID NOT NULL,
    CONSTRAINT fk_empleado_departamento 
        FOREIGN KEY (departamento) 
        REFERENCES DEPARTAMENTO(codD)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);