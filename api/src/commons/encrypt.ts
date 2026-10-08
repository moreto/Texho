import crypto from "crypto";

const IV_LENGTH = 12;
const TAG_LENGTH = 16;

export function encryptString(plainText: string, base64Key: string): string {
    const iv = crypto.randomBytes(IV_LENGTH);
    const cipher = crypto.createCipheriv("aes-256-gcm", Buffer.from(base64Key, "base64"), iv);

    const encrypted = Buffer.concat([cipher.update(plainText, "utf8"), cipher.final()]);

    return Buffer.concat([iv, encrypted, cipher.getAuthTag()]).toString("base64");
}

export function decryptString(payload: string, base64Key: string): string {
    const data = Buffer.from(payload, "base64");
    const iv = data.subarray(0, IV_LENGTH);
    const tag = data.subarray(data.length - TAG_LENGTH);
    const ciphertext = data.subarray(IV_LENGTH, data.length - TAG_LENGTH);

    const decipher = crypto.createDecipheriv("aes-256-gcm", Buffer.from(base64Key, "base64"), iv);
    decipher.setAuthTag(tag);

    return Buffer.concat([
        decipher.update(ciphertext),
        decipher.final(), // lança erro se a tag for inválida
    ]).toString("utf8");
}
