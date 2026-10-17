import { EmpresaBodyModel } from "../../models/empresa/empresaBodyModel";
import { EmpresaModel } from "../../models/empresa/empresaModel";

export interface EmpresaRepositoryContract {
    getById(emprId: number): Promise<unknown[]>;
    getByCodigo(emprCodigo: string): Promise<unknown[]>;
    post(model: EmpresaBodyModel): Promise<unknown[]>;
    put(model: EmpresaModel): Promise<unknown[]>;
}
