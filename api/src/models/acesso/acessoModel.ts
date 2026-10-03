// To parse this data:
//
//   import { Convert, UsuarioModel } from "./file";
//
//   const usuarioModel = Convert.toUsuarioModel(json);

export interface UsuarioModel {
    usua_id: number;
    usua_email: string;
    usua_senha: string;
    usua_uuid: string;
    usua_ativo: boolean;
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
