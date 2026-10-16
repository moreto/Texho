import express, { NextFunction, Request, Response } from "express";

import acessoRoutes from "./routes/accessRoutes";
import defaultRoutes from "./routes/rootRoutes";
import empresaRoutes from "./routes/empresaRoutes";
import logRoutes from "./routes/logRoutes";
import menuRoutes from "./routes/menuRoutes";
import notificacaoRoutes from "./routes/notificacaoRoutes";
import traducaoRoutes from "./routes/traducaoRoutes";
import usuarioRoutes from "./routes/usuarioRoutes";

const app = express();
app.use(express.json());

// app.use(morgan(":url :method :response-time :user-agent"));

// Rotas
app.use(defaultRoutes);
app.use(acessoRoutes);
app.use(menuRoutes);
app.use(usuarioRoutes);
app.use(empresaRoutes);
app.use(logRoutes);
app.use(notificacaoRoutes);
app.use(traducaoRoutes);

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
