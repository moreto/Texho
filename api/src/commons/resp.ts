import { Response } from "express";
import * as Config from "../configs/config.json";
import { LogBodyModel } from "../models/logBodyModel";
import { NotificacaoModel } from "../models/notificacaoModel";
import { LogRepository } from "../repositories/commons/logRepository";
import { LogTypes } from "./enum";
import { Log } from "./log";
import { Notificacao } from "./notificacao";

class Resp {
    static async send(response: Response, statusCode: number, data: unknown) {
        return response.status(statusCode).send(data);
    }

    static async sendValidation(
        response: Response,
        statusCode: number,
        message: string,
        notify: boolean = false,
        type: LogTypes = LogTypes.LOG,
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
            code = retorno.notiId;
        }
        return response.status(statusCode).send({ code, message });
    }

    static async sendError(
        response: Response,
        erro: unknown,
        statusCode: number,
        message: string,
        local: string,
        type: LogTypes,
        usuaId: number,
    ) {
        try {
            let erroStack = "";
            let erroMessage = "";

            if (Config.showConsole) {
                if (erro instanceof Error) {
                    erroStack = erro.stack!;
                    erroMessage = message;

                    Log.print(erro.name);
                    Log.print(erro.message);
                    Log.print(erroStack);
                } else {
                    erroStack = "erroStack";
                    erroMessage = message;
                }
            }

            const repository = new LogRepository();

            const logModel: LogBodyModel = {
                log_tipo: type,
                log_info: erroStack,
                log_texto: local,
                usua_id: usuaId,
            };

            const logId = await repository.post(logModel);

            const notificaco: NotificacaoModel = {
                notiId: 0,
                notiData: new Date(),
                logId: logId?.logId ?? 0,
                notiTipo: type,
                usuaId: usuaId,
                notiTexto: erroMessage,
                notiErro: erroStack,
            };

            const ret = await Notificacao.notificar(notificaco);

            const code = ret.notiId;
            return response.status(statusCode).send({ code, message });
        } catch (error) {
            throw error;
        }
    }
}

export { Resp };
