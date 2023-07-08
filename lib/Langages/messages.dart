



// chaque chaine de caractères doit etre identifieée par une clé unique

import 'package:intl/intl.dart';

class Message{
  static String get hello => Intl.message("Hello", name : "hello");
  static String get welcome => Intl.message("Welcome", name : "welcome");
  // ajouter d'autre chaines de

  // Générer les fichiers de traduction en exécutant la commande suivante dans votre terminal

/*

flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/lang lib/lang/messages.dart

*/




}