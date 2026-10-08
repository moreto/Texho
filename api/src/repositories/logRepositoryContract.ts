import { LogBodyModel } from "../models/logBodyModel";

export interface LogRepositoryContract {
    post(model: LogBodyModel): Promise<{ log_id: number } | undefined>;
}
