import { Request, Response } from "express";
import { generateOTP, sendOTPEmail } from "../../commons/otp";
import { AcessoRepositoryContract, OTPRepositoryContract } from "../../repositories/acessoRepositoryContracts";

class OTPController {
    constructor(
        private readonly acessoRepository: AcessoRepositoryContract,
        private readonly otpRepository: OTPRepositoryContract,
    ) {}

    async sendOTP(request: Request, response: Response) {
        const email = request.body?.email;
        if (typeof email !== "string" || email.trim().length === 0) {
            return response.status(400).send({ message: "emailObrigatorio" });
        }

        try {
            const normalizedEmail = email.trim();
            const user = await this.acessoRepository.getUserId(normalizedEmail);

            if (user != null) {
                const otp = generateOTP();
                await this.otpRepository.send({ usua_id: user.usuaId, uotp_key: Number(otp) });
                await sendOTPEmail(normalizedEmail, otp);
            }

            return response.status(200).send({ message: "otpRequestAccepted" });
        } catch (error: unknown) {
            console.error(error);
            return response.status(500).send({ message: "erroGenerico" });
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
            return response.status(400).send({ message: "codigoOtpInvalido" });
        }

        try {
            const isValid = await this.otpRepository.verify(email.trim(), Number(code));
            if (!isValid) {
                return response.status(401).send({ message: "codigoOtpInvalidoOuExpirado" });
            }

            return response.status(200).send(true);
        } catch (error: unknown) {
            console.error(error);
            return response.status(500).send({ message: "erroGenerico" });
        }
    }
}

export { OTPController };
