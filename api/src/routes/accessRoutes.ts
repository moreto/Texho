import { Router } from "express";

import { AcessoController } from "../controllers/acesso/acessoController";

const acessoRoutes = Router();
const accessoController = new AcessoController();

acessoRoutes.post("/api/v1/acesso/registro", (request, response) =>
    accessoController.registro(request, response),
);

export default acessoRoutes;
