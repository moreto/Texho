-- gen_random_uuid()

CREATE TRIGGER trgUpdateAt
BEFORE UPDATE ON menu
FOR EACH ROW
EXECUTE FUNCTION updatedAt();

ALTER DATABASE postgres
SET timezone TO 'America/Sao_Paulo';


-- log
SELECT log_id, log_tipo, log_data, log_info, usua_id, log_texto FROM public.log WHERE usua_id = 1 ORDER BY log_id DESC;


SELECT noti_id, noti_data, noti_tipo, noti_texto, usua_id, log_id
FROM public.notificacao ORDER BY noti_id DESC;


select row_to_json(row) from (
 SELECT * FROM public.empresa
) row;

SELECT * FROM public.menu m;
SELECT * FROM public.traducao t;
SELECT * FROM public.usuario;
SELECT * FROM public.usuario_detalhe ud ;
SELECT * FROM public.empresa e ;
SELECT * FROM public.empresa_usuario eu ;
SELECT * FROM public.usuario_dispositivo ud;
SELECT * FROM public.usuario_dispositivo_log udl;

SELECT t.created_at, t.updated_at  
FROM public.traducao t ORDER BY t.created_at DESC LIMIT 1;

SELECT encode( digest(concat_ws('|', t.created_at, t.updated_at), 'sha256'), 'hex') AS hash
FROM public.traducao t ORDER BY t.created_at DESC LIMIT 1;

