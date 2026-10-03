// To parse this data:
//
//   import { Convert, OTPModel } from "./file";
//
//   const oTPModel = Convert.toOTPModel(json);

export interface OTPBodyModel {
    email: string;
}

// Converts JSON strings to/from your types
export class ConvertOTPBodyModel {
    public static toOTPBodyModel(json: string): OTPBodyModel {
        return JSON.parse(json);
    }

    public static oTPBodyModelToJson(value: OTPBodyModel): string {
        return JSON.stringify(value);
    }
}
