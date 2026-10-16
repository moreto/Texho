import { Request, Response } from "express";
import { LogTypes } from "../../commons/enum";
import { Log } from "../../commons/log";
import { Resp } from "../../commons/resp";
import { Util } from "../../commons/util";
import { LogBodyModel } from "../../models/logBodyModel";
import { ConvertNotificacaoModel } from "../../models/notificacaoModel";
import { LogRepositoryContract } from "../../repositories/log/logRepositoryContract";
import { NotificacaoRepositoryContract } from "../../repositories/notificacao/notificacaoRepositoryContracts";

export default class NotificacaoController {
    constructor(
        private readonly repository: NotificacaoRepositoryContract,
        private readonly logRepository: LogRepositoryContract,
    ) {}

    async listar(request: Request, response: Response) {
        try {
            Log.printUrl(request);
            const retorno = await this.repository.get();
            return Resp.send(response, 200, retorno);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "login", LogTypes.ERROR, 1);
        }
    }

    async notificar(request: Request, response: Response) {
        try {
            Log.printUrl(request);
            const model = ConvertNotificacaoModel.toNotificacaoModel(JSON.stringify(request.body));

            if (!Util.isEmpty(model.notiErro)) {
                const modelBody: LogBodyModel = {
                    log_info: model.notiErro ?? "",
                    log_texto: model.notiTexto,
                    log_tipo: model.notiTipo,
                    usua_id: model.usuaId,
                };

                await this.logRepository.post(modelBody);
            }

            const retorno = await this.repository.post(model);

            return Resp.send(response, 200, retorno);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGeral", "login", LogTypes.ERROR, 1);
        }
    }
}
