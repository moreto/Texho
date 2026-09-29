import { Request, Response } from "express";
import { Log } from "../commons/log";
import * as Config from "../configs/config.json";

class RootController {
    constructor() {}

    async root(request: Request, response: Response) {
        const pjson = require("../../package.json");
        const onLine = "";

        const log = {
            name: pjson.name,
            description: pjson.description,
            version: pjson.version,
            host: request.headers.host,
            email: Config.emailContact,
            dataBaseStatus: onLine,
            // database: checkCn.current_database,
        };
        Log.print(log);

        return response.status(201).json(log);
    }
}

export { RootController };
