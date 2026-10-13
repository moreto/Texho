import { Router } from "express";
import { EmpresaController } from "../controllers/empresa/empresaController";
import { EmpresaRepository } from "../repositories/empresa/empresaRepository";

const empresaRoutes = Router();
const empresaController = new EmpresaController(new EmpresaRepository());

empresaRoutes.get("/api/v1/empresa/get-by-id/:id", (request, response) => empresaController.getById(request, response));

export default empresaRoutes;
