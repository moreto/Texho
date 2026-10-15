import { Database } from "../../commons/database";
import { NotificacaoModel } from "../../models/notificacaoModel";
import { NotificacaoRepositoryContract } from "../notificacaoRepositoryContracts";

class NotificacaoRepository implements NotificacaoRepositoryContract {
    async get() {
        try {
            const query = {
                text:
                    "SELECT n.noti_id, n.noti_data, n.noti_tipo, n.noti_texto, n.usua_id, n.log_id, l.log_tipo, l.log_info, l.log_texto " +
                    "FROM public.notificacao n " +
                    "LEFT OUTER JOIN public.log l ON n.log_id = l.log_id " +
                    "ORDER BY noti_id desc;",
                values: [],
            };
            return await Database.DbQueryList(query);
        } catch (error) {
            throw error;
        }
    }

    async getById(notiId: number) {
        try {
            const query = {
                text: "SELECT noti_id, noti_data, noti_tipo, noti_texto, usua_id, log_id FROM notificacao WHERE noti_id = $1;",
                values: [notiId],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }

    async post(model: NotificacaoModel) {
        try {
            const query = {
                text: "INSERT INTO notificacao (noti_texto, noti_tipo, usua_id, log_id) VALUES ($1, $2, $3, $4) RETURNING noti_id as id;",
                values: [model.notiTexto, model.notiTipo, model.usuaId, model.logId],
            };
            const result = await Database.DbQuery(query);
            const json = JSON.stringify(result);
            return json;
        } catch (error: unknown) {
            throw error;
        }
    }
}

export { NotificacaoRepository };
