import nodemailer from "nodemailer";

function generateOTP(): string {
    return Math.floor(100000 + Math.random() * 900000).toString();
}

export async function sendOTPEmail(recipientEmail: string): Promise<string> {
    const otp = generateOTP();

    const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
            user: "texhoapiservice@gmail.com", // seu email
            pass: "enjb twqz akwf pxey", // senha de app do Gmail
        },
    });

    const mailOptions = {
        from: `"TEXHO" <texhoapiservice@gmail.com>`,
        to: recipientEmail,
        subject: "Seu código OTP",
        text: `Seu código de verificação é: ${otp}. Ele expira em 5 minutos.`,
    };

    await transporter.sendMail(mailOptions);
    return otp;
}
