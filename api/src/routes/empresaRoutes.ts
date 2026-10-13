import { Router } from "express";
import { authorize } from "../commons/authorize";
import { EmpresaController } from "../controllers/empresa/empresaController";
import { EmpresaRepository } from "../repositories/empresa/empresaRepository";

const empresaRoutes = Router();

const empresaRepository = new EmpresaController(new EmpresaRepository());

);
empresaRepository.getById("/api/v1/empresa/get-by-id/:id", authorize, (request, response) =>
    empresaRepository.get(request, response),
);

export default empresaRoutes;
