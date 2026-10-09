import { Router } from "express";
import { authorize } from "../commons/authorize";
import { MenuController } from "../controllers/menu/menuController";
import { MenuRepository } from "../repositories/menu/menuRepository";

const menuRepository = new MenuController(new MenuRepository());

const commonRoutes = Router();
commonRoutes.get("/api/v1/menu", authorize, (request, response) => menuRepository.menu(request, response));
export default commonRoutes;
