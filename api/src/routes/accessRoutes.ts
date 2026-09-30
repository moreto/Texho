import { Router } from "express";

import { AcessoController } from "../controllers/acesso/acessoController";

const acessoRoutes = Router();
const accessoController = new AcessoController();

acessoRoutes.post("/v1/acesso/registro", accessoController.registro);

export default acessoRoutes;
