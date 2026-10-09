import { NextFunction, Request, Response } from "express";
import { sign, verify } from "jsonwebtoken";
import * as Config from "../configs/config.json";
import { LogTypes } from "./enum";
import { Resp } from "./resp";

// expiresIn('2 days')  // 172800000
// expiresIn('1d')      // 86400000
// expiresIn('10h')     // 36000000
// expiresIn('2.5 hrs') // 9000000
// expiresIn('2h')      // 7200000
// expiresIn('1m')      // 60000
// expiresIn('5s')      // 5000
// expiresIn('1y')      // 31557600000
// expiresIn('100')     // 100
// expiresIn('-3 days') // -259200000
// expiresIn('-1h')     // -3600000
// expiresIn('-200')    // -200

async function generateToken(payload: string) {
    return sign({ data: payload }, Config.saltKey, {
        expiresIn: Config.expiresTime,
    });
}

async function generateAdminToken(payload: string) {
    return sign({ data: payload }, Config.saltKey, {
        expiresIn: Config.expiresTimeAdmin,
    });
}

async function generateNoHeader(payload: string) {
    return sign({ data: payload }, Config.saltKey, {
        expiresIn: Config.expiresTimeNoHeader,
    });
}

async function decodeToken(token: string) {
    const data = await verify(token, Config.saltKey);
    return data;
}

function parseJwt(token: string) {
    const base64Payload = token.split(".")[1];
    const payload = Buffer.from(base64Payload, "base64");
    return JSON.parse(payload.toString());
}

function authorize(request: Request, response: Response, next: NextFunction) {
    const token = request.headers[Config.token]?.toString();

    if (!token) {
        return Resp.sendValidation(response, 400, "tokenInvalido", true, LogTypes.SECURITY);
    }

    return verify(token, Config.saltKey, (error) => {
        if (error) {
            return Resp.sendValidation(response, 400, "tokenInvalido", true, LogTypes.SECURITY);
        }

        return next();
    });
}

export { authorize, decodeToken, generateAdminToken, generateNoHeader, generateToken, parseJwt };
