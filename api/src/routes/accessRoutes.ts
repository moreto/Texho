import { Router } from "express";

import { AcessoController } from "../controllers/acesso/acessoController";
import { OTPController } from "../controllers/acesso/otpController";

const acessoRoutes = Router();
const accessoController = new AcessoController();
const otpController = new OTPController();

acessoRoutes.post("/api/v1/acesso/registro", (request, response) =>
    accessoController.registro(request, response),
);
acessoRoutes.post("/api/v1/otp/send", (request, response) =>
    otpController.sendOTP(request, response),
);

export default acessoRoutes;
