import { Router } from "express";
import NotificacaoController from "../controllers/notificacaoController";
import { RootController } from "../controllers/rootController";
import { TraducaoController } from "../controllers/traducao/organizazaoLocalController";
import { LogDbRepository } from "../repositories/commons/logDbRepository";
import { NotificacaoRepository } from "../repositories/commons/notificacaoRepository";
import { TraducaoRepository } from "../repositories/traducao/traducaoRepository";

const defaultRoutes = Router();
const rootController = new RootController();
const notificacaoController = new NotificacaoController(new NotificacaoRepository(), new LogDbRepository());
const traducaoController = new TraducaoController(new TraducaoRepository());

// Rota principal para informações do sistema
// defaultRoutes.get("", async (req, res) => {
//     await rootController.root(req, res);
// });

defaultRoutes.get("/api", rootController.root);
defaultRoutes.get("/api/v1/traducao", (request, response) => traducaoController.get(request, response));
defaultRoutes.post("/v1/notificacao", (request, response) => notificacaoController.notificar(request, response));

export default defaultRoutes;
