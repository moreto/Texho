import { Router } from "express";
import { authorize } from "../commons/authorize";
import { EmpresaController } from "../controllers/empresa/empresaController";
import { EmpresaRepository } from "../repositories/empresa/empresaRepository";

const empresaRoutes = Router();
const empresaController = new EmpresaController(new EmpresaRepository());

empresaRoutes.get("/api/v1/empresa", authorize, (request, response) => empresaController.getById(request, response));
empresaRoutes.post("/api/v1/empresa", authorize, (request, response) => empresaController.post(request, response));
empresaRoutes.put("/api/v1/empresa", authorize, (request, response) => empresaController.put(request, response));

export default empresaRoutes;
