import { Database } from "../../commons/database";
import { UsuarioDispositivoRepositoryContract } from "../usuarioDispositivoRepositoryContract";

class UsuarioDispositivoRepository implements UsuarioDispositivoRepositoryContract {
    async post(usuaId: number) {
        try {
            const query = {
                text: "",
                values: [usuaId],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }
}

export { UsuarioDispositivoRepository };
