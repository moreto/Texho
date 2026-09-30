import { Database } from "../../commons/database";
import { AcessoBodyModel } from "../../models/acesso/acessoBodyModel";

class AcessoRepository {
    async login(model: AcessoBodyModel) {
        try {
            const query = {
                text:
                    "SELECT u.usua_id, u.usua_uuid, u.usua_email FROM usuario u " +
                    "WHERE u.usua_ativo = true and u.usua_email = $1 AND u.usua_senha = $2;",
                values: [model.email, model.senha],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }

    async register(model: AcessoBodyModel) {
        try {
            const query = {
                text:
                    "INSERT INTO usuario (usua_email, usua_senha, usua_uuid) " +
                    "VALUES($1, $2, gen_random_uuid());",
                values: [model.email, model.senha],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }

    async get(model: AcessoBodyModel) {
        try {
            const query = {
                text:
                    "SELECT u.usua_id, u.usua_uuid, u.usua_email FROM usuario u " +
                    "WHERE u.usua_ativo = false and u.usua_email = $1 AND u.usua_senha = $2;",
                values: [model.email, model.senha],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }
}

export { AcessoRepository };
