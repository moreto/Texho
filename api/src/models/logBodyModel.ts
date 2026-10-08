// To parse this data:
//
//   import { Convert, LogBodyModel } from "./file";
//
//   const logBodyModel = Convert.toLogBodyModel(json);

export interface LogBodyModel {
    log_tipo: string;
    log_info: string;
    usua_id: number;
    log_texto: string;
}

// Converts JSON strings to/from your types
export class LogBodyModelConvert {
    public static toLogBodyModel(json: string): LogBodyModel {
        return JSON.parse(json);
    }

    public static logBodyModelToJson(value: LogBodyModel): string {
        return JSON.stringify(value);
    }
}
