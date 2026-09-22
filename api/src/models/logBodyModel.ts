// To parse this data:
//
//   import { Convert, LogBodyModel } from "./file";
//
//   const logBodyModel = Convert.toLogBodyModel(json);

export interface LogBodyModel {
    objeto: unknown;
    logTipo: string;
    texto: string;
    usuaId: number;
}


// Converts JSON strings to/from your types
export class ConvertLogBodyModel {
    public static toLogBodyModel(json: string): LogBodyModel {
        return JSON.parse(json);
    }

    public static logBodyModelToJson(value: LogBodyModel): string {
        return JSON.stringify(value);
    }
}
