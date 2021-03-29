create view srag.view_evol_casos_unidades as 
select  b.descricao as nome_unidade, 
		c.descricao as municipio,
        c.Estado_sigla as UF,
        c.codigo as cod_mun,
        (case when a.evolucao=1 then 'cura'
			 when a.evolucao=2 then 'óbito'
             when a.evolucao=3 then 'óbito por outras causas'
             when a.evolucao=9 then 'ignorado'
             else 'Não informado' end) as evolucao,
		count(a.id_registro) as total
from registro as a
left join srag.unidade as b
	on a.unidade_id_unidade_saude=b.id_unidade_saude
left join srag.municipio as c
	on b.Municipio_codigo1=c.codigo
group by a.unidade_id_unidade_saude, a.evolucao, b.descricao
order by a.unidade_id_unidade_saude
