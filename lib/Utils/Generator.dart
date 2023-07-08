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

 int generateTransferCode() {
  var now = DateTime.now();
  var code = int.parse(
    now.millisecond.toString().padLeft(3, '0') +
    now.second.toString().padLeft(2, '0') +
    now.minute.toString().padLeft(2, '0') +
    ((now.hour * 60 + now.minute) % 1000).toString().padLeft(3, '0')
  );
  return code;
}
}
