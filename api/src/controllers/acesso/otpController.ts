import { Request, Response } from "express";
import { sendOTPEmail } from "../../commons/otp";
import { Util } from "../../commons/util";
import { ConvertOTPBodyModel } from "../../models/acesso/otpBodyModel";
import { AcessoRepository } from "../../repositories/accesso/acessoRepository";
import { OTPRepository } from "../../repositories/accesso/otpRepository";
import { OTPModel } from "./otpModel";

class OTPController {
    async sendOTP(request: Request, response: Response) {
        const repository = new AcessoRepository();
        const otpRepository = new OTPRepository();

        if (Util.isEmpty(request.body)) {
            return response.status(410).send({
                message: "emailObrigatorio",
            });
        }

        const model = ConvertOTPBodyModel.toOTPBodyModel(JSON.stringify(request.body));

        let retorno = await repository.check(model.email);

        if (!retorno.emailExiste) {
            return response.status(412).send({
                message: "emailInexistente",
            });
        }
        const usuarioRetorno = await repository.get(model.email);

        const otp = await sendOTPEmail(model.email);

        const otpModel: OTPModel = {
            usua_id: usuarioRetorno.usuaId,
            uotp_key: parseInt(otp),
            uotp_id: 0,
            uotp_verified: false,
            created_at: "",
            updated_at: null,
        };

        retorno = await otpRepository.send(otpModel);

        return response.status(200).send(retorno);
    }

    async verfyOTP(request: Request, response: Response) {
        if (Util.isEmpty(request.body)) {
            return response.status(410).send({
                message: "emailObrigatorio",
            });
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
