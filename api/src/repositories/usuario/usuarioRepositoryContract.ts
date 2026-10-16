export interface UsuarioRepositoryContract {
    usuarioDetalheById(usuaId: number): Promise<unknown[]>;
}
