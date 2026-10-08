import { Database } from "../../commons/database";
import { LogBodyModel } from "../../models/logBodyModel";
import { LogRepositoryContract } from "../logRepositoryContract";

class LogRepository implements LogRepositoryContract {
    async post(model: LogBodyModel) {
        try {
            const query = {
                text:
                    "INSERT INTO log (log_tipo, log_info, usua_id, log_texto) " +
                    "VALUES($1, $2, $3, $4) RETURNING log_id;",
                values: [model.log_tipo, model.log_info, model.usua_id, model.log_texto],
            };

            const ret = await Database.DbQuery(query);
            return ret;
        } catch (error: unknown) {
            throw error;
        }
    }
}

export { LogRepository };
