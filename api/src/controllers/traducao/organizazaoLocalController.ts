import { Request, Response } from "express";
import { TraducaoRepository } from "../../repositories/traducao/organizacaoLocalRepository";


class TraducaoController {
    async get(request: Request, response: Response) {
        try {
            const repository = new TraducaoRepository();
            const retorno = await repository.get();
            return response.status(200).send(retorno);
        } catch (err: unknown) {
            return response.status(513).send(err);
        }
    }
}

export { TraducaoController };
