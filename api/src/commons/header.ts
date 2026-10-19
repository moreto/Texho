import { Request } from "express";
import { Config } from "../configs/config";
import { Util } from "./util";

export class Header {
    static async verificaHeader(request: Request, valida: boolean, requireEmpresa: boolean = true) {
        try {
            let bRet = true;

            if (valida) {
                const headers = request.headers;

                const accessToken = headers[Config.accessToken];
                const token = headers[Config.token];
                const user = headers[Config.userId];
                const empresa = headers[Config.emprId];

                if (
                    Util.isEmpty(token) ||
                    Util.isEmpty(accessToken) ||
                    Util.isEmpty(user) ||
                    (requireEmpresa && Util.isEmpty(empresa))
                ) {
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

    static async getEpresa(request: Request) {
        try {
            const headers = request.headers;
            const user = headers[Config.emprId];
            return parseInt(user!.toString());
        } catch (error) {
            throw error;
        }
    }
}
