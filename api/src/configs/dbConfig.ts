import { Pool, types } from "pg";

function requiredEnvironmentVariable(name: string): string {
    const value = process.env[name]?.trim();
    if (!value) {
        throw new Error(`Missing required environment variable: ${name}`);
    }
    return value;
}

const portValue = process.env.PGPORT ?? "5432";
const port = Number(portValue);
if (!Number.isInteger(port) || port < 1 || port > 65535) {
    throw new Error("PGPORT must be an integer between 1 and 65535.");
}

const poolMax = Number(process.env.PGPOOL_MAX ?? "3");
if (!Number.isInteger(poolMax) || poolMax < 1) {
    throw new Error("PGPOOL_MAX must be a positive integer.");
}

const rejectUnauthorizedValue = process.env.PGSSL_REJECT_UNAUTHORIZED?.toLowerCase();
if (rejectUnauthorizedValue && !["true", "false"].includes(rejectUnauthorizedValue)) {
    throw new Error("PGSSL_REJECT_UNAUTHORIZED must be true or false.");
}

const ssl =
    process.env.PGSSL?.toLowerCase() === "false"
        ? false
        : { rejectUnauthorized: rejectUnauthorizedValue !== "false" };

types.setTypeParser(20, (value) => Number.parseInt(value, 10));

export default new Pool({
    host: requiredEnvironmentVariable("PGHOST"),
    port,
    database: requiredEnvironmentVariable("PGDATABASE"),
    user: requiredEnvironmentVariable("PGUSER"),
    password: requiredEnvironmentVariable("PGPASSWORD"),
    ssl,
    max: poolMax,
    connectionTimeoutMillis: 10000,
    idleTimeoutMillis: 25000,
    query_timeout: 5000,
    statement_timeout: 10000,
    keepAlive: true,
    keepAliveInitialDelayMillis: 30000,
});
