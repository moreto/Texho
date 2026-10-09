import { Database } from "../../commons/database";
import { UsuarioRepositoryContract } from "../usuarioRepositoryContract";

class UsuarioRepository implements UsuarioRepositoryContract {
    async usuarioDetalheById(usuaId: number) {
        try {
            const query = {
                text:
                    " SELECT u.usua_id, u.usua_uuid, u.usua_email, u.usua_ativo, ud.udet_nome, ud.udet_usuario" +
                    "FROM public.usuario u INNER JOIN public.usuario_detalhe ud ON u.usua_id = ud.usua_id WHERE u.usua_id = $1;",
                values: [usuaId],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }
}

export { UsuarioRepository };
