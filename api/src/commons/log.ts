import * as Config from "../configs/config.json";

export class Log {
    // constructor(parameters) {}

    static print(text: object, group: string = "") {
        const textLog = text;

        group != "" ? console.group(group) : null;
        Config.showConsole ? console.log(Config.logTitle, textLog) : null;
        group != "" ? console.groupEnd() : null;
    }

    static printErro(err: unknown) {
        let erroStack = "";
        if (err instanceof Error) {
            erroStack = err.stack!;
            Log.print(Config.logTitle + err.name);
            Log.print(Config.logTitle + err.message);
            Log.print(Config.logTitle + erroStack);
        }
    }

    // static async erro(erro: unknown, mensagem: string, logTipo: string, usuaId: number) {
    //     try {
    //         let erroStack = "";
    //         let erroMessage = "";

    //         if (Config.showConsole) {
    //             if (erro instanceof Error) {
    //                 erroStack = erro.stack!;
    //                 erroMessage = mensagem;

    //                 Log.print(erro.name);
    //                 Log.print(erro.message);
    //                 Log.print(erroStack);
    //             } else {
    //                 erroStack = "erroStack";
    //                 erroMessage = mensagem;
    //             }
    //         }

    //         const repository = new LogRepository();

    //         const logModel: LogBodyModel = {
    //             log_tipo: logTipo,
    //             log_info: erroStack,
    //             log_texto: mensagem,
    //             usua_id: usuaId,
    //         };

    //         const logId = await repository.post(logModel);

    //         const notificaco: NotificacaoModel = {
    //             notiId: 0,
    //             notiData: new Date(),
    //             logId: logId?.log_id ?? 0,
    //             notiTipo: LogTypes.ERROR,
    //             usuaId: usuaId,
    //             notiTexto: erroMessage,
    //             notiErro: erroStack,
    //         };

    //         const ret = await Notificacao.notificar(notificaco);

    //         const rm = camelcaseKeys(ret);

    //         Log.print(rm);

    //         return rm;
    //     } catch (error) {
    //         throw error;
    //     }
    // }
}
