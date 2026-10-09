// To parse this data:
//
//   import { Convert, UsuarioModel } from "./file";
//
//   const usuarioModel = Convert.toUsuarioModel(json);

export interface UsuarioModel {
    usuaId: number;
    usuaEmail: string;
    usuaSenha: string;
    usuaUuid: string;
    usuaAtivo: boolean;
}

// Converts JSON strings to/from your types
export class ConvertUsuarioModel {
    public static toUsuarioModel(json: string): UsuarioModel {
        return JSON.parse(json);
    }

    public static usuarioModelToJson(value: UsuarioModel): string {
        return JSON.stringify(value);
    }
}
