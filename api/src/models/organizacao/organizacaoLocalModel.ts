// To parse this data:
//
//   import { Convert, OrganizacaoLocalModel } from "./file";
//
//   const organizacaoLocalModel = Convert.toOrganizacaoLocalModel(json);

export interface OrganizacaoLocalModel {
    id:       number;
    nome:     string;
    children: OrganizacaoLocalModel[];
}

// Converts JSON strings to/from your types
export class Convert {
    public static toOrganizacaoLocalModel(json: string): OrganizacaoLocalModel {
        return JSON.parse(json);
    }

    public static organizacaoLocalModelToJson(value: OrganizacaoLocalModel): string {
        return JSON.stringify(value);
    }
}
