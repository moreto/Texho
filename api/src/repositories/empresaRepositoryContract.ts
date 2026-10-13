export interface EmpresaRepositoryContract {
    getById(emprId: number): Promise<unknown[]>;
}
