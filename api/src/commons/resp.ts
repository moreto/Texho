import { Response } from "express";
import { NotificacaoModel } from "../models/notificacaoModel";
import { NotificacaoTypes } from "./enum";
import { Notificacao } from "./notificacao";
import { Log } from "./log";

class Resp {
    static async send(
        response: Response,
        statusCode: number,
        message: string,
        notify: boolean = false,
        type: NotificacaoTypes,
        usuaId: number = 1,
    ) {
        let code = 0;
        if (notify) {
            const model: NotificacaoModel = {
                notiTexto: message,
                notiTipo: type,
                usuaId: usuaId,
            };
            const retorno = await Notificacao.notificar(model);
            code = retorno.id;
        }
        return response.status(statusCode).send({ code, message });
    }
    static sendError(response: Response, erro: unknown, statusCode: number, message: string, code: string) {

        Log.erro

        return response.status(statusCode).send({ code, message });
    }
}

export { Resp };
