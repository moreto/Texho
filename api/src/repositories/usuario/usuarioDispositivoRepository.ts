import { Database } from "../../commons/database";
import { UsuarioDispositivoBodyModel } from "../../models/usuario/usuario_dispositivo_body_model";
import { UsuarioDispositivoRepositoryContract } from "../usuarioDispositivoRepositoryContract";

class UsuarioDispositivoRepository implements UsuarioDispositivoRepositoryContract {
    async getByDeviceId(deviceId: string) {
        try {
            const query = {
                text:
                    "SELECT udis_id, empr_id, udis_device_id, udis_nome, udis_sistema_operacional " +
                    "FROM public.usuario_dispositivo ud WHERE udis_device_id = $1;",
                values: [deviceId],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }

    async post(model: UsuarioDispositivoBodyModel) {
        try {
            const query = {
                text:
                    "INSERT INTO public.usuario_dispositivo (empr_id, udis_device_id, udis_nome, udis_sistema_operacional) " +
                    "VALUES($1, $2, $3, $4);",
                values: [model.emprId, model.udisDeviceId, model.udisNome, model.udisSistemaOperacional],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }
}

export { UsuarioDispositivoRepository };
