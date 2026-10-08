import bcrypt from "bcrypt";
import { Request, Response } from "express";
import { decryptString } from "../../commons/encrypt";
import { LogTypes } from "../../commons/enum";
import { Resp } from "../../commons/resp";
import { Util } from "../../commons/util";
import { ConvertAcessoBodyModel } from "../../models/acesso/acessoBodyModel";
import { ConvertUsuarioModel } from "../../models/acesso/acessoModel";
import { AcessoRepositoryContract } from "../../repositories/acessoRepositoryContracts";

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
                return Resp.sendValidation(response, 400, "emailSenhaObrigatorios", true, LogTypes.VALIDATION);
            }

            const model = ConvertAcessoBodyModel.toAcessoBodyModel(JSON.stringify(request.body));

            if (Util.isEmpty(model.email) || Util.isEmpty(model.senha)) {
                return Resp.sendValidation(response, 400, "emailSenhaObrigatorios", true, LogTypes.VALIDATION);
            }

            const decripted = decryptString(model.senha, "5oAaa+hIOTQzGUxHYn8o6mHfQqEi9PXb4kBGpCQ+fn0=");

            const hash = await this.hashPassword(decripted);
            model.senha = hash;

            const retornoCheck = await this.repository.check(model.email);

            if (retornoCheck.emailExiste) {
                return Resp.sendValidation(response, 412, "emailJaCadastrado", true, LogTypes.VALIDATION);
            }

            await this.repository.register(model);

            const retorno = await this.repository.get(model.email);

            Resp.send(response, 200, retorno);
        } catch (err: unknown) {
            Resp.sendError(response, err, 500, "erroGeral", "registro", LogTypes.ERROR, 1);
        }
    }

    //K7Ve3YdepFJYDDJxcbHTKMkN/H8Y3L/xkfOAzbOr1g==
    //Qor0MmB/yoY0ppw0bZbWugSEPnnFPbhQUfgmVZMMOA==
    async login(request: Request, response: Response) {
        try {
            if (Util.isEmpty(request.body)) {
                return Resp.sendValidation(response, 400, "emailSenhaObrigatorios", true, LogTypes.VALIDATION);
            }

            const modelBody = ConvertAcessoBodyModel.toAcessoBodyModel(JSON.stringify(request.body));

            if (Util.isEmpty(modelBody.email) || Util.isEmpty(modelBody.senha)) {
                return Resp.sendValidation(response, 400, "emailSenhaObrigatorios", true, LogTypes.VALIDATION);
            }

            const retorno = await this.repository.get(modelBody.email);

            const usuarioModel = ConvertUsuarioModel.toUsuarioModel(JSON.stringify(retorno));
            const senhaBCrypt = usuarioModel.usuaSenha;

            const decripted = decryptString(modelBody.senha, "5oAaa+hIOTQzGUxHYn8o6mHfQqEi9PXb4kBGpCQ+fn0=");

            const isValid = await this.verifyPassword(decripted, senhaBCrypt);
            if (!isValid) return Resp.sendValidation(response, 401, "unauthorized", true, LogTypes.VALIDATION);

            Resp.sendValidation(response, 200, "Ok");
        } catch (error: unknown) {
            Resp.sendError(response, error, 500, "erroGeral", "login", LogTypes.ERROR, 1);
        }
    }
}

export { AcessoController };
