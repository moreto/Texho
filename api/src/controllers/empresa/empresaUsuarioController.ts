import { Request, Response } from "express";
import { LogTypes } from "../../commons/enum";
import { Header } from "../../commons/header";
import { Log } from "../../commons/log";
import { Resp } from "../../commons/resp";
import { EmpresaUsuarioBodyModel } from "../../models/empresa/empresaUsuarioBodyModel";
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
}

export { EmpresaUsuarioController };
