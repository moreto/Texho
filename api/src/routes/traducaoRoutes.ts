import { Router } from "express";
import { TraducaoController } from "../controllers/traducao/traducaoController";
import { TraducaoRepository } from "../repositories/traducao/traducaoRepository";

const traducaoRoutes = Router();

const traducaoController = new TraducaoController(new TraducaoRepository());

traducaoRoutes.get("/api/v1/traducao", (request, response) => traducaoController.traducao(request, response));
traducaoRoutes.get("/api/v1/hash", (request, response) => traducaoController.hash(request, response));

export default traducaoRoutes;
