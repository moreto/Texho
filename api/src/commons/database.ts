import camelcaseKeys from "camelcase-keys";
import * as Config from "../configs/config.json";
import pool from "../configs/dbConfig";
import { Log } from "./log";


export class Database {
    // constructor() {}

    static async DbQuery(query: { text: string; values: any }, status: string = "") {
        const start = Date.now();
        let client = await pool.connect();
        try {
            const result = await client.query(query);
            Config.poolLog ? Log.print("pool total.: " + pool.totalCount + ", idle.: " + pool.idleCount + ", waiting.: " + pool.waitingCount) : null;
            client.release();
            Config.queryLog ? Log.print(query.text) : null;
            Config.queryParametersLog ? Log.print(query.values) : null;
            Config.queryDetails ? Log.print(result.command + " - " + result.rowCount + " row(s)") : null;
            Config.queryResultLog ? Log.print(result.rows) : null;

            const rm = camelcaseKeys(result.rows[0]);
            const stop = Date.now();
            Config.queryTime ? Log.print(`Query Time = ${(stop - start) / 1000} seconds`) : null;
            return rm;
        } catch (err: unknown) {
            client.release();
            throw err;
        }
    }

    static async DbQueryList(query: { text: string; values: any }, status: string = "") {
        const start = Date.now();
        let client = await pool.connect();
        try {
            const result = await client.query(query);
            Config.poolLog ? Log.print("pool total.: " + pool.totalCount + ", idle.: " + pool.idleCount + ", waiting.: " + pool.waitingCount) : null;
            client.release();
            Config.queryLog ? Log.print(query.text) : null;
            Config.queryParametersLog ? Log.print(query.values) : null;
            Config.queryDetails ? Log.print(result.command + " - " + result.rowCount + " row(s)") : null;
            Config.queryResultLog ? Log.print(result.rows) : null;

            const rm = camelcaseKeys(result.rows);
            const stop = Date.now();
            Config.queryTime ? Log.print(`Query Time = ${(stop - start) / 1000} seconds`) : null;
            return rm;
        } catch (err: unknown) {
            client.release();
            throw err;
        }
    }

    // static async DbQueryList(query: { text: string; values: any }, status: string = "") {
    //     const start = Date.now();
    //     let client = await pool.connect();
    //     try {
    //         const result = await client.query(query);
    //         Config.poolLog ? Log.print("pool total.: " + pool.totalCount + ", idle.: " + pool.idleCount + ", waiting.: " + pool.waitingCount) : null;
    //         client.release();
    //         Config.queryLog ? Log.print(query.text) : null;
    //         Config.queryParametersLog ? Log.print(query.values) : null;
    //         Config.queryDetails ? Log.print(result.command + " - " + result.rowCount + " row(s)") : null;
    //         Config.queryResultLog ? Log.print(result.rows) : null;

    //         const rm = new RetornoModel();
    //         rm.valid = true;
    //         // rm.command = result.command;
    //         // if (status == "") {
    //         //   rm.message = NotificacaoEnum.OK;
    //         // } else {
    //         //   rm.message = status;
    //         // }
    //         rm.rowCount = result.rowCount!;
    //         rm.data = camelcaseKeys(result.rows);
    //         const stop = Date.now();
    //         Config.queryTime ? Log.print(`Query Time = ${(stop - start) / 1000} seconds`) : null;
    //         return rm;
    //     } catch (err: unknown) {
    //         client.release();
    //         // Erro.printErro(err);
    //     }
    // }

    // static async DbQueryObject(query: { text: string; values: any }, status: string = "", cc: boolean = true) {
    //     const start = Date.now();
    //     let client = await pool.connect();
    //     try {
    //         const result = await client.query(query);
    //         Config.poolLog ? Log.print("pool total.: " + pool.totalCount + ", idle.: " + pool.idleCount + ", waiting.: " + pool.waitingCount) : null;
    //         client.release();
    //         Config.queryLog ? Log.print(query.text) : null;
    //         Config.queryParametersLog ? Log.print(query.values) : null;
    //         Config.queryDetails ? Log.print(result.command + " - " + result.rowCount + " row(s)") : null;
    //         Config.queryResultLog ? Log.print(result.rows) : null;

    //         const rm = new RetornoModel();
    //         rm.valid = true;
    //         // rm.command = result.command;
    //         // if (status == "") {
    //         //   rm.message = NotificacaoEnum.OK;
    //         // } else {
    //         //   rm.message = status;
    //         // }

    //         let retRows;
    //         if (result.rows != null) {
    //             retRows = cc ? camelcaseKeys(result.rows[0]) : result.rows[0];
    //         } else {
    //             retRows = [];
    //         }

    //         rm.rowCount = result.rowCount!;
    //         // rm.rows = result.rows != null ? result.rows[0] : [];
    //         rm.data = retRows;
    //         const stop = Date.now();
    //         Config.queryTime ? Log.print(`Query Time = ${(stop - start) / 1000} seconds`) : null;
    //         return rm;
    //     } catch (err: unknown) {
    //         client.release();
    //         throw err;
    //         // Erro.printErro(err);
    //     }
    // }

    // static async DbQueryCount(query: { text: string; values: any }, status: string = "") {
    //     const start = Date.now();
    //     let client = await pool.connect();
    //     try {
    //         const result = await client.query(query);
    //         Config.poolLog ? Log.print("pool total.: " + pool.totalCount + ", idle.: " + pool.idleCount + ", waiting.: " + pool.waitingCount) : null;
    //         client.release();
    //         Config.queryLog ? Log.print(query.text) : null;
    //         Config.queryParametersLog ? Log.print(query.values) : null;
    //         Config.queryDetails ? Log.print(result.command + " - " + result.rowCount + " row(s)") : null;
    //         Config.queryResultLog ? Log.print(result.rows) : null;

    //         const rm = new RetornoModel();
    //         rm.valid = true;
    //         // rm.command = result.command;
    //         // if (status == "") {
    //         //   rm.message = NotificacaoEnum.OK;
    //         // } else {
    //         //   rm.message = status;
    //         // }
    //         rm.rowCount = result.rowCount!;
    //         rm.data = result.rows != null ? result.rows[0] : [];
    //         const stop = Date.now();
    //         Config.queryTime ? Log.print(`Query Time = ${(stop - start) / 1000} seconds`) : null;
    //         return rm;
    //     } catch (err: unknown) {
    //         client.release();
    //         // Erro.printErro(err);
    //     }
    // }

    // static async DbQuery(query: { text: string; values: any }) {
    //     let client = await pool.connect();
    //     try {
    //         const result = await client.query(query);
    //         Config.poolLog ? Log.print("pool total.: " + pool.totalCount + ", idle.: " + pool.idleCount + ", waiting.: " + pool.waitingCount) : null;

    //         client.release();

    //         return result.rows[0];
    //     } catch (err: unknown) {
    //         client.release();
    //     }
    // }
}
