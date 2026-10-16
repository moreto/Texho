import { NotificacaoModel } from "../../models/notificacaoModel";

export interface NotificacaoRepositoryContract {
    get(): Promise<unknown[]>;
    post(model: NotificacaoModel): Promise<string>;
}
