import { AcessoBodyModel } from "../models/acesso/acessoBodyModel";
import { OTPModel } from "../models/acesso/otpModel";
import { NotificacaoModel } from "../models/notificacaoModel";

export interface AcessoRepositoryContract {
    check(email: string): Promise<{ emailExiste: boolean }>;
    register(model: AcessoBodyModel): Promise<unknown>;
    get(email: string): Promise<unknown>;
    getUserId(email: string): Promise<{ usuaId: number } | undefined>;
}

export interface OTPRepositoryContract {
    send(model: Pick<OTPModel, "usua_id" | "uotp_key">): Promise<unknown>;
    verify(email: string, code: number): Promise<boolean>;
}

export interface NotificacaoRepositoryContract {
    get(): Promise<unknown[]>;
    post(model: NotificacaoModel): Promise<string>;
}
