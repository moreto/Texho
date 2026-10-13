// To parse this data:
//
//   import { Convert, EmpresaModel } from "./file";
//
//   const empresaModel = Convert.toEmpresaModel(json);

export interface EmpresaModel {
    empr_id: number;
    empr_uuid: string;
    empr_nome: string;
}

// Converts JSON strings to/from your types
export class EmpresaModelConvert {
    public static toEmpresaModel(json: string): EmpresaModel {
        return JSON.parse(json);
    }

    public static empresaModelToJson(value: EmpresaModel): string {
        return JSON.stringify(value);
    }
}
