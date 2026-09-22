// import { InsertedModelConvert } from "../models/insertedModel";
// import { NotificacaoModel } from "../models/notificacaoModel";
// import { NotificacaoRepository } from "../repositories/notificacaoRepository";


// export class Notificacao {
//   static async notificar(notificacao: NotificacaoModel) {
//     try {
//       const not = new NotificacaoRepository();
//       const notIdGravado = await not.post(notificacao);

//       const inserted = InsertedModelConvert.toInsertedModel(notIdGravado);

//       const notGravado = await not.getById(inserted.id);

//       return notGravado;
//     } catch (error) {
//       throw error;
//     }
//   }
// }
