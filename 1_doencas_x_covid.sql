#1 - Quantos registros de doencas respiratorias X covid em qual intervalo.

select 	month(data_notificacao) as mes, 
        day(data_notificacao) as dia,
		(case when classificacao=5 then 'COVID-19'
			 when classificacao=1 then 'Influenza'
             when classificacao=2 then 'outro vírus respiratório'
             when classificacao=3 then 'outro agente etiológico'
             when classificacao=4 then 'não especificado'
             else 'não informado' end) as classe_srag,
		count(id_registro) as total_notificado
from registro as a
group by classificacao,
		 mes,
         dia
order by mes, dia, classificacao, total_notificado