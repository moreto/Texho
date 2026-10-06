import { Request, Response } from "express";
import { TraducaoRepositoryContract } from "../../repositories/commonRepositoryContracts";


class TraducaoController {
    constructor(private readonly repository: TraducaoRepositoryContract) {}

    async get(request: Request, response: Response) {
        try {
            const retorno = await this.repository.get();
            return response.status(200).send(retorno);
        } catch (err: unknown) {
            return response.status(513).send(err);
        }
    }
}

export { TraducaoController };
