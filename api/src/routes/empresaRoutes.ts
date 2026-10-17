import { Router } from "express";
import { authorize } from "../commons/authorize";
import { EmpresaController } from "../controllers/empresa/empresaController";
import { EmpresaUsuarioController } from "../controllers/empresa/empresaUsuarioController";
import { EmpresaRepository } from "../repositories/empresa/empresaRepository";
import { EmpresaUsuarioRepository } from "../repositories/empresa/empresaUsuarioRepository";

const empresaRoutes = Router();
const empresaController = new EmpresaController(new EmpresaRepository());
const empresaUsuarioController = new EmpresaUsuarioController(new EmpresaUsuarioRepository());

empresaRoutes.get("/api/v1/empresa", authorize, (request, response) => empresaController.getById(request, response));
empresaRoutes.post("/api/v1/empresa", authorize, (request, response) => empresaController.post(request, response));
empresaRoutes.put("/api/v1/empresa", authorize, (request, response) => empresaController.put(request, response));
empresaRoutes.get("/api/v1/empresa/usuario", authorize, (request, response) =>
    empresaUsuarioController.getByEmpresaId(request, response),
);
empresaRoutes.post("/api/v1/empresa/codigo", authorize, (request, response) =>
    empresaController.getByCodigo(request, response),
);
empresaRoutes.post("/api/v1/empresa/usuario", authorize, (request, response) =>
    empresaUsuarioController.post(request, response),
);
empresaRoutes.post("/api/v1/empresa/usuario/vincular", authorize, (request, response) =>
    empresaUsuarioController.vincular(request, response),
);
empresaRoutes.get("/api/v1/empresa/usuario/detalhe", authorize, (request, response) =>
    empresaUsuarioController.getByEmpresaIdDetalhe(request, response),
);

export default empresaRoutes;
