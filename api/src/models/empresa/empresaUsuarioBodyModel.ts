export interface EmpresaUsuarioBodyModel {
    usua_id: number;
}

export interface EmpresaUsuarioVinculoBodyModel {
    empr_codigo: string;
}

export interface EmpresaUsuarioVinculoResult {
    emprId: number | null;
    usuaId: number | null;
    usuarioEncontrado: boolean;
    empresaEncontrada: boolean;
    vinculado: boolean;
}
