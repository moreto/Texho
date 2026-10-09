import { Request } from "express";
import * as Config from "../configs/config.json";
import { Util } from "./util";

export class Header {
    static async verificaHeader(request: Request, valida: boolean) {
        try {
            let bRet = true;

            if (valida) {
                const headers = request.headers;

                const accessToken = headers[Config.accessToken];
                const token = headers[Config.token];
                const user = headers[Config.userId];

                if (Util.isEmpty(token) || Util.isEmpty(token) || Util.isEmpty(accessToken) || Util.isEmpty(user)) {
                    bRet = false;
                } else {
                    if (accessToken != Config.accessTokenId) {
                        bRet = false;
                    }
                }
            }
            return bRet;
        } catch (error) {
            throw error;
        }
    }

    static async getUsuario(request: Request) {
        try {
            const headers = request.headers;
            const user = headers[Config.userId];
            return parseInt(user!.toString());
        } catch (error) {
            throw error;
        }
    }
}
