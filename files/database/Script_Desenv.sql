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
 SELECT * FROM public.log
) row;

SELECT * FROM public.usuario;

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