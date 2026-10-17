import {
    EmpresaUsuarioBodyModel,
    EmpresaUsuarioVinculoBodyModel,
    EmpresaUsuarioVinculoResult,
} from "../../models/empresa/empresaUsuarioBodyModel";

export interface EmpresaUsuarioRepositoryContract {
    getByEmpresaUsuarioId(emprId: number): Promise<unknown[]>;
    getByEmpresaUsuarioIdDetalhe(emprId: number): Promise<unknown[]>;
    post(emprId: number, model: EmpresaUsuarioBodyModel): Promise<unknown>;
    vincular(usuaEmail: string, model: EmpresaUsuarioVinculoBodyModel): Promise<EmpresaUsuarioVinculoResult>;
}
