import { Request, Response } from "express";
import { Util } from "../commons/util";
import { LogBodyModel } from "../models/logBodyModel";
import { ConvertNotificacaoModel } from "../models/notificacaoModel";
import { NotificacaoRepositoryContract } from "../repositories/acessoRepositoryContracts";
import { LogRepositoryContract } from "../repositories/logRepositoryContract";

export default class NotificacaoController {
    constructor(
        private readonly repository: NotificacaoRepositoryContract,
        private readonly logRepository: LogRepositoryContract,
    ) {}

    async listar(request: Request, response: Response) {
        try {
            const retorno = await this.repository.get();
            return response.status(200).send(retorno);
        } catch (err: unknown) {
            return response.status(513).send(err);
        }
    }

    async notificar(request: Request, response: Response) {
        try {
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

            return response.status(200).send(retorno);
        } catch (err: unknown) {
            return response.status(513).send(err);
        }
    }
}
