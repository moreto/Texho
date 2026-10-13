import { Database } from "../../commons/database";
import { EmpresaRepositoryContract } from "../empresaRepositoryContract";

class EmpresaRepository implements EmpresaRepositoryContract {
    async getById(emprId: number) {
        try {
            const query = {
                text: "SELECT empr_id, empr_uuid, empr_nome, created_at, updated_at FROM public.empresa WHERE empr_id = $1;",
                values: [emprId],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }
}

export { EmpresaRepository };
