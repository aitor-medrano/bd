DELIMITER //
CREATE OR REPLACE PROCEDURE cantidadDepartamentos()
    COMMENT "Recupera la cantidad de departamentos"
BEGIN
    -- Cuenta los departamentos
    SELECT count(*) FROM departamento;
END
//
DELIMITER ;

cantidadDepartamentos



DELIMITER //
CREATE OR REPLACE PROCEDURE generaCodigo(parteUno VARCHAR(32), parteDos VARCHAR(32))
    COMMENT "Genera un código con los tres primero de parteUno y los tres ultimos de parte dos"
BEGIN
    -- Cuenta los departamentos
    SELECT concat( parteUno, parteDos );
END
//
DELIMITER ;