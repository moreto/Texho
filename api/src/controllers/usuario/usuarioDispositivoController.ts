import { Request, Response } from "express";
import { LogTypes } from "../../commons/enum";
import { Header } from "../../commons/header";
import { Resp } from "../../commons/resp";
import { UsuarioDispositivoBodyModelConvert } from "../../models/usuario/usuario_dispositivo_body_model";
import { UsuarioDispositivoLogRepositoryContract } from "../../repositories/usuarioDispositivoLogRepositoryContract";
import { UsuarioDispositivoRepositoryContract } from "../../repositories/usuarioDispositivoRepositoryContract";

class UsuarioDispositivoController {
    constructor(
        private readonly repository: UsuarioDispositivoRepositoryContract,
        private readonly repositoryLog: UsuarioDispositivoLogRepositoryContract,
    ) {}

    async post(request: Request, response: Response) {
        try {
            if (!(await Header.verificaHeader(request, true))) {
                return Resp.sendValidation(response, 400, "headerInvalido", true, LogTypes.SECURITY);
            }

            const modelBody = UsuarioDispositivoBodyModelConvert.toUsuarioDispositivoBodyModel(
                JSON.stringify(request.body),
            );

            let retorno = await this.repository.getByDeviceId(modelBody.udisDeviceId);
            if (retorno != undefined) {
                const modelBodyCheck = UsuarioDispositivoBodyModelConvert.toUsuarioDispositivoBodyModel(
                    JSON.stringify(retorno),
                );
                await this.repositoryLog.post(modelBodyCheck);
                return Resp.send(response, 200, modelBodyCheck);
            } else {
                retorno = await this.repository.post(modelBody);
                retorno = await this.repository.getByDeviceId(modelBody.udisDeviceId);
                await this.repositoryLog.post(modelBody);
                return Resp.send(response, 200, retorno);
            }
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "udis.post", LogTypes.ERROR, 1);
        }
    }
}

export { UsuarioDispositivoController };
