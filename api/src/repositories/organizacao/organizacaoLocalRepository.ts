import { Database } from "../../commons/database";


class OrganizacaoLocalRepository {

  async getTreeById(notiId: number) {
    try {
      const query = {
        text: "SELECT public.get_tree($1) as tree;",
        values: [notiId],
      };
      return await Database.DbQuery(query);
    } catch (error) {
      throw error;

    }
  }

    async get() {
    try {
      const query = {
        text: "SELECT oloc_id, orga_id, oloc_nome, oloc_parent_id FROM public.organizacao_local;",
        values: [],
      };
      return await Database.DbQueryList(query);
    } catch (error) {
      throw error;

    }
  }
}

export { OrganizacaoLocalRepository };
