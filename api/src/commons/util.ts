/**
 * Utility functions for common operations.
 */
export class Util {
    /**
     * Normalizes a port value into a number, string, or false.
     * @param val - The port value to normalize.
     * @returns The normalized port (number | string | false).
     */
    static normalizePort(val: string): number | string | false {
        const port = Number(val);
        if (Number.isNaN(port)) return val;
        if (port >= 0) return port;
        return false;
    }

    static isEmpty(value: any) {
        return value === undefined || value == null || value.length <= 0 ? true : false;
    }
}