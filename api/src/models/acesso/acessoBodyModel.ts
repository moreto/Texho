// To parse this data:
//
//   import { Convert, AcessoBodyModel } from "./file";
//
//   const acessoBodyModel = Convert.toAcessoBodyModel(json);

export interface AcessoBodyModel {
    email: string;
    senha: string;
}

// Converts JSON strings to/from your types
export class ConvertAcessoBodyModel {
    public static toAcessoBodyModel(json: string): AcessoBodyModel {
        return JSON.parse(json);
    }

    public static acessoBodyModelToJson(value: AcessoBodyModel): string {
        return JSON.stringify(value);
    }
}
