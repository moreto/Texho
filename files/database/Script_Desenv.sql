-- gen_random_uuid()

CREATE TRIGGER trgUpdateAt
BEFORE UPDATE ON usuario_otp
FOR EACH ROW
EXECUTE FUNCTION updatedAt();



-- log
SELECT log_id, log_tipo, log_data, log_info, usua_id, log_texto
FROM public.log;


SELECT noti_id, noti_data, noti_tipo, noti_texto, usua_id, log_id
FROM public.notificacao;


select row_to_json(row) from (
 SELECT * FROM public.empresa
) row;

SELECT * FROM public.traducao t;
SELECT * FROM public.usuario;
SELECT * FROM public.usuario_detalhe ud ;
SELECT * FROM public.empresa e ;
SELECT * FROM public.empresa_usuario eu ;
SELECT * FROM public.usuario_dispositivo ud;
SELECT * FROM public.usuario_dispositivo_log udl;

SELECT empr_id, empr_uuid, empr_nome, created_at, updated_at FROM public.empresa WHERE empr_id = 1;

INSERT INTO public.empresa ( empr_uuid, empr_nome) VALUES( ?, '');


UPDATE public.empresa SET empr_uuid=?, empr_nome='' WHERE empr_id=$1;






