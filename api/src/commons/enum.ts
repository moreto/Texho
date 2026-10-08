enum LogTypes {
    SYSTEM = "SYSTEM",
    APPLICATION = "APPLICATION",
    SECURITY = "SECURITY",
    EVENT = "EVENT",
    ERROR = "ERROR",
    ACCESS = "ACCESS",
    AUDIT = "AUDIT",
    DEBUG = "DEBUG",
    VALIDATION = "VALIDATION",
}

enum NotificacaoTypes {
    LOG = "LOG",
    ERROR = "ERROR",
    DEBUG = "DEBUG",
    VALIDATION = "VALIDATION",
}

export { LogTypes, NotificacaoTypes };
