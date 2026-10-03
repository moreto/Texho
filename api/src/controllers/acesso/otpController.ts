import { Request, Response } from "express";
import { sendOTPEmail } from "../../commons/otp";
import { Util } from "../../commons/util";
import { ConvertOTPModel } from "../../models/acesso/otpModel";

class OTPController {
    async sendOTP(request: Request, response: Response) {
        if (Util.isEmpty(request.body)) {
            return response.status(410).send({
                message: "emailObrigatorio",
            });
        }

        const model = ConvertOTPModel.toOTPModel(JSON.stringify(request.body));

        const retorno = await sendOTPEmail(model.email);

        // otpStore[email] = { otp, expires: Date.now() + 5 * 60 * 1000 }; // expira em 5 min
        // response.json({ message: "OTP enviado para o e-mail." });
        return response.status(200).send(retorno);
    }
}

export { OTPController };
