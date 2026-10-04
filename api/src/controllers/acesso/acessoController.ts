import bcrypt from "bcrypt";
import { Request, Response } from "express";
import { decryptString } from "../../commons/encrypt";
import { Log } from "../../commons/log";
import { Util } from "../../commons/util";
import { ConvertAcessoBodyModel } from "../../models/acesso/acessoBodyModel";
import { AcessoRepositoryContract } from "../../repositories/contracts";

class AcessoController {
    constructor(private readonly repository: AcessoRepositoryContract) {}

    SALT_ROUNDS = 12; // custo: cada +1 dobra o tempo de hash

    async hashPassword(password: string): Promise<string> {
        // o salt é gerado automaticamente e embutido no hash resultante
        return bcrypt.hash(password, this.SALT_ROUNDS);
    }

    async verifyPassword(password: string, hash: string): Promise<boolean> {
        return bcrypt.compare(password, hash);
    }

    async registro(request: Request, response: Response) {
        try {
            if (Util.isEmpty(request.body)) {
                return response.status(410).send({
                    message: "emailSenhaObrigatorios",
                });
            }

            const model = ConvertAcessoBodyModel.toAcessoBodyModel(JSON.stringify(request.body));

            if (Util.isEmpty(model.email) || Util.isEmpty(model.senha)) {
                return response.status(411).send({
                    message: "emailSenhaObrigatorios",
                });
            }

            Log.print(model.senha);
            const decripted = decryptString(model.senha, "5oAaa+hIOTQzGUxHYn8o6mHfQqEi9PXb4kBGpCQ+fn0=");

            const hash = await this.hashPassword(decripted);
            Log.print(hash);
            model.senha = hash;

            const retornoCheck = await this.repository.check(model.email);

            if (retornoCheck.emailExiste) {
                return response.status(412).send({
                    message: "emailJaCadastrado",
                });
            }

            await this.repository.register(model);

            const retorno = await this.repository.get(model.email);

            return response.status(200).send(retorno);
        } catch (err: unknown) {
            Log.printErro(err);
            return response.status(513).send(err);
        }
    }
}

export { AcessoController };
