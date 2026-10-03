// To parse this data:
//
//   import { Convert, OTPModel } from "./file";
//
//   const oTPModel = Convert.toOTPModel(json);

export interface OTPModel {
    uotp_id: number;
    usua_id: number;
    uotp_key: number;
    uotp_verified: boolean;
    created_at: string;
    updated_at: null;
}

// Converts JSON strings to/from your types
export class ConvertOTPModel {
    public static toOTPModel(json: string): OTPModel {
        return JSON.parse(json);
    }

    public static oTPModelToJson(value: OTPModel): string {
        return JSON.stringify(value);
    }
}
