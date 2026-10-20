import { Database } from "../../commons/database";
import { TraducaoRepositoryContract } from "./traducaoRepositoryContracts";

class TraducaoRepository implements TraducaoRepositoryContract {
    async traducao() {
        const query = {
            text: "SELECT trad_chave, trad_pt_br, trad_es_es, trad_en_us FROM public.traducao WHERE trad_status = true ORDER BY trad_chave;",
            values: [],
        };
        try {
            return await Database.DbQueryList(query);
        } catch (error) {
            throw error;
        }
    }

    async hash() {
        const query = {
            text:
                "SELECT encode( digest(concat_ws('|', t.created_at, t.updated_at), 'sha256'), 'hex') AS hash " +
                "FROM public.traducao t ORDER BY t.created_at DESC LIMIT 1;",
            values: [],
        };
        try {
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }
}

export { TraducaoRepository };
