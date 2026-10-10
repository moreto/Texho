export interface UsuarioDispositivoRepositoryContract {
    post(usuaId: number): Promise<unknown[]>;
}
