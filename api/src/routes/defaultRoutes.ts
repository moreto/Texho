import { Router } from "express";
import { RootController } from "../controllers/rootController";
import { TraducaoController } from "../controllers/traducao/traducaoController";
import { TraducaoRepository } from "../repositories/traducao/traducaoRepository";

const defaultRoutes = Router();
const rootController = new RootController();

const traducaoController = new TraducaoController(new TraducaoRepository());
// const logController = new LogController(new LogRepository());

// Rota principal para informações do sistema
// defaultRoutes.get("", async (req, res) => {
//     await rootController.root(req, res);
// });

defaultRoutes.get("/api", rootController.root);
defaultRoutes.get("/api/v1/traducao", (request, response) => traducaoController.traducao(request, response));

export default defaultRoutes;
