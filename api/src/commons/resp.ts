import { Response } from "express";

class Resp {
    static send(response: Response, statusCode: number, message: string) {
        return response.status(statusCode).send({ message });
    }
    static sendError(response: Response, statusCode: number, message: string, code: string) {
        
        return response.status(statusCode).send({ code, message });
    }
}

export { Resp };
