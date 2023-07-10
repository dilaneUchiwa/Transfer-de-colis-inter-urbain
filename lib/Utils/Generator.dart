import 'dart:math';

class Generator {
  static int generateSixDigitNumber() {
    final random = Random();
    const min = 100000; // Le plus petit nombre à 6 chiffres
    const max = 999999; // Le plus grand nombre à 6 chiffres
    int randomNumber = min + random.nextInt(max - min);

    while (randomNumber.toString().startsWith('0')) {
      // Générer un nouveau nombre aléatoire jusqu'à ce qu'il ne commence pas par 0
      randomNumber = min + random.nextInt(max - min);
    }

    return randomNumber;
  }

 static int generateTransferCode() {
    int now = DateTime.now().microsecondsSinceEpoch;
    int code = int.parse( (now % (pow(10, 6))).toString());

    return code;
}
}
