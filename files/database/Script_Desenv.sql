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



SELECT jsonb_agg(
    jsonb_build_object(
        'menu_id', p.menu_id,
        'menu_nome', p.menu_nome,
        'menu_chave', p.menu_chave,
        'menu_icone', p.menu_icone,
        'menu_sequencia', p.menu_sequencia,
        'children',
        COALESCE(
            (
                SELECT jsonb_agg(
                    jsonb_build_object(
                        'menu_id', f.menu_id,
                        'menu_nome', f.menu_nome,
                        'menu_chave', f.menu_chave,
                        'menu_icone', f.menu_icone,
                        'menu_sequencia', f.menu_sequencia
                    )
                    ORDER BY f.menu_sequencia
                )
                FROM menu f
                WHERE f.menu_parent_id = p.menu_id
            ),
            '[]'::jsonb
        )
    )
    ORDER BY p.menu_sequencia
) AS menus
FROM menu p
WHERE p.menu_parent_id IS NULL;