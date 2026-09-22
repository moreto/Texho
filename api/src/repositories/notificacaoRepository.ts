import { Database } from "../commons/database";
import { NotificacaoModel } from "../models/notificacaoModel";

class NotificacaoRepository {

  async getById(notiId: number) {
    try {
      const query = {
        text: "SELECT noti_id, noti_data, noti_texto, noti_erro, noti_tipo, usua_id, log_id FROM notificacao WHERE noti_id = $1;",
        values: [notiId],
      };
      return await Database.DbQuery(query);
    } catch (error) {
      throw error;

    }
  }

  async post(model: NotificacaoModel) {
    try {
      let query = {
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
