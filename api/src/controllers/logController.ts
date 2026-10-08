import { Request, Response } from "express";

import { Resp } from "../commons/resp";
import { LogBodyModelConvert } from "../models/logBodyModel";
import { LogRepositoryContract } from "../repositories/logRepositoryContract";

export default class LogController {
    constructor(private readonly repository: LogRepositoryContract) {}

    async gravar(request: Request, response: Response) {
        try {
            const model = LogBodyModelConvert.toLogBodyModel(JSON.stringify(request.body));

            await this.repository.post(model);

            Resp.send(response, 200, "ok");
        } catch (error: unknown) {
            Resp.sendError(response, error, 500, "erroGeral", "0");
        }
    }
}
