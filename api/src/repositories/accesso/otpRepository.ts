import { Database } from "../../commons/database";
import { OTPModel } from "../../controllers/acesso/otpModel";
import { OTPRepositoryContract } from "../acessoRepositoryContracts";

class OTPRepository implements OTPRepositoryContract {
    async send(model: Pick<OTPModel, "usua_id" | "uotp_key">) {
        try {
            const query = {
                text: "INSERT INTO usuario_otp (usua_id, uotp_key) VALUES($1, $2);",
                values: [model.usua_id, model.uotp_key],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }
}

export { OTPRepository };
