import defaults from "./config.json";

function requiredEnvironmentVariable(name: string): string {
    const value = process.env[name]?.trim();
    if (!value) {
        throw new Error(`Missing required environment variable: ${name}`);
    }
    return value;
}

const isProduction = process.env.NODE_ENV === "production";
const encryptionKey = requiredEnvironmentVariable("DATA_ENCRYPTION_KEY");
if (Buffer.from(encryptionKey, "base64").length !== 32) {
    throw new Error("DATA_ENCRYPTION_KEY must be a base64-encoded 32-byte key.");
}

export const Config = {
    ...defaults,
    saltKey: requiredEnvironmentVariable("JWT_SIGNING_KEY"),
    accessTokenId: requiredEnvironmentVariable("ACCESS_TOKEN_ID"),
    base64Key: encryptionKey,
    showConsole: defaults.showConsole && !isProduction,
    queryLogDb: defaults.queryLogDb && !isProduction,
    queryLog: defaults.queryLog && !isProduction,
    queryResultLog: defaults.queryResultLog && !isProduction,
    queryParametersLog: defaults.queryParametersLog && !isProduction,
    queryDetails: defaults.queryDetails && !isProduction,
    queryTime: defaults.queryTime && !isProduction,
    poolLog: defaults.poolLog && !isProduction,
    urlLog: defaults.urlLog && !isProduction,
};
