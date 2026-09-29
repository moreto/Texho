import { Database } from "../../commons/database";

class TraducaoRepository {
    async get() {
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
}

export { TraducaoRepository };
