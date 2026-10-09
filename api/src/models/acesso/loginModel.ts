// To parse this data:
//
//   import { Convert, LoginModel } from "./file";
//
//   const loginModel = Convert.toLoginModel(json);

export interface LoginModel {
    usuaId: number;
    token: string;
}

// Converts JSON strings to/from your types
export class LoginModelConvert {
    public static toLoginModel(json: string): LoginModel {
        return JSON.parse(json);
    }

    public static loginModelToJson(value: LoginModel): string {
        return JSON.stringify(value);
    }
}
