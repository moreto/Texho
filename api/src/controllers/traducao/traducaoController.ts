import { Request, Response } from "express";
import { LogTypes } from "../../commons/enum";
import { Resp } from "../../commons/resp";
import { TraducaoRepositoryContract } from "../../repositories/commonRepositoryContracts";

class TraducaoController {
    constructor(private readonly repository: TraducaoRepositoryContract) {}

    async traducao(request: Request, response: Response) {
        try {
            const retorno = await this.repository.get();

            return response.status(200).send(retorno);
        } catch (error: unknown) {
            Resp.sendError(response, error, 500, "erroGeral", "traducao", LogTypes.ERROR, 1);
        }
    }
}

export { TraducaoController };
