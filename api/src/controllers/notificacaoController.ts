import { Request, Response } from "express";
import { LogTypes } from "../commons/enum";
import { ConvertNotificacaoModel } from "../models/notificacaoModel";
import { LogDbRepository } from "../repositories/logDbRepository";
import { NotificacaoRepository } from "../repositories/notificacaoRepository";

export default class NotificacaoController {
    async notificar(request: Request, response: Response) {
        try {
            const repository = new NotificacaoRepository();
            const logRepository = new LogDbRepository();

            const model = ConvertNotificacaoModel.toNotificacaoModel(
                JSON.stringify(request.body),
            );

            if (
                model.notiErro != null &&
                model.notiErro != undefined &&
                model.notiErro != ""
            ) {
                const logId = await logRepository.post({
                    logTipo: LogTypes.ERROR,
                    objeto: model.notiErro,
                    usuaId: model.usuaId,
                    texto: model.notiTexto,
                });

                model.logId = logId.logId;
            }

            const retorno = await repository.post(model);

            return response.status(200).send(retorno);
        } catch (err: unknown) {
            return response.status(513).send(err);
        }
    }
}
