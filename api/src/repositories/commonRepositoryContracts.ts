import { LogBodyModel } from "../models/logBodyModel";

export interface LogDbRepositoryContract {
    post(model: LogBodyModel): Promise<{ logId: number } | undefined>;
}

export interface TraducaoRepositoryContract {
    get(): Promise<unknown[]>;
}
