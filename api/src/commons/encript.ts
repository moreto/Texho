import * as crypto from "crypto";

function encryptText(text: string, keyString: string): string {
    const key = crypto.createHash("sha256").update(keyString).digest();
    const iv = Buffer.alloc(16, 0); // vetor de inicialização
    const cipher = crypto.createCipheriv("aes-256-cbc", key, iv);

    let encrypted = cipher.update(text, "utf8", "base64");
    encrypted += cipher.final("base64");
    return encrypted;
}

function decryptText(encryptedText: string, keyString: string): string {
    const key = crypto.createHash("sha256").update(keyString).digest();
    const iv = Buffer.alloc(16, 0);
    const decipher = crypto.createDecipheriv("aes-256-cbc", key, iv);

    let decrypted = decipher.update(encryptedText, "base64", "utf8");
    decrypted += decipher.final("utf8");
    return decrypted;
}

// // Exemplo de uso
// const secret = "minhaSenhaSuperSecreta";
// const key = "chave123";

// const encrypted = encryptText(secret, key);
// console.log("Criptografado:", encrypted);

// const decrypted = decryptText(encrypted, key);
// console.log("Decriptografado:", decrypted);
