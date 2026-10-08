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
SELECT usua_id, usua_email, usua_senha, usua_uuid, usua_ativo, usua_uuid FROM usuario u WHERE u.usua_email = 'mmoreto@gmail.com'
) row;

SELECT * FROM public.usuario;

SELECT * FROM empresa e ;
SELECT * FROM usuario_otp uo ;

INSERT INTO usuario (usua_email, usua_senha, usua_uuid)
VALUES('', '', '');


SELECT u.usua_id, u.usua_uuid, u.usua_email FROM usuario u WHERE u.usua_ativo = true and u.usua_email = 'mmoreto@gmail.com' AND u.usua_senha = '123';

INSERT INTO usuario_otp (usua_id, uotp_key) VALUES(0, 0);