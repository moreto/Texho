import { Request, Response } from "express";
import { OrganizacaoLocalRepositoryContract } from "../../repositories/contracts";

class OrganizacaoLocalController {
    constructor(
        private readonly repository: OrganizacaoLocalRepositoryContract,
    ) {}

    async getTreeById(request: Request, response: Response) {
        try {
            const idParam = Array.isArray(request.params.id)
                ? request.params.id[0]
                : request.params.id;
            const id = Number(idParam);

            if (Number.isNaN(id)) {
                return response.status(400).send({ message: "ID inválido." });
            }

            const retorno = await this.repository.getTreeById(id);

            return response.status(200).send(retorno);
        } catch (err: unknown) {
            return response.status(513).send(err);
        }
    }

    async get(request: Request, response: Response) {
        try {
            const retorno = await this.repository.get();

            return response.status(200).send(retorno);
        } catch (err: unknown) {
            return response.status(513).send(err);
        }
    }
}

export { OrganizacaoLocalController };
