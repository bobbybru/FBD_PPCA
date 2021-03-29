DELIMITER $$

CREATE TRIGGER `update_data` AFTER UPDATE on `srag`.`pessoa`
FOR EACH ROW
BEGIN
    IF (OLD.nu_idade >110) THEN
        INSERT INTO log 
            (`id_pessoa` , `idade`) 
        VALUES 
            (OLD.id_pessoa, NEW.nu_idade);
    END IF;
END$$

DELIMITER ;