import { Database } from "../../commons/database";
import { UsuarioDispositivoBodyModel } from "../../models/usuario/usuario_dispositivo_body_model";
import { UsuarioDispositivoLogRepositoryContract } from "../usuarioDispositivoLogRepositoryContract";

class UsuarioDispositivoLogRepository implements UsuarioDispositivoLogRepositoryContract {
    async post(model: UsuarioDispositivoBodyModel) {
        try {
            const query = {
                text: "INSERT INTO public.usuario_dispositivo_log (udis_id, udlo_ip) VALUES($1, $2);",
                values: [model.udisId, model.udloIp],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }
}

export { UsuarioDispositivoLogRepository };
