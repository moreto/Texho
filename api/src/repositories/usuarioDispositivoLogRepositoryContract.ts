import { UsuarioDispositivoBodyModel } from "../models/usuario/usuario_dispositivo_body_model";

export interface UsuarioDispositivoLogRepositoryContract {
    post(model: UsuarioDispositivoBodyModel): Promise<unknown[]>;
}
