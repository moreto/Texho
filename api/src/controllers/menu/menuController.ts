import { Request, Response } from "express";
import { LogTypes } from "../../commons/enum";
import { Resp } from "../../commons/resp";
import { MenuRepositoryContract } from "../../repositories/MenuRepositoryContract";

class MenuController {
    constructor(private readonly repository: MenuRepositoryContract) {}

    async menu(request: Request, response: Response) {
        try {
            const retorno = await this.repository.menu();

            Resp.send(response, 200, retorno);
        } catch (error: unknown) {
            Resp.sendError(response, error, 500, "erroGeral", "menu", LogTypes.ERROR, 1);
        }
    }
}

export { MenuController };
