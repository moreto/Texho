import { Request, Response } from "express";
import { LogTypes } from "../../commons/enum";
import { Header } from "../../commons/header";
import { Log } from "../../commons/log";
import { Resp } from "../../commons/resp";
import { EmpresaBodyModelConvert } from "../../models/empresa/empresaBodyModel";
import { EmpresaModelConvert } from "../../models/empresa/empresaModel";
import { EmpresaRepositoryContract } from "../../repositories/empresa/empresaRepositoryContract";

class EmpresaController {
    constructor(private readonly repository: EmpresaRepositoryContract) {}

    async getById(request: Request, response: Response) {
        try {
            Log.printUrl(request);
            if (!(await Header.verificaHeader(request, true))) {
                return Resp.sendValidation(response, 400, "headerInvalido", true, LogTypes.SECURITY);
            }

            const emprId = await Header.getEpresa(request);

            const retorno = await this.repository.getById(emprId);

            return Resp.send(response, 200, retorno);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "empr.getById", LogTypes.ERROR, 1);
        }
    }

    async post(request: Request, response: Response) {
        try {
            Log.printUrl(request);
            if (!(await Header.verificaHeader(request, true))) {
                return Resp.sendValidation(response, 400, "headerInvalido", true, LogTypes.SECURITY);
            }

            const model = EmpresaBodyModelConvert.toEmpresaBodyModel(JSON.stringify(request.body));

            const retorno = await this.repository.post(model);

            return Resp.send(response, 200, retorno);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "empr.getById", LogTypes.ERROR, 1);
        }
    }

    async put(request: Request, response: Response) {
        try {
            Log.printUrl(request);
            if (!(await Header.verificaHeader(request, true))) {
                return Resp.sendValidation(response, 400, "headerInvalido", true, LogTypes.SECURITY);
            }

            const model = EmpresaModelConvert.toEmpresaModel(JSON.stringify(request.body));

            const retorno = await this.repository.put(model);

            return Resp.send(response, 200, retorno);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "empr.getById", LogTypes.ERROR, 1);
        }
    }
}

export { EmpresaController };
