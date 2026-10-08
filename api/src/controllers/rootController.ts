import { Request, Response } from "express";
import * as Package from "../../package.json";
import { Log } from "../commons/log";
import { Resp } from "../commons/resp";
import * as Config from "../configs/config.json";

class RootController {
    constructor() {}

    async root(request: Request, response: Response) {
        const pjson = Package;
        // const onLine = "";

        const log = {
            name: pjson.name,
            description: pjson.description,
            version: pjson.version,
            host: request.headers.host,
            email: Config.emailContact,
            // dataBaseStatus: onLine,
            // database: checkCn.current_database,
        };
        Log.print(log);

        Resp.send(response, 200, log);
    }
}

export { RootController };
