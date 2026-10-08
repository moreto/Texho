import { Router } from "express";
import LogController from "../controllers/logController";
import NotificacaoController from "../controllers/notificacaoController";
import { RootController } from "../controllers/rootController";
import { TraducaoController } from "../controllers/traducao/traducaoController";
import { LogRepository } from "../repositories/commons/logRepository";
import { NotificacaoRepository } from "../repositories/commons/notificacaoRepository";
import { TraducaoRepository } from "../repositories/traducao/traducaoRepository";

const defaultRoutes = Router();
const rootController = new RootController();
const notificacaoController = new NotificacaoController(new NotificacaoRepository(), new LogRepository());
const traducaoController = new TraducaoController(new TraducaoRepository());
const logController = new LogController(new LogRepository());

// Rota principal para informações do sistema
// defaultRoutes.get("", async (req, res) => {
//     await rootController.root(req, res);
// });

defaultRoutes.get("/api", rootController.root);
defaultRoutes.get("/api/v1/traducao", (request, response) => traducaoController.traducao(request, response));
defaultRoutes.get("/api/v1/notificacao", (request, response) => notificacaoController.listar(request, response));
defaultRoutes.post("/api/v1/notificacao", (request, response) => notificacaoController.notificar(request, response));
defaultRoutes.post("/api/v1/log", (request, response) => logController.gravar(request, response));

export default defaultRoutes;
