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
    CREATE OR REPLACE PROCEDURE generaCodigo(parteUno VARCHAR(32), parteDos VARCHAR(32), OUT resultado VARCHAR(6))
        COMMENT "Genera un código con los tres primero de parteUno y los tres ultimos de parte dos"
    BEGIN
        -- Cuenta los departamentos
        SET resultado = concat( substring(parteUno,1,3) , substring(parteDos,-3) );
    END
    //
    DELIMITER ;

    call generaCodigo("Diego","Jonathan", @tarde);
    select @tarde;