import { Request } from "express";
import * as Config from "../configs/config.json";
import { Util } from "./util";

export class Header {
  static async verificaHeader(request: Request, valida: boolean) {
    let intUser = -1;
    try {
      let bRet = true;

      const headers = request.headers;

      let accessToken = headers[Config.accessToken];
      let token = headers[Config.token];
      let user = headers[Config.userId];

      if (Util.isEmpty(accessToken)) {
        bRet = false;
      } else if (Util.isEmpty(token)) {
        bRet = false;
      } else if (Util.isEmpty(user)) {
        bRet = false;
      } else {
        bRet = true;
      }

      if (!valida) {
        bRet = true;
      }

      if (token == Config.tokenId) {
        bRet = true;
      } else {
        bRet = false;
      }

      if (!bRet) {
        // throw await Erro.gravaErro(null, "Dados inválidos no header", "API", "Header", "verificaHeader", 0, true);
      } else {
        return true;
      }
    } catch (error) {
      throw error;
    }
  }

  static async getUsuario(request: Request) {
    try {
      const headers = request.headers;
      let user = headers[Config.userId];
      return parseInt(user!.toString());
    } catch (error) {
      throw error;
    }
  }
}
