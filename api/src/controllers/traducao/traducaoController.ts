import { Request, Response } from "express";
import { LogTypes } from "../../commons/enum";
import { Log } from "../../commons/log";
import { Resp } from "../../commons/resp";
import { TraducaoRepositoryContract } from "../../repositories/traducao/traducaoRepositoryContracts";

class TraducaoController {
    constructor(private readonly repository: TraducaoRepositoryContract) {}

    async traducao(request: Request, response: Response) {
        try {
            Log.printUrl(request);
            const retorno = await this.repository.traducao();

            // return response.status(200).send(retorno);
            Resp.send(response, 200, retorno);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "traducao", LogTypes.ERROR, 1);
        }
    }

    async hash(request: Request, response: Response) {
        try {
            Log.printUrl(request);
            const retorno = await this.repository.hash();

            // return response.status(200).send(retorno);
            Resp.send(response, 200, retorno);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "hash", LogTypes.ERROR, 1);
        }
    }
}

export { TraducaoController };
