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
    ('idioma', 'Idioma', 'Idioma', 'Language'),
    ('error', 'Erro', 'Error', 'Error'),
    ('ok', 'OK', 'Aceptar', 'OK'),
    ('voltar', 'Voltar', 'Volver', 'Back'),
    ('ocultarAcoes', 'Ocultar ações inferiores', 'Ocultar acciones inferiores', 'Hide bottom actions'),
    ('exibirAcoes', 'Exibir ações inferiores', 'Mostrar acciones inferiores', 'Show bottom actions'),
    ('tema', 'Tema', 'Tema', 'Theme'),
    ('registro', 'Cadastro', 'Registro', 'Registration'),
    ('efetueRegistro', 'Informe os dados para registro', 'Proporciona los datos de registro', 'Provide your registration details'),
    ('confirmeSenha', 'Confirme a senha', 'Confirma la contraseña', 'Confirm password'),
    ('informeConfirmacaoSenha', 'Confirme a senha', 'Confirma la contraseña', 'Confirm your password'),
    ('esqueceuSenhaCodigo', 'Esqueceu a senha? Use código', '¿Olvidaste tu contraseña? Usa código', 'Forgot password? Use a code'),
    ('informeCodigo6Digitos', 'Informe os 6 dígitos', 'Ingresa los 6 dígitos', 'Enter the 6 digits'),
    ('codigoAcesso', 'Código de acesso', 'Código de acceso', 'Access code'),
    ('digiteCodigoEnviado', 'Digite o código enviado', 'Ingresa el código enviado', 'Enter the code sent'),
    ('enviaremosCodigoAcesso', 'Enviaremos um código', 'Te enviaremos un código', 'We will send you a code'),
    ('reenviarCodigo', 'Reenviar código', 'Reenviar código', 'Resend code'),
    ('enviarCodigo', 'Enviar código', 'Enviar código', 'Send code'),
    ('voltarSenha', 'Voltar para senha', 'Volver a contraseña', 'Back to password'),
    ('criarConta', 'Criar conta', 'Crear cuenta', 'Create account'),
    ('codigoEnviadoSeguro', 'Se cadastrado, enviaremos o código', 'Si existe, enviaremos el código', 'If registered, we will send a code'),
    ('tentarNovamente', 'Tentar novamente', 'Intentar de nuevo', 'Try again'),
    ('rotaNaoDefinida', 'Rota não definida', 'Ruta no definida', 'Route not defined'),
    ('nenhumMenuDisponivel', 'Nenhum menu disponível', 'No hay menú disponible', 'No menu available'),
    ('falhaCarregarMenu', 'Não foi possível carregar o menu', 'No se pudo cargar el menú', 'Could not load the menu'),
    ('notificacao', 'Notificação', 'Notificación', 'Notification'),
    ('notificacoes', 'Notificações', 'Notificaciones', 'Notifications'),
    ('atualizarNotificacoes', 'Atualizar notificações', 'Actualizar notificaciones', 'Refresh notifications'),
    ('falhaCarregarAvisos', 'Não foi possível carregar avisos', 'No se pudieron cargar avisos', 'Could not load notifications'),
    ('semNotificacoes', 'Nenhuma notificação encontrada', 'No se encontraron notificaciones', 'No notifications found'),
    ('logAssociado', 'Log associado', 'Registro asociado', 'Related log'),
    ('tipo', 'Tipo', 'Tipo', 'Type'),
    ('descricao', 'Descrição', 'Descripción', 'Description'),
    ('semLogAssociado', 'Sem log associado', 'Sin registro asociado', 'No related log'),
    ('log', 'Log', 'Registro', 'Log'),
    ('atualizarLogs', 'Atualizar logs', 'Actualizar registros', 'Refresh logs'),
    ('falhaCarregarLogs', 'Não foi possível carregar logs', 'No se pudieron cargar registros', 'Could not load logs'),
    ('nenhumLogEncontrado', 'Nenhum log encontrado', 'No se encontraron registros', 'No logs found'),
    ('empresa', 'Empresa', 'Empresa', 'Company'),
    ('usuarios', 'Usuários', 'Usuarios', 'Users'),
    ('atualizarEmpresa', 'Atualizar empresa', 'Actualizar empresa', 'Refresh company'),
    ('cadastrarEmpresa', 'Cadastrar empresa', 'Registrar empresa', 'Register company'),
    ('dadosEmpresa', 'Dados da empresa', 'Datos de la empresa', 'Company details'),
    ('codigo', 'Código', 'Código', 'Code'),
    ('nomeEmpresa', 'Nome da empresa', 'Nombre de la empresa', 'Company name'),
    ('informeNomeEmpresa', 'Informe o nome da empresa', 'Ingresa el nombre de la empresa', 'Enter the company name'),
    ('salvando', 'Salvando...', 'Guardando...', 'Saving...'),
    ('salvarAlteracoes', 'Salvar alterações', 'Guardar cambios', 'Save changes'),
    ('falhaConsultarEmpresa', 'Não foi possível consultar a empresa.', 'No se pudo consultar la empresa.', 'Could not load company.'),
    ('atualizeAntesCadastrar', 'Atualize os dados antes de cadastrar.', 'Actualiza los datos antes de registrar.', 'Refresh the data before registering.'),
    ('nenhumaEmpresaCadastrada', 'Nenhuma empresa cadastrada', 'No hay empresa registrada', 'No company registered'),
    ('preenchaNomeParaCriar', 'Preencha o nome para criar uma empresa', 'Ingresa el nombre para crear una empresa', 'Enter a name to create one'),
    ('falhaCarregarUsuarios', 'Não foi possível carregar usuários', 'No se pudieron cargar usuarios', 'Could not load users'),
    ('nenhumUsuarioVinculado', 'Nenhum usuário vinculado', 'Ningún usuario vinculado', 'No linked users'),
    ('atualizarUsuarios', 'Atualizar usuários', 'Actualizar usuarios', 'Refresh users'),
    ('empresaCadastrada', 'Empresa cadastrada com sucesso', 'Empresa registrada correctamente', 'Company registered successfully'),
    ('empresaAtualizada', 'Empresa atualizada com sucesso', 'Empresa actualizada correctamente', 'Company updated successfully'),
    ('vincularEmpresa', 'Vincular empresa', 'Vincular empresa', 'Link company'),
    ('vinculeContaEmpresa', 'Vincule sua conta à empresa', 'Vincula tu cuenta a la empresa', 'Link your account to a company'),
    ('informeCodigoVinculo', 'Informe o código para vincular', 'Ingresa el código para vincular', 'Enter the code to link'),
    ('codigoEmpresa', 'Código da empresa', 'Código de la empresa', 'Company code'),
    ('informeCodigoEmpresa', 'Informe o código da empresa', 'Ingresa el código de la empresa', 'Enter the company code'),
    ('vinculando', 'Vinculando...', 'Vinculando...', 'Linking...'),
    ('vincular', 'Vincular', 'Vincular', 'Link'),
    ('vinculoRealizado', 'Vínculo realizado com sucesso', 'Vínculo realizado correctamente', 'Link completed successfully'),
    ('defaultAppError', 'Ocorreu um erro', 'Ocurrió un error', 'An error occurred'),
    ('erroApi', 'Falha na solicitação', 'Error en la solicitud', 'Request failed'),
    ('respostaApiInvalida', 'Resposta da API inválida', 'Respuesta de API inválida', 'Invalid API response'),
    ('formatoLogInvalido', 'Formato de log inválido', 'Formato de registro inválido', 'Invalid log format'),
    ('formatoNotificacaoInvalido', 'Formato de notificação inválido', 'Formato de notificación inválido', 'Invalid notification format'),
    ('formatoUsuarioInvalido', 'Formato de usuário inválido', 'Formato de usuario inválido', 'Invalid user format'),
    ('connectionTimeout', 'Tempo de conexão esgotado', 'Tiempo de conexión agotado', 'Connection timed out'),
    ('sendTimeout', 'Tempo de envio esgotado', 'Tiempo de envío agotado', 'Send timed out'),
    ('receiveTimeout', 'Tempo de resposta esgotado', 'Tiempo de respuesta agotado', 'Response timed out'),
    ('transformTimeout', 'Tempo de processamento esgotado', 'Tiempo de proceso agotado', 'Processing timed out'),
    ('badCertificate', 'Certificado inválido', 'Certificado inválido', 'Invalid certificate'),
    ('badResponse', 'Resposta inválida', 'Respuesta inválida', 'Invalid response'),
    ('connectionError', 'Erro de conexão', 'Error de conexión', 'Connection error'),
    ('unknown', 'Erro desconhecido', 'Error desconocido', 'Unknown error'),
    ('cancel', 'Solicitação cancelada', 'Solicitud cancelada', 'Request cancelled');

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