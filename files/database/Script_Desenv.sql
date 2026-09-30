-- gen_random_uuid()

CREATE TRIGGER trgUpdateAt
BEFORE UPDATE ON empresa
FOR EACH ROW
EXECUTE FUNCTION updatedAt();



-- log
SELECT log_id, log_tipo, log_data, log_info, usua_id, log_texto
FROM public.log;


SELECT noti_id, noti_data, noti_tipo, noti_texto, usua_id, log_id
FROM public.notificacao;


select row_to_json(row) from (
select * from public.notificacao c
) row;

SELECT * FROM public.usuario;
SELECT * FROM empresa e ;




INSERT INTO public.empresa
(empr_uuid, empr_nome, created_at, updated_at)
VALUES(gen_random_uuid(), 'mmoreto.com.br', CURRENT_TIMESTAMP, null);

UPDATE public.empresa
SET empr_nome='mmoreto.com.br'
WHERE empr_id=1;