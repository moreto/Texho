import { Request, Response } from "express";
import { LogTypes } from "../../commons/enum";
import { Header } from "../../commons/header";
import { Resp } from "../../commons/resp";
import { UsuarioRepositoryContract } from "../../repositories/usuarioRepositoryContract";

class UsuarioController {
    constructor(private readonly repository: UsuarioRepositoryContract) {}

    async usuarioDetalheById(request: Request, response: Response) {
        try {
            if (!(await Header.verificaHeader(request, true))) {
                return Resp.sendValidation(response, 400, "headerInvalido", true, LogTypes.SECURITY);
            }

            const usuaId = await Header.getUsuario(request);

            const retorno = await this.repository.usuarioDetalheById(usuaId);

            return Resp.send(response, 200, retorno);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "usuarioDetalheById", LogTypes.ERROR, 1);
        }
    }
}

export { UsuarioController };
