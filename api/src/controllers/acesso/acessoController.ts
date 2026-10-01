import { Request, Response } from "express";
import { Util } from "../../commons/util";
import { ConvertAcessoBodyModel } from "../../models/acesso/acessoBodyModel";
import { AcessoRepository } from "../../repositories/accesso/acessoRepository";

class AcessoController {
    async registro(request: Request, response: Response) {
        try {
            if (Util.isEmpty(request.body)) {
                return response.status(410).send({
                    message: "emailSenhaObrigatorios",
                });
            }

            const model = ConvertAcessoBodyModel.toAcessoBodyModel(
                JSON.stringify(request.body),
            );

            if (Util.isEmpty(model.email) || Util.isEmpty(model.senha)) {
                return response.status(411).send({
                    message: "emailSenhaObrigatorios",
                });
            }

            const repository = new AcessoRepository();

            let retorno = await repository.check(model);

            if (retorno.emailExiste) {
                return response.status(412).send({
                    message: "emailJaCadastrado",
                });
            }

            retorno = await repository.register(model);

            retorno = await repository.get(model);

            return response.status(200).send(retorno);
        } catch (err: unknown) {
            return response.status(513).send(err);
        }
    }
}

export { AcessoController };
