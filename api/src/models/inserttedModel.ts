// To parse this data:
//
//   import { Convert, InsertedModel } from "./file";
//
//   const insertedModel = Convert.toInsertedModel(json);

export interface InsertedModel {
    id: number;
}

// Converts JSON strings to/from your types
export class InsertedModelConvert {
    public static toInsertedModel(json: string): InsertedModel {
        return JSON.parse(json);
    }

    public static insertedModelToJson(value: InsertedModel): string {
        return JSON.stringify(value);
    }
}
