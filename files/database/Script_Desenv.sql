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
 SELECT * FROM public.usuario_dispositivo
) row;

SELECT * FROM public.usuario;
SELECT * FROM public.usuario_detalhe ud ;
SELECT * FROM public.empresa e ;
SELECT * FROM public.empresa_usuario eu ;
SELECT * FROM public.usuario_dispositivo ud;
SELECT * FROM public.usuario_dispositivo_log udl;

SELECT u.usua_id, u.usua_uuid, u.usua_email, u.usua_ativo, ud.udet_nome, ud.udet_usuario, e.empr_id, e.empr_nome 
FROM public.usuario u INNER JOIN public.usuario_detalhe ud ON u.usua_id = ud.usua_id 
INNER JOIN public.empresa_usuario eu ON eu.usua_id = u.usua_id 
INNER JOIN public.empresa e ON e.empr_id = eu.empr_id 
WHERE u.usua_id = 1;

SELECT * FROM empresa e ;
SELECT * FROM usuario_otp uo ;

SELECT noti_id, noti_data, noti_tipo, noti_texto, usua_id, log_id FROM notificacao ORDER BY noti_id;

SELECT noti_id, noti_data, noti_tipo, noti_texto, usua_id, log_id
FROM notificacao;

INSERT INTO log (log_tipo, log_data, log_info, usua_id, log_texto)
VALUES('', CURRENT_TIMESTAMP, '', 0, '');


SELECT noti_id, noti_data, noti_texto, noti_erro, noti_tipo, usua_id, log_id FROM notificacao;

SELECT noti_id, noti_data, noti_tipo, noti_texto, usua_id, log_id
FROM notificacao;

SELECT * FROM menu m ;

INSERT INTO public.usuario_dispositivo_log (udis_id, udlo_ip)
VALUES(0, '');
