import { Database } from "../../commons/database";
import {
    EmpresaUsuarioBodyModel,
    EmpresaUsuarioVinculoBodyModel,
} from "../../models/empresa/empresaUsuarioBodyModel";
import { EmpresaUsuarioRepositoryContract } from "./empresaUsuarioRepositoryContract";

class EmpresaUsuarioRepository implements EmpresaUsuarioRepositoryContract {
    async getByEmpresaUsuarioId(emprId: number) {
        const query = {
            text: "SELECT empr_id, usua_id FROM public.empresa_usuario WHERE empr_id = $1 ORDER BY usua_id;",
            values: [emprId],
        };
        return await Database.DbQueryList(query);
    }

    async getByEmpresaUsuarioIdDetalhe(emprId: number) {
        const query = {
            text:
                "SELECT e.empr_id, e.empr_nome, u.usua_id, u.usua_email, ud.udet_nome, ud.udet_usuario " +
                "FROM empresa e INNER JOIN empresa_usuario eu ON e.empr_id = eu.empr_id " +
                "INNER JOIN usuario u ON eu.usua_id = u.usua_id " +
                "LEFT OUTER JOIN usuario_detalhe ud ON u.usua_id = ud.usua_id " +
                "WHERE e.empr_id = $1 ORDER BY ud.udet_nome;",
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

    async vincular(usuaEmail: string, model: EmpresaUsuarioVinculoBodyModel) {
        const query = {
            text:
                "WITH empresa AS (" +
                "SELECT empr_id FROM public.empresa WHERE empr_codigo = $1" +
                "), usuario AS (" +
                "SELECT usua_id FROM public.usuario WHERE usua_email = $2" +
                "), vinculo AS (" +
                "INSERT INTO public.empresa_usuario (empr_id, usua_id) " +
                "SELECT e.empr_id, u.usua_id FROM empresa e CROSS JOIN usuario u " +
                "WHERE NOT EXISTS (" +
                "SELECT 1 FROM public.empresa_usuario eu " +
                "WHERE eu.empr_id = e.empr_id AND eu.usua_id = u.usua_id" +
                ") RETURNING empr_id, usua_id" +
                ") " +
                "SELECT (SELECT empr_id FROM empresa) AS empr_id, " +
                "(SELECT usua_id FROM usuario) AS usua_id, " +
                "EXISTS (SELECT 1 FROM usuario) AS usuario_encontrado, " +
                "EXISTS (SELECT 1 FROM empresa) AS empresa_encontrada, " +
                "EXISTS (SELECT 1 FROM vinculo) AS vinculado;",
            values: [model.empr_codigo, usuaEmail],
        };
        return await Database.DbQuery(query);
    }
}

export { EmpresaUsuarioRepository };
