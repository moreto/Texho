import { Router } from "express";
import NotificacaoController from "../controllers/notificacaoController";
import { RootController } from "../controllers/rootController";
import { TraducaoController } from "../controllers/traducao/organizazaoLocalController";

const defaultRoutes = Router();
const rootController = new RootController();
const notificacaoController = new NotificacaoController();
const traducaoController = new TraducaoController();

// Rota principal para informações do sistema
// defaultRoutes.get("", async (req, res) => {
//     await rootController.root(req, res);
// });

defaultRoutes.get("", rootController.root);
defaultRoutes.get("/v1/traducao", traducaoController.get);
defaultRoutes.post("/v1/notificacao", notificacaoController.notificar);

export default defaultRoutes;