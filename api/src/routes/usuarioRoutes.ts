import { Router } from "express";
import { authorize } from "../commons/authorize";
import { UsuarioController } from "../controllers/usuario/usuarioController";
import { UsuarioRepository } from "../repositories/usuario/usuarioRepository";

const usuarioRepository = new UsuarioController(new UsuarioRepository());

const usuarioRoutes = Router();
usuarioRoutes.get("/api/v1/usuario/usuario-detalhe-by-id", authorize, (request, response) =>
    usuarioRepository.usuarioDetalheById(request, response),
);
export default usuarioRoutes;
