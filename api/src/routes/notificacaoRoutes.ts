import { Router } from "express";
import NotificacaoController from "../controllers/notificacaoController";
import { LogRepository } from "../repositories/commons/logRepository";
import { NotificacaoRepository } from "../repositories/commons/notificacaoRepository";

const notificacaoController = new NotificacaoController(new NotificacaoRepository(), new LogRepository());

const notificacaoRoutes = Router();
notificacaoRoutes.get("/api/v1/notificacao", (request, response) => notificacaoController.listar(request, response));
notificacaoRoutes.post("/api/v1/notificacao", (request, response) =>
    notificacaoController.notificar(request, response),
);

export default notificacaoRoutes;
