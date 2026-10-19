import { Request } from "express";
import { Config } from "../configs/config";

export class Log {
    // constructor(parameters) {}

    static print(text: unknown) {
        const textLog = text;

        if (Config.showConsole) {
            console.log(Config.logTitle, textLog);
        }
    }

    static printErro(err: unknown) {
        if (Config.logTitle) {
            if (err instanceof Error) {
                const erroStack = err.stack!;

                console.log(Config.logTitle, err.name);
                console.log(Config.logTitle, err.message);
                console.log(Config.logTitle, erroStack);
            }
        }
    }

    static printUrl(request: Request) {
        if (Config.showConsole) {
            console.log(Config.logTitle, "Request ----------------------------------------------------------");
            const url = request.url;
            const method = request.method;
            const ip = request.ip;

            console.log(Config.logTitle, url + " | " + method + " | " + ip);
        }
    }

    // static printEnd() {
    //     if (Config.showConsole) {
    //         // console.log(Config.logTitle, "End ------------------------------------------------------------ Request");
    //     }
    // }
}
