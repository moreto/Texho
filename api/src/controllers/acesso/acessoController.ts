import bcrypt from "bcrypt";
import { Request, Response } from "express";
import { generateAdminToken, generateNoHeader, generateToken } from "../../commons/authorize";
import { decryptString } from "../../commons/encrypt";
import { LogTypes } from "../../commons/enum";
import { Resp } from "../../commons/resp";
import { Util } from "../../commons/util";
import * as Config from "../../configs/config.json";
import { ConvertAcessoBodyModel } from "../../models/acesso/acessoBodyModel";
import { LoginModel } from "../../models/acesso/loginModel";
import { ConvertUsuarioModel } from "../../models/acesso/usuarioModel";
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

            const decripted = decryptString(model.senha, Config.base64Key);

            const hash = await this.hashPassword(decripted);
            model.senha = hash;

            const retornoCheck = await this.repository.check(model.email);

            if (retornoCheck.emailExiste) {
                return Resp.sendValidation(response, 412, "emailJaCadastrado", true, LogTypes.VALIDATION);
            }

            await this.repository.register(model);

            const retorno = await this.repository.get(model.email);

            return Resp.send(response, 200, retorno);
        } catch (err: unknown) {
            return Resp.sendError(response, err, 500, "erroGeral", "registro", LogTypes.ERROR, 1);
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

            const decripted = decryptString(modelBody.senha, Config.base64Key);

            const isValid = await this.verifyPassword(decripted, senhaBCrypt);
            if (!isValid) return Resp.sendValidation(response, 401, "unauthorized", true, LogTypes.VALIDATION);

            const clientInterface = request.headers[Config.interfaceAcesso]?.toString();

            if (Util.isEmpty(clientInterface)) {
                return Resp.sendValidation(response, 400, "emailSenhaObrigatorios", true, LogTypes.VALIDATION);
            }

            let accessToken = "";
            if (clientInterface == "App") {
                accessToken = await generateToken(usuarioModel.usuaEmail);
            } else if (clientInterface == "Adm") {
                accessToken = await generateAdminToken(usuarioModel.usuaEmail);
            } else {
                accessToken = await generateNoHeader(usuarioModel.usuaEmail);
            }

            const loginModelBody: LoginModel = {
                usuaId: 1,
                token: accessToken,
            };

            return Resp.send(response, 200, loginModelBody);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "login", LogTypes.ERROR, 1);
        }
    }
}

export { AcessoController };
