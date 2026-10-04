import { AcessoBodyModel } from "../models/acesso/acessoBodyModel";
import { OTPModel } from "../models/acesso/otpModel";
import { LogBodyModel } from "../models/logBodyModel";
import { NotificacaoModel } from "../models/notificacaoModel";

export interface AcessoRepositoryContract {
    check(email: string): Promise<{ emailExiste: boolean }>;
    register(model: AcessoBodyModel): Promise<unknown>;
    get(email: string): Promise<{ usuaId: number }>;
}

export interface OTPRepositoryContract {
    send(model: Pick<OTPModel, "usua_id" | "uotp_key">): Promise<unknown>;
}

export interface NotificacaoRepositoryContract {
    post(model: NotificacaoModel): Promise<string>;
}

export interface LogDbRepositoryContract {
    post(model: LogBodyModel): Promise<{ logId: number } | undefined>;
}

export interface OrganizacaoLocalRepositoryContract {
    getTreeById(id: number): Promise<unknown>;
    get(): Promise<unknown[]>;
}

export interface TraducaoRepositoryContract {
    get(): Promise<unknown[]>;
}
