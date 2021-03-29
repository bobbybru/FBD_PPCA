#3 - Numero de casos covid (da consulta anterior)X comorbidades
select 	d.descricao,
		count(a.id_registro) as total_casos
from registro as a
left join pessoa as b
	on a.Pessoa_id_pessoa =b.id_pessoa
left join pessoa_has_fatoresriscos as c
	on b.id_pessoa=c.Pessoa_id_pessoa
left join fatoresriscos as d
	on c.FatoresRiscos_idFatoresRiscos =d.idFatoresRiscos
where a.classificacao=5 #CASOS DE COVID
	and d.descricao is not null
group by d.descricao
order by total_casos desc