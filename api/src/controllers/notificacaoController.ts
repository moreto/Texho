import { Request, Response } from "express";
import { LogTypes } from "../commons/enum";
import { NotificacaoModel } from "../models/notificacaoModel";
import { NotificacaoRepository } from "../repositories/notificacaoRepository";


export default class NotificacaoController {
    async notificar(request: Request, response: Response) {
        try {
            const repository = new NotificacaoRepository();

            const notificaco: NotificacaoModel = {
                notiId: 0,
                notiData: new Date(),
                logId: 0,
                notiTipo: LogTypes.ERROR,
                usuaId: 1,
                notiTexto: 'erroMessage',
                notiErro: 'erroStack',
            };

            let retorno = await repository.post(notificaco);

            return response.status(200).send(retorno);
        } catch (err: unknown) {
            return response.status(513).send(err);
        }
    }
}
