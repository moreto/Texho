import { EmpresaUsuarioBodyModel } from "../../models/empresa/empresaUsuarioBodyModel";

export interface EmpresaUsuarioRepositoryContract {
    getByEmpresaId(emprId: number): Promise<unknown[]>;
    post(emprId: number, model: EmpresaUsuarioBodyModel): Promise<unknown>;
}
