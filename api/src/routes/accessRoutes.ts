import { Router } from "express";

import { AcessoController } from "../controllers/acesso/acessoController";
import { OTPController } from "../controllers/acesso/otpController";
import { AcessoRepository } from "../repositories/accesso/acessoRepository";
import { OTPRepository } from "../repositories/accesso/otpRepository";

const acessoRoutes = Router();
const acessoRepository = new AcessoRepository();
const otpRepository = new OTPRepository();
const accessoController = new AcessoController(acessoRepository);
const otpController = new OTPController(acessoRepository, otpRepository);

acessoRoutes.post("/api/v1/acesso/login", (request, response) => accessoController.login(request, response));
acessoRoutes.post("/api/v1/acesso/registro", (request, response) => accessoController.registro(request, response));
acessoRoutes.post("/api/v1/otp/send", (request, response) => otpController.sendOTP(request, response));
acessoRoutes.post("/api/v1/otp/verify", (request, response) => otpController.verfyOTP(request, response));

export default acessoRoutes;
