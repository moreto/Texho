import { Database } from "../../commons/database";
import { EmpresaBodyModel } from "../../models/empresa/empresaBodyModel";
import { EmpresaModel } from "../../models/empresa/empresaModel";
import { EmpresaRepositoryContract } from "./empresaRepositoryContract";

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

    async post(model: EmpresaBodyModel) {
        try {
            const query = {
                text: "INSERT INTO public.empresa ( empr_uuid, empr_nome) VALUES ( gen_random_uuid(), $1) RETURNING empr_id, empr_uuid, empr_nome;",
                values: [model.empr_nome],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }

    async put(model: EmpresaModel) {
        try {
            const query = {
                text: "UPDATE public.empresa SET empr_nome=$1 WHERE empr_id=$2 RETURNING empr_id, empr_uuid, empr_nome;",
                values: [model.empr_nome, model.empr_id],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }
}

export { EmpresaRepository };
