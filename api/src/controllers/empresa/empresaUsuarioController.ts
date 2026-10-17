import { Request, Response } from "express";
import { decodeToken } from "../../commons/authorize";
import { LogTypes } from "../../commons/enum";
import { Header } from "../../commons/header";
import { Log } from "../../commons/log";
import { Resp } from "../../commons/resp";
import * as Config from "../../configs/config.json";
import {
    EmpresaUsuarioBodyModel,
    EmpresaUsuarioVinculoBodyModel,
} from "../../models/empresa/empresaUsuarioBodyModel";
import { EmpresaUsuarioRepositoryContract } from "../../repositories/empresa/empresaUsuarioRepositoryContract";

class EmpresaUsuarioController {
    constructor(private readonly repository: EmpresaUsuarioRepositoryContract) {}

    async getByEmpresaId(request: Request, response: Response) {
        try {
            Log.printUrl(request);
            if (!(await Header.verificaHeader(request, true))) {
                return Resp.sendValidation(response, 400, "headerInvalido", true, LogTypes.SECURITY);
            }

            const emprId = await Header.getEpresa(request);
            const retorno = await this.repository.getByEmpresaUsuarioId(emprId);
            return Resp.send(response, 200, retorno);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "empr_usua.getByEmpresaId", LogTypes.ERROR, 1);
        }
    }

    async getByEmpresaIdDetalhe(request: Request, response: Response) {
        try {
            Log.printUrl(request);
            if (!(await Header.verificaHeader(request, true))) {
                return Resp.sendValidation(response, 400, "headerInvalido", true, LogTypes.SECURITY);
            }

            const emprId = await Header.getEpresa(request);
            const retorno = await this.repository.getByEmpresaUsuarioIdDetalhe(emprId);
            return Resp.send(response, 200, retorno);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "empr_usua.getByEmpresaIdFull", LogTypes.ERROR, 1);
        }
    }

    async post(request: Request, response: Response) {
        try {
            Log.printUrl(request);
            if (!(await Header.verificaHeader(request, true))) {
                return Resp.sendValidation(response, 400, "headerInvalido", true, LogTypes.SECURITY);
            }

            const body: unknown = request.body;
            if (
                typeof body !== "object" ||
                body === null ||
                !("usua_id" in body) ||
                typeof body.usua_id !== "number" ||
                !Number.isInteger(body.usua_id) ||
                body.usua_id <= 0
            ) {
                return Resp.sendValidation(response, 400, "usuaIdInvalido");
            }
            const model: EmpresaUsuarioBodyModel = { usua_id: body.usua_id };

            const emprId = await Header.getEpresa(request);
            const retorno = await this.repository.post(emprId, model);
            return Resp.send(response, 200, retorno);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "empr_usua.post", LogTypes.ERROR, 1);
        }
    }

    async vincular(request: Request, response: Response) {
        try {
            Log.printUrl(request);
            if (!(await Header.verificaHeader(request, true, false))) {
                return Resp.sendValidation(response, 400, "headerInvalido", true, LogTypes.SECURITY);
            }

            const body: unknown = request.body;
            if (
                typeof body !== "object" ||
                body === null ||
                !("empr_codigo" in body) ||
                typeof body.empr_codigo !== "string" ||
                body.empr_codigo.trim().length === 0
            ) {
                return Resp.sendValidation(response, 400, "codigoObrigatorio", true, LogTypes.VALIDATION);
            }

            const token = request.headers[Config.token]?.toString();
            const payload = token ? await decodeToken(token) : null;
            if (
                typeof payload !== "object" ||
                payload === null ||
                !("data" in payload) ||
                typeof payload.data !== "string"
            ) {
                return Resp.sendValidation(response, 400, "tokenInvalido", true, LogTypes.SECURITY);
            }

            const model: EmpresaUsuarioVinculoBodyModel = { empr_codigo: body.empr_codigo.trim() };
            const result = await this.repository.vincular(payload.data, model);

            if (!result.usuarioEncontrado) {
                return Resp.sendValidation(response, 401, "usuarioNaoEncontrado", true, LogTypes.SECURITY);
            }
            if (!result.empresaEncontrada) {
                return Resp.send(response, 404, { message: "Código de empresa não encontrado." });
            }
            if (!result.vinculado) {
                return Resp.send(response, 409, { message: "Este usuário já está vinculado à empresa." });
            }

            return Resp.send(response, 201, { emprId: result.emprId, usuaId: result.usuaId });
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "empresaUsuario.vincular", LogTypes.ERROR, 1);
        }
    }
}

export { EmpresaUsuarioController };
