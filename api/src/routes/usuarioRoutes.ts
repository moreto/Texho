import { Router } from "express";
import { authorize } from "../commons/authorize";
import { UsuarioController } from "../controllers/usuario/usuarioController";
import { UsuarioDispositivoController } from "../controllers/usuario/usuarioDispositivoController";
import { UsuarioDispositivoLogRepository } from "../repositories/usuario/usuarioDispositivoLogRepository";
import { UsuarioDispositivoRepository } from "../repositories/usuario/usuarioDispositivoRepository";
import { UsuarioRepository } from "../repositories/usuario/usuarioRepository";

const usuarioRepository = new UsuarioController(new UsuarioRepository());
const usuarioDispositivoController = new UsuarioDispositivoController(
    new UsuarioDispositivoRepository(),
    new UsuarioDispositivoLogRepository(),
);

const usuarioRoutes = Router();
usuarioRoutes.get("/api/v1/usuario/usuario-detalhe-by-id", authorize, (request, response) =>
    usuarioRepository.usuarioDetalheById(request, response),
);
usuarioRoutes.post("/api/v1/usuario-dispositivo", authorize, (request, response) =>
    usuarioDispositivoController.post(request, response),
);
export default usuarioRoutes;
