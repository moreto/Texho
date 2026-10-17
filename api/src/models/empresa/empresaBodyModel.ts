// To parse this data:
//
//   import { Convert, EmpresaBodyModel } from "./file";
//
//   const empresaBodyModel = Convert.toEmpresaBodyModel(json);

export interface EmpresaBodyModel {
    emprNome: string;
    emprCodigo: string;
}

// Converts JSON strings to/from your types
export class EmpresaBodyModelConvert {
    public static toEmpresaBodyModel(json: string): EmpresaBodyModel {
        return JSON.parse(json);
    }

    public static empresaBodyModelToJson(value: EmpresaBodyModel): string {
        return JSON.stringify(value);
    }
}
