import { Router } from "express";
import { authorize } from "../commons/authorize";
import NotificacaoController from "../controllers/notificacaoController";
import { RootController } from "../controllers/rootController";

const defaultRoutes = Router();
const rootController = new RootController();
const notificacaoController = new NotificacaoController();

// Rota principal para informações do sistema
defaultRoutes.get("", async (req, res) => {
    await rootController.root(req, res);
});

defaultRoutes.get("/info",
    async (req, res, next) => {
        await authorize(req, res, next)
    }, async (req, res) => {
        await rootController.root(req, res);
    });

// Adicione outras rotas aqui conforme necessário
// Exemplo: router.get("/outra-rota", (req, res) => controller.metodo(req, res));

defaultRoutes.get("/notificar", async (req, res) => {
    await notificacaoController.notificar(req, res);
});

export default defaultRoutes;