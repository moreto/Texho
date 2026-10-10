// To parse this data:
//
//   import { Convert, UsuarioDispositivoBodyModel } from "./file";
//
//   const usuarioDispositivoBodyModel = Convert.toUsuarioDispositivoBodyModel(json);

export interface UsuarioDispositivoBodyModel {
    udisId: number;
    emprId: number;
    udisDeviceId: string;
    udisNome: string;
    udisSistemaOperacional: string;
}

// Converts JSON strings to/from your types
export class Convert {
    public static toUsuarioDispositivoBodyModel(json: string): UsuarioDispositivoBodyModel {
        return JSON.parse(json);
    }

    public static usuarioDispositivoBodyModelToJson(value: UsuarioDispositivoBodyModel): string {
        return JSON.stringify(value);
    }
}
