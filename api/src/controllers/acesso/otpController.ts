import { Request, Response } from "express";
import { LogTypes } from "../../commons/enum";
import { generateOTP, sendOTPEmail } from "../../commons/otp";
import { Resp } from "../../commons/resp";
import { AcessoRepositoryContract, OTPRepositoryContract } from "../../repositories/acessoRepositoryContracts";

class OTPController {
    constructor(
        private readonly acessoRepository: AcessoRepositoryContract,
        private readonly otpRepository: OTPRepositoryContract,
    ) {}

    async sendOTP(request: Request, response: Response) {
        const email = request.body?.email;
        if (typeof email !== "string" || email.trim().length === 0) {
            return Resp.sendValidation(response, 400, "emailObrigatorio", true, LogTypes.VALIDATION);
        }

        try {
            const normalizedEmail = email.trim();
            const user = await this.acessoRepository.getUserId(normalizedEmail);

            if (user != null) {
                const otp = generateOTP();
                await this.otpRepository.send({ usua_id: user.usuaId, uotp_key: Number(otp) });
                await sendOTPEmail(normalizedEmail, otp);
            }

            return Resp.sendValidation(response, 200, "otpRequestAccepted");
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGenerico", "sendOTP", LogTypes.ERROR, 1);
        }
    }

    async verifyOTP(request: Request, response: Response) {
        const email = request.body?.email;
        const code = request.body?.otp;
        if (
            typeof email !== "string" ||
            email.trim().length === 0 ||
            typeof code !== "string" ||
            !/^\d{6}$/.test(code)
        ) {
            return Resp.sendValidation(response, 400, "codigoOtpInvalido", true, LogTypes.VALIDATION);
        }

        try {
            const isValid = await this.otpRepository.verify(email.trim(), Number(code));
            if (!isValid) {
                return Resp.sendValidation(response, 400, "codigoOtpInvalidoOuExpirado", true, LogTypes.VALIDATION);
            }

            return response.status(200).send(true);
        } catch (error: unknown) {
            return Resp.sendError(response, error, 500, "erroGenerico", "verifyOTP", LogTypes.ERROR, 1);
        }
    }
}

export { OTPController };
