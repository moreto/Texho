import { Database } from "../../commons/database";
import { EmpresaUsuarioBodyModel } from "../../models/empresa/empresaUsuarioBodyModel";
import { EmpresaUsuarioRepositoryContract } from "./empresaUsuarioRepositoryContract";

class EmpresaUsuarioRepository implements EmpresaUsuarioRepositoryContract {
    async getByEmpresaId(emprId: number) {
        const query = {
            text: "SELECT empr_id, usua_id FROM public.empresa_usuario WHERE empr_id = $1 ORDER BY usua_id;",
            values: [emprId],
        };
        return await Database.DbQueryList(query);
    }

    async post(emprId: number, model: EmpresaUsuarioBodyModel) {
        const query = {
            text: "INSERT INTO public.empresa_usuario (empr_id, usua_id) VALUES ($1, $2) RETURNING empr_id, usua_id;",
            values: [emprId, model.usua_id],
        };
        return await Database.DbQuery(query);
    }
}

export { EmpresaUsuarioRepository };
