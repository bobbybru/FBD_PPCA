#5 - evolução de registros de covid confirmados por estado X uti x evolucao

select 	d.Estado_sigla,
		(case when a.evolucao=1 then 'cura'
			 when a.evolucao=2 then 'óbito'
             when a.evolucao=3 then 'óbito por outras causas'
             when a.evolucao=9 then 'ignorado'
             else 'não informado' end ) as evolucao,             
		count(a.id_registro) as total
from registro as a
left join unidade as b
	on a.unidade_id_unidade_saude=b.id_unidade_saude
left join municipio as d
	on b.Municipio_codigo1=d.codigo
left join internacao as e
	on a.id_registro = e.Registro_id_registro
where e.data_entrada_uti is not null
	  and a.classificacao=5
group by d.Estado_sigla,
		 a.evolucao
order by d.Estado_sigla
