import { AcessoBodyModel } from "../models/acesso/acessoBodyModel";
import { OTPModel } from "../models/acesso/otpModel";
import { NotificacaoModel } from "../models/notificacaoModel";

export interface AcessoRepositoryContract {
    check(email: string): Promise<{ emailExiste: boolean }>;
    register(model: AcessoBodyModel): Promise<unknown>;
    // get(email: string): Promise<{ usuaId: number }>;
    get(email: string): Promise<unknown>;
}

export interface OTPRepositoryContract {
    send(model: Pick<OTPModel, "usua_id" | "uotp_key">): Promise<unknown>;
}

export interface NotificacaoRepositoryContract {
    post(model: NotificacaoModel): Promise<string>;
}
