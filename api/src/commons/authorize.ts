import { NextFunction, Request, Response } from "express";
import { sign, verify } from "jsonwebtoken";
import * as Config from "../configs/config.json";

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

async function generateToken(payload: String) {
    return sign({ data: payload }, Config.saltKey, {
        expiresIn: Config.expiresTime,
    });
}

// async function generateAdminToken(payload: String) {
//     return sign({ data: payload }, Config.saltKey, {
//         expiresIn: Config.expiresTimeAdmin,
//     });
// }

// async function generateNoHeader(payload: String) {
//     return sign({ data: payload }, Config.saltKey, {
//         expiresIn: Config.expiresTimeNoHeader,
//     });
// }

async function decodeToken(token: string) {
    var data = await verify(token, Config.saltKey);
    return data;
}

function parseJwt(token: string) {
    var base64Payload = token.split(".")[1];
    var payload = Buffer.from(base64Payload, "base64");
    return JSON.parse(payload.toString());
}

async function authorize(request: Request, response: Response, next: NextFunction) {
    // const token = request.headers[Config.accessToken]?.toString();
    // const user = request.headers[Config.userId]?.toString();

    // let intUser: number = -1;
    // if (user != null) {
    //     intUser = parseInt(user);
    // }

    // if (!token) {
    //     return response.status(401).send({ message: 'Something went wrong!' });
    // } else {
    //     verify(token, Config.saltKey, async function (error: any) {
    //         if (error) {
    //             response.status(401).send({ message: 'Something went wrong!' });
    //         } else {
    //             next();
    //         }
    //     });
    // }
    return response.status(401).send({ message: 'Something went wrong!' });
}

export { authorize, decodeToken, generateToken, parseJwt };

