import { Router } from "express";
import { authorize } from "../commons/authorize";
import NotificacaoController from "../controllers/notificacaoController";
import { RootController } from "../controllers/rootController";

const defaultRoutes = Router();
const rootController = new RootController();
const notificacaoController = new NotificacaoController();

// Rota principal para informações do sistema
// defaultRoutes.get("", async (req, res) => {
//     await rootController.root(req, res);
// });

defaultRoutes.get("", rootController.root);
defaultRoutes.post("/api/v1/notificacao", notificacaoController.notificar);

export default defaultRoutes;