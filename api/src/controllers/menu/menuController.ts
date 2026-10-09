import { Request, Response } from "express";
import { LogTypes } from "../../commons/enum";
import { Header } from "../../commons/header";
import { Resp } from "../../commons/resp";
import { MenuRepositoryContract } from "../../repositories/MenuRepositoryContract";

class MenuController {
    constructor(private readonly repository: MenuRepositoryContract) {}

    async menu(request: Request, response: Response) {
        try {
            if (!(await Header.verificaHeader(request, true))) {
                return Resp.sendValidation(response, 400, "headerInvalido", true, LogTypes.SECURITY);
            }

            const retorno = await this.repository.menu();

            return Resp.send(response, 200, retorno);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "menu", LogTypes.ERROR, 1);
        }
    }
}

export { MenuController };
