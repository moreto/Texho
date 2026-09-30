import { Request, Response } from "express";
import { ConvertAcessoBodyModel } from "../../models/acesso/acessoBodyModel";
import { AcessoRepository } from "../../repositories/accesso/acessoRepository";

class AcessoController {
    async registro(request: Request, response: Response) {
        try {
            const body: unknown = request.body;
            if (typeof body !== "object" || body === null) {
                return response.status(401).send({
                    message: "Email e senha são obrigatórios.",
                });
            }

            const { email, senha } = body as Record<string, unknown>;
            if (
                typeof email !== "string" ||
                email.trim() === "" ||
                typeof senha !== "string" ||
                senha.trim() === ""
            ) {
                return response.status(402).send({
                    message: "Email e senha são obrigatórios.",
                });
            }

            const repository = new AcessoRepository();

            const model = ConvertAcessoBodyModel.toAcessoBodyModel(
                JSON.stringify(body),
            );

            let retorno = await repository.register(model);

            retorno = await repository.get(model);

            return response.status(200).send(retorno);
        } catch (err: unknown) {
            return response.status(513).send(err);
        }
    }
}

export { AcessoController };
