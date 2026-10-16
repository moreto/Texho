import { Router } from "express";
import { authorize } from "../commons/authorize";
import LogController from "../controllers/log/logController";
import { LogRepository } from "../repositories/log/logRepository";

const logController = new LogController(new LogRepository());

const logRoutes = Router();
logRoutes.post("/api/v1/log", (request, response) => logController.gravar(request, response));
logRoutes.get("/api/v1/log", authorize, (request, response) => logController.get(request, response));
export default logRoutes;
