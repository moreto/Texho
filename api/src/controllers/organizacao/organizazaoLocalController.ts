import { Request, Response } from "express";
import { OrganizacaoLocalRepository } from "../../repositories/organizacao/organizacaoLocalRepository";


 class OrganizacaoLocalController {
    async getTreeById(request: Request, response: Response) {
        try {
            const repository = new OrganizacaoLocalRepository();
            const idParam = Array.isArray(request.params.id) ? request.params.id[0] : request.params.id;
            const id = Number(idParam);

            if (Number.isNaN(id)) {
                return response.status(400).send({ message: "ID inválido." });
            }

            const retorno = await repository.getTreeById(id);

            return response.status(200).send(retorno);
        } catch (err: unknown) {
            return response.status(513).send(err);
        }
    }

        async get(request: Request, response: Response) {
        try {
            const repository = new OrganizacaoLocalRepository();

            const retorno = await repository.get();

            return response.status(200).send(retorno);
        } catch (err: unknown) {
            return response.status(513).send(err);
        }
    }
}

export { OrganizacaoLocalController };    