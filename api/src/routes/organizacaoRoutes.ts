import { Router } from "express";
import { OrganizacaoLocalController } from "../controllers/organizacao/organizazaoLocalController";
import { OrganizacaoLocalRepository } from "../repositories/organizacao/organizacaoLocalRepository";

const organizacaoRoutes = Router();
const organizacaoLocalController = new OrganizacaoLocalController(
    new OrganizacaoLocalRepository(),
);

organizacaoRoutes.get("/api/v1/organizacao/:id", (request, response) =>
    organizacaoLocalController.getTreeById(request, response),
);
organizacaoRoutes.get("/api/v1/organizacao", (request, response) =>
    organizacaoLocalController.get(request, response),
);
export default organizacaoRoutes;
