import { Pool } from "pg";
var types = require("pg").types;

// export default new Pool({
//   types: types.setTypeParser(20, parseInt),
//   statement_timeout: 10000,
//   host: "192.168.1.10",
//   // host: host,
//   user: "mmoreto",
//   password: "mm007007",
//   port: 5432,
//   database: "texho",
//   // ssl: { rejectUnauthorized: false },
//   max: 10,
//   connectionTimeoutMillis: 10000,
//   idleTimeoutMillis: 25000,
//   query_timeout: 5000,
//   keepAlive: true,
//   keepAliveInitialDelayMillis: 30000,
// });


// PGHOST='ep-long-shape-a8gj1nho-pooler.eastus2.azure.neon.tech'
// PGDATABASE='neondb'
// PGUSER='neondb_owner'
// PGPASSWORD='npg_Cx1BrHeVF2NO'

// export default new Pool({
//   types: types.setTypeParser(20, parseInt),
//   statement_timeout: 10000,
//   host: "ep-long-shape-a8gj1nho-pooler.eastus2.azure.neon.tech",
//   // host: host,
//   user: "neondb_owner",
//   password: "npg_Cx1BrHeVF2NO",
//   port: 5432,
//   database: "neondb",
//   ssl: { rejectUnauthorized: false },
//   max: 10,
//   connectionTimeoutMillis: 10000,
//   idleTimeoutMillis: 25000,
//   query_timeout: 5000,
//   keepAlive: true,
//   keepAliveInitialDelayMillis: 30000,
// });

export default new Pool({
  types: types.setTypeParser(20, parseInt),
  statement_timeout: 10000,
  host: "192.168.1.45",
  // host: host,
  user: "casaos",
  password: "casaos",
  port: 5432,
  database: "orgnzr",
  // ssl: { rejectUnauthorized: false },
  max: 10,
  connectionTimeoutMillis: 10000,
  idleTimeoutMillis: 25000,
  query_timeout: 5000,
  keepAlive: true,
  keepAliveInitialDelayMillis: 30000,
});