import { randomInt } from "crypto";
import nodemailer from "nodemailer";

export function generateOTP(): string {
    return randomInt(100000, 1000000).toString();
}

export async function sendOTPEmail(recipientEmail: string, otp: string): Promise<void> {
    const user = process.env.OTP_EMAIL_USER?.trim();
    const password = process.env.OTP_EMAIL_PASSWORD;
    if (!user || !password) {
        throw new Error("OTP_EMAIL_USER and OTP_EMAIL_PASSWORD must be configured.");
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
