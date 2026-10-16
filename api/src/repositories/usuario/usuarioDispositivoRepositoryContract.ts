import { UsuarioDispositivoBodyModel } from "../../models/usuario/usuario_dispositivo_body_model";

export interface UsuarioDispositivoRepositoryContract {
    post(model: UsuarioDispositivoBodyModel): Promise<unknown[]>;
    getByDeviceId(deviceId: string): Promise<unknown[]>;
}
