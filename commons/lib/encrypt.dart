import 'package:encrypt/encrypt.dart' as encrypt;

class Encrypt {
  String encryptText(String plainText, String keyString) {
    final key = encrypt.Key.fromUtf8(keyString.padRight(32, '0')); // chave de 32 bytes
    final iv = encrypt.IV.fromLength(16); // vetor de inicialização
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  String decryptText(String encryptedText, String keyString) {
    final key = encrypt.Key.fromUtf8(keyString.padRight(32, '0'));
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}
