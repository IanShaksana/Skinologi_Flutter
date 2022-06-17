import 'package:encrypt/encrypt.dart';

class GenUtil {
  String encryption(String plainText) {
    final key = Key.fromUtf8("OhLordYouLoveMee");
    final iv = IV.fromSecureRandom(16);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // return encrypted.base64 + ":" + iv.base64;
    return plainText;
  }

  String decryption(String plainText) {
    final key = Key.fromUtf8("OhLordYouLoveMee");
    String yuhuu = plainText.split(":")[1];
    final iv = IV.fromBase64(yuhuu);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
    final decrypted =
        encrypter.decrypt(Encrypted.from64(plainText.split(":")[0]), iv: iv);

    return decrypted;
  }
}
