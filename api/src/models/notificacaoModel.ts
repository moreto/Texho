export interface NotificacaoModel {
  notiId: number;
  notiData: Date;
  notiTexto: string;
  notiTipo: string;
  notiErro: string;
  usuaId: number;
  logId: number;
}

// Converts JSON strings to/from your types
export class ConvertNotificacaoModel {
  public static toNotificacaoModel(json: string): NotificacaoModel {
    return JSON.parse(json);
  }

  public static notificacaoModelToJson(value: NotificacaoModel): string {
    return JSON.stringify(value);
  }
}
