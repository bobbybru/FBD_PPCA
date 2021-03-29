#2 - Numero de casos covid X obitos por estado e por nivel de instrucao

select 	d.Estado_sigla,
		b.escolaridade,
        (case when escolaridade=0 then 'Sem escolaridade/ Analfabeto'
			 when escolaridade=1 then 'Fundamental 1º ciclo (1ª a 5ª série)'
             when escolaridade=2 then 'Fundamental 2º ciclo (6ª a 9ª série)'
             when escolaridade=3 then 'Médio (1º ao 3º ano)'
             when escolaridade=5 then 'Não se aplica'
             when escolaridade=4 then 'Superior'
             when escolaridade=9 then 'Ignorado'
             else 'não informado' end) as classe_srag,
		count(a.id_registro) as total_obito
from registro as a
left join pessoa as b
	on a.Pessoa_id_pessoa =b.id_pessoa
left join unidade as c
	on a.unidade_id_unidade_saude=c.id_unidade_saude
left join municipio as d
	on c.Municipio_codigo1=d.codigo
where a.evolucao=2
group by d.Estado_sigla,
		 b.escolaridade
order by d.Estado_sigla,
		 b.escolaridade