import { Request, Response } from "express";
import { LogTypes } from "../commons/enum";
import { ConvertNotificacaoModel } from "../models/notificacaoModel";
import {
    LogDbRepositoryContract,
    NotificacaoRepositoryContract,
} from "../repositories/contracts";

export default class NotificacaoController {
    constructor(
        private readonly repository: NotificacaoRepositoryContract,
        private readonly logRepository: LogDbRepositoryContract,
    ) {}

    async notificar(request: Request, response: Response) {
        try {
            const model = ConvertNotificacaoModel.toNotificacaoModel(
                JSON.stringify(request.body),
            );

            if (
                model.notiErro != null &&
                model.notiErro != undefined &&
                model.notiErro != ""
            ) {
                const logId = await this.logRepository.post({
                    logTipo: LogTypes.ERROR,
                    objeto: model.notiErro,
                    usuaId: model.usuaId,
                    texto: model.notiTexto,
                });

                if (logId == null) {
                    throw new Error("Não foi possível registrar o log da notificação.");
                }

                model.logId = logId.logId;
            }

            const retorno = await this.repository.post(model);

            return response.status(200).send(retorno);
        } catch (err: unknown) {
            return response.status(513).send(err);
        }
    }
}
