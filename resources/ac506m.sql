-- Creación de la tabla DEPARTAMENTO en MySQL
CREATE TABLE DEPARTAMENTO (
    codD INT AUTO_INCREMENT, -- autoincrementable
    nombre VARCHAR(50) NOT NULL,
    direcc VARCHAR(100),
    
    -- Restricciones
    CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (codD)
);

-- Creación de la tabla EMPLEADO en MySQL
CREATE TABLE EMPLEADO (
    dni VARCHAR(9),
    nombrec VARCHAR(100) NOT NULL,
    salario DECIMAL(10, 2) DEFAULT 1000,
    direcc VARCHAR(100),
    departamento INT NOT NULL,
    
    -- Restricciones
    CONSTRAINT PK_EMPLEADO PRIMARY KEY (dni),
    CONSTRAINT UK_NOMBREC UNIQUE (nombrec),
    CONSTRAINT CK_SALARIO CHECK (salario >= 900),
    CONSTRAINT FK_DEPARTAMENTO FOREIGN KEY (departamento) REFERENCES DEPARTAMENTO(codD)
);
