delimiter $$

CREATE PROCEDURE proc_casos_unidade (IN DESCRICAO VARCHAR(150), OUT CASOS INT)
       BEGIN
         SELECT COUNT(a.id_registro) INTO CASOS 
         FROM registro as a
         LEFT JOIN unidade as b
			on a.unidade_id_unidade_saude=b.id_unidade_saude
         WHERE b.descricao like DESCRICAO;
       END $$

delimiter ;

#CALL casos_cidades(2082225, @casos); proc_casos_unidade