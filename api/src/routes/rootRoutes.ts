import { Router } from "express";
import { RootController } from "../controllers/rootController";

const defaultRoutes = Router();
const rootController = new RootController();

// Rota principal para informações do sistema
// defaultRoutes.get("", async (req, res) => {
//     await rootController.root(req, res);
// });

defaultRoutes.get("/api", rootController.root);

export default defaultRoutes;
