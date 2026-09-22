import { Database } from "../commons/database";
import { Log } from "../commons/log";
import { LogBodyModel } from "../models/logBodyModel";

class LogDbRepository {

  // objeto: Object, logTipo: string, usuaId: number, texto: string
  async post(model: LogBodyModel) {
    try {
      let query = {
        text: "INSERT INTO log (log_data, log_tipo, log_info, usua_id, log_texto) VALUES (CURRENT_TIMESTAMP, $1, $2, $3, $4) RETURNING log_id;",
        values: [model.logTipo, model.objeto, model.usuaId, model.texto],
      };

      let ret = await Database.DbQuery(query);
      return ret;
    } catch (error: unknown) {
      Log.printErro(error);
    }
  }
}

export { LogDbRepository };
