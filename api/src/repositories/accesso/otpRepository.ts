import { Database } from "../../commons/database";
import { OTPModel } from "../../models/acesso/otpModel";
import { OTPRepositoryContract } from "../acessoRepositoryContracts";

class OTPRepository implements OTPRepositoryContract {
    async send(model: Pick<OTPModel, "usua_id" | "uotp_key">) {
        try {
            const query = {
                text:
                    "INSERT INTO usuario_otp (usua_id, uotp_key, uotp_verified) " +
                    "VALUES($1, $2, false) RETURNING uotp_id;",
                values: [model.usua_id, model.uotp_key],
            };
            return await Database.DbQuery(query);
        } catch (error) {
            throw error;
        }
    }

    async verify(email: string, code: number): Promise<boolean> {
        const query = {
            text:
                "UPDATE usuario_otp AS otp " +
                "SET uotp_verified = true " +
                "FROM usuario AS user_account " +
                "WHERE otp.usua_id = user_account.usua_id " +
                "AND user_account.usua_email = $1 " +
                "AND user_account.usua_ativo = true " +
                "AND otp.uotp_key = $2 " +
                "AND otp.uotp_verified = false " +
                "AND otp.created_at >= CURRENT_TIMESTAMP - INTERVAL '5 minutes' " +
                "RETURNING otp.uotp_id;",
            values: [email, code],
        };
        const result = await Database.DbQueryList(query);
        return result.length > 0;
    }
}

export { OTPRepository };
