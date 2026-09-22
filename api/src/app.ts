import express, { NextFunction, Request, Response } from 'express';
import morgan from "morgan";


import defaultRoutes from './routes/default';


const app = express()
app.use(express.json())

app.use(morgan(":url :method :response-time :user-agent"));

// Rotas
app.use(defaultRoutes);

interface ErrorWithStack extends Error {
    stack?: string;
}

app.use((err: ErrorWithStack, req: Request, res: Response, next: NextFunction) => {
    console.error(err.stack);
    res.status(500).send({ message: 'Something went wrong!' });
});

export { app };
