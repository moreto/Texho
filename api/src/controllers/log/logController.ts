import { Request, Response } from "express";

import { LogTypes } from "../../commons/enum";
import { Header } from "../../commons/header";
import { Log } from "../../commons/log";
import { Resp } from "../../commons/resp";
import { LogBodyModelConvert } from "../../models/logBodyModel";
import { LogRepositoryContract } from "../../repositories/log/logRepositoryContract";

export default class LogController {
    constructor(private readonly repository: LogRepositoryContract) {}

    async gravar(request: Request, response: Response) {
        try {
            Log.printUrl(request);
            const model = LogBodyModelConvert.toLogBodyModel(JSON.stringify(request.body));

            await this.repository.post(model);

            return Resp.sendValidation(response, 200, "Ok");
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "log.gravar", LogTypes.ERROR, 1);
        }
    }

    async get(request: Request, response: Response) {
        try {
            Log.printUrl(request);
            const usuaId = await Header.getUsuario(request);
            const retorno = await this.repository.get(usuaId);

            return Resp.send(response, 200, retorno);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "log.get", LogTypes.ERROR, 1);
        }
    }
}
