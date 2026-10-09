import express, { NextFunction, Request, Response } from "express";
import morgan from "morgan";

import acessoRoutes from "./routes/accessRoutes";
import commonRoutes from "./routes/commonRoutes";
import defaultRoutes from "./routes/defaultRoutes";

const app = express();
app.use(express.json());

app.use(morgan(":url :method :response-time :user-agent"));

// Rotas
app.use(defaultRoutes);
app.use(acessoRoutes);
app.use(commonRoutes);

interface ErrorWithStack extends Error {
    stack?: string;
}

app.use((err: ErrorWithStack, req: Request, res: Response, next: NextFunction) => {
    if (res.headersSent) {
        return next(err);
    }

    console.error(err.stack);
    return res.status(500).send({ message: "erroGeral" });
});

export { app };
