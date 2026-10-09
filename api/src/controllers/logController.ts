import { Request, Response } from "express";

import { LogTypes } from "../commons/enum";
import { Resp } from "../commons/resp";
import { LogBodyModelConvert } from "../models/logBodyModel";
import { LogRepositoryContract } from "../repositories/logRepositoryContract";

export default class LogController {
    constructor(private readonly repository: LogRepositoryContract) {}

    async gravar(request: Request, response: Response) {
        try {
            const model = LogBodyModelConvert.toLogBodyModel(JSON.stringify(request.body));

            await this.repository.post(model);

            return Resp.sendValidation(response, 200, "Ok");
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "gravar", LogTypes.ERROR, 1);
        }
    }
}
