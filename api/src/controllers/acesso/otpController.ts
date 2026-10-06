import { Request, Response } from "express";
import { sendOTPEmail } from "../../commons/otp";
import { Resp } from "../../commons/resp";
import { Util } from "../../commons/util";
import { ConvertOTPBodyModel } from "../../models/acesso/otpBodyModel";
import { OTPModel } from "../../models/otpModel";
import { AcessoRepositoryContract, OTPRepositoryContract } from "../../repositories/acessoRepositoryContracts";

class OTPController {
    constructor(
        private readonly acessoRepository: AcessoRepositoryContract,
        private readonly otpRepository: OTPRepositoryContract,
    ) {}

    async sendOTP(request: Request, response: Response) {
        if (Util.isEmpty(request.body)) {
            return Resp.send(response, 410, "emailObrigatorio");
        }

        const model = ConvertOTPBodyModel.toOTPBodyModel(JSON.stringify(request.body));

        const retorno = await this.acessoRepository.check(model.email);

        if (!retorno.emailExiste) {
            return Resp.send(response, 412, "emailInexistente");
        }
        const usuarioRetorno = await this.acessoRepository.get(model.email);

        const otp = await sendOTPEmail(model.email);

        const otpModel: OTPModel = {
            usua_id: usuarioRetorno.usuaId,
            uotp_key: parseInt(otp),
            uotp_id: 0,
            uotp_verified: false,
            created_at: "",
            updated_at: null,
        };

        await this.otpRepository.send(otpModel);

        return Resp.send(response, 200, "emailEnviado");
    }

    async verfyOTP(request: Request, response: Response) {
        if (Util.isEmpty(request.body)) {
            return Resp.send(response, 410, "emailObrigatorio");
        }

        // if (!record) return res.status(400).json({ message: "OTP não encontrado." });
        // if (Date.now() > record.expires) return res.status(400).json({ message: "OTP expirado." });
        // if (record.otp !== otp) return res.status(400).json({ message: "OTP inválido." });

        const model = ConvertOTPBodyModel.toOTPBodyModel(JSON.stringify(request.body));
        const retorno = await sendOTPEmail(model.email);
        return response.status(200).send(retorno);
    }
}

export { OTPController };
