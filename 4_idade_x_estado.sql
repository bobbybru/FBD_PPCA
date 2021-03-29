#4 - Media de idade de casos confirmados por estado

select 	d.Estado_sigla,
		min(b.nu_idade) as min_idade,
		avg(b.nu_idade) as med_idade,
        max(b.nu_idade) as max_idade,
		count(a.id_registro) as total_casos
from registro as a
left join pessoa as b
	on a.Pessoa_id_pessoa =b.id_pessoa
left join unidade as c
	on a.unidade_id_unidade_saude=c.id_unidade_saude
left join municipio as d
	on c.Municipio_codigo1=d.codigo
where a.classificacao=5
group by d.Estado_sigla
order by d.Estado_sigla