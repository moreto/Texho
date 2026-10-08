import { randomInt } from "crypto";
import nodemailer from "nodemailer";

export function generateOTP(): string {
    return randomInt(100000, 1000000).toString();
}

export async function sendOTPEmail(recipientEmail: string, otp: string): Promise<void> {
    // user: "texhoapiservice@gmail.com", // seu email
    // pass: "enjb twqz akwf pxey", // senha de app do Gmail

    const user = "texhoapiservice@gmail.com";
    const password = "enjb twqz akwf pxey";
    if (!user || !password) {
        throw new Error("OTP email credentials are not configured.");
    }

    const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
            user,
            pass: password,
        },
    });

    const mailOptions = {
        from: `"TEXHO" <${user}>`,
        to: recipientEmail,
        subject: "Seu código OTP",
        text: `Seu código de verificação é: ${otp}. Ele expira em 5 minutos.`,
    };
    await transporter.sendMail(mailOptions);
}
