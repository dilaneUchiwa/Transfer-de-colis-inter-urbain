class Format {
  static validateAndFormatEmail(String email) {
    if (email == null || email.isEmpty) {
      throw Exception('L\'adresse e-mail ne peut pas être vide.');
    }

    final trimmedEmail = email.trim();
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');

    if (!regex.hasMatch(trimmedEmail)) {
      throw Exception('L\'adresse e-mail est mal formatée.');
    }

    return trimmedEmail.toLowerCase();
  }

  static bool isEmailValid(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    final phoneRegExp = RegExp(r'^6[0-9]{8}$');
    return phoneRegExp.hasMatch(phoneNumber);
  }
}
