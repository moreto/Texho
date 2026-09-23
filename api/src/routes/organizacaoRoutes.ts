import { Router } from "express";
import { OrganizacaoLocalController } from "../controllers/organizacao/organizazaoLocalController";

const organizacaoRoutes = Router();
const organizacaoLocalController = new OrganizacaoLocalController();

organizacaoRoutes.get("/api/v1/organizacao/:id", organizacaoLocalController.getTreeById);
organizacaoRoutes.get("/api/v1/organizacao", organizacaoLocalController.get);
export default organizacaoRoutes;