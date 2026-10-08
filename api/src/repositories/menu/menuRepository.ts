import { Database } from "../../commons/database";
import { MenuRepositoryContract } from "../MenuRepositoryContract";

class MenuRepository implements MenuRepositoryContract {
    async menu() {
        try {
            const query = {
                text:
                    " SELECT jsonb_agg(" +
                    " jsonb_build_object(" +
                    " 'menuId', p.menu_id," +
                    " 'menuNome', p.menu_nome," +
                    " 'menuChave', p.menu_chave," +
                    " 'menuIcone', p.menu_icone," +
                    " 'menuSequencia', p.menu_sequencia," +
                    " 'children'," +
                    " COALESCE(" +
                    " (" +
                    " SELECT jsonb_agg(" +
                    " jsonb_build_object(" +
                    " 'menuId', f.menu_id," +
                    " 'menuNome', f.menu_nome," +
                    " 'menuChave', f.menu_chave," +
                    " 'menuIcone', f.menu_icone," +
                    " 'menuSequencia', f.menu_sequencia" +
                    " )" +
                    " ORDER BY f.menu_sequencia" +
                    " )" +
                    " FROM menu f" +
                    " WHERE f.menu_parent_id = p.menu_id" +
                    " )," +
                    " '[]'::jsonb" +
                    " )" +
                    " )" +
                    " ORDER BY p.menu_sequencia" +
                    " ) AS menu" +
                    " FROM menu p" +
                    " WHERE p.menu_parent_id IS NULL;",
                values: [],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }
}

export { MenuRepository };
