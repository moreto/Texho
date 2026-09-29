BEGIN;

CREATE TEMP TABLE texho_traducao_seed (
    trad_chave text PRIMARY KEY,
    trad_pt_br text NOT NULL,
    trad_es_es text NOT NULL,
    trad_en_us text NOT NULL
) ON COMMIT DROP;

INSERT INTO texho_traducao_seed (trad_chave, trad_pt_br, trad_es_es, trad_en_us)
VALUES
    ('home', 'Home', 'Inicio', 'Home'),
    ('cep', 'CEP', 'Código postal', 'Postal code'),
    ('digiteCep', 'Digite o CEP', 'Introduce el código postal', 'Enter postal code'),
    ('buscaCep', 'Busca CEP', 'Buscar código postal', 'Search postal code'),
    ('login', 'Login', 'Iniciar sesión', 'Sign in'),
    ('efetueLogin', 'Efetue o login', 'Inicia sesión', 'Sign in to continue'),
    ('email', 'eMail', 'Correo electrónico', 'Email'),
    ('informeEmail', 'Informe o eMail', 'Introduce el correo electrónico', 'Enter your email'),
    ('senha', 'Senha', 'Contraseña', 'Password'),
    ('informeSenha', 'Informe a senha', 'Introduce la contraseña', 'Enter your password'),
    ('esqueceu', 'Esqueceu', '¿Olvidaste?', 'Forgot?'),
    ('fonte', 'Fonte', 'Fuente', 'Font'),
    ('sistema', 'Sistema', 'Sistema', 'System'),
    ('claro', 'Claro', 'Claro', 'Light'),
    ('escuro', 'Escuro', 'Oscuro', 'Dark'),
    ('idioma', 'Idioma', 'Idioma', 'Language');

UPDATE public.traducao AS target
SET trad_pt_br = seed.trad_pt_br,
    trad_es_es = seed.trad_es_es,
    trad_en_us = seed.trad_en_us,
    trad_status = true
FROM texho_traducao_seed AS seed
WHERE lower(target.trad_chave) = lower(seed.trad_chave);

INSERT INTO public.traducao (trad_chave, trad_pt_br, trad_es_es, trad_en_us, trad_status)
SELECT seed.trad_chave, seed.trad_pt_br, seed.trad_es_es, seed.trad_en_us, true
FROM texho_traducao_seed AS seed
WHERE NOT EXISTS (
    SELECT 1
    FROM public.traducao AS target
    WHERE lower(target.trad_chave) = lower(seed.trad_chave)
);

COMMIT;