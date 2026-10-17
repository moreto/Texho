import { EmpresaUsuarioBodyModel } from "../../models/empresa/empresaUsuarioBodyModel";

export interface EmpresaUsuarioRepositoryContract {
    getByEmpresaUsuarioId(emprId: number): Promise<unknown[]>;
    getByEmpresaUsuarioIdDetalhe(emprId: number): Promise<unknown[]>;
    post(emprId: number, model: EmpresaUsuarioBodyModel): Promise<unknown>;
}
