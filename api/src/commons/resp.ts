import { Response } from "express";

class Resp {
    static send(response: Response, statusCode: number, message: string) {
        return response.status(statusCode).send({ message });
    }
}

export { Resp };
