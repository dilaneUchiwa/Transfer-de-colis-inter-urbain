import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Transfert.dart';

import '../../Config/AppConfig.dart';
import '../../Utils/Generator.dart';
import '../../Utils/InternetChecker.dart';

class MailerService {
  static String username = 'EasyTransfer237@gmail.com';
  static String password = 'fvokmoyfxqtoeqvd';

  static Future<SendReport?> sendMail(
      String recipient, String subject, String body) async {
    // Note that using a username and password for gmail only works if
    // you have two-factor authentication enabled and created an App password.
    // Search for "gmail app password 2fa"
    // The alternative is to use oauth.

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, AppConfig.appName)
      ..recipients.add(recipient)
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = subject
      //..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = body;

    try {
      return await send(message, smtpServer);
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return null;
    } on SocketException catch (e) {
      return null;
    }
    // DONE
  }

  static Future<int> sendValidationCode(String dest) async {
    int validationCode = Generator.generateSixDigitNumber();
    if (await InternetChecker.checkInternetConnection()) {
      MailerService.sendMail(dest, "Your verification code",
          "<h3 style=\"text-align: center;\">Your verification code is </h3></br><b><h1 style=\"text-align: center;\">$validationCode</h1></b>");
      return validationCode;
    } else {
      return 0;
    }
  }

  static Future<int> sendColisAccept(String dest, Transfert transfert) async {
    int validationCode = Generator.generateSixDigitNumber();
    if (await InternetChecker.checkInternetConnection()) {
      MailerService.sendMail(dest, "Your Colis accept by traveller",
          "<h3 style=\"text-align: center;\">Transfer of colis:${transfert.package.packageDescription} by ${transfert.travel.user.userName} ${transfert.travel.user.userSurname} was accept </h3></br><b><h1 style=\"text-align: center;\">${transfert.travel.travelDate} (${transfert.travel.travelMoment}) at ${transfert.travel.agence}(${transfert.travel.quarterDeparture})</h1></b>");
      return validationCode;
    } else {
      return 0;
    }
  }
  static Future<int> sendColisReject(String dest, Transfert transfert) async {
    int validationCode = Generator.generateSixDigitNumber();
    if (await InternetChecker.checkInternetConnection()) {
      MailerService.sendMail(dest, "Your Colis reject by traveller",
          "<h3 style=\"text-align: center;\">Transfer of colis:${transfert.package.packageDescription} by ${transfert.travel.user.userName} ${transfert.travel.user.userSurname} was reject</h1></b>");
      return validationCode;
    } else {
      return 0;
    }
  }

  // static Future<void> sendMail(String recipient, String subject, String body) async {
  //   // Note that using a username and password for gmail only works if
  //   // you have two-factor authentication enabled and created an App password.
  //   // Search for "gmail app password 2fa"
  //   // The alternative is to use oauth.

  //   final smtpServer = gmail(username, password);
  //   // Use the SmtpServer class to configure an SMTP server:
  //   // final smtpServer = SmtpServer('smtp.domain.com');
  //   // See the named arguments of SmtpServer for further configuration
  //   // options.

  //   // Create our message.
  //   final message = Message()
  //     ..from = Address(username, 'Your name')
  //     ..recipients.add('destination@example.com')
  //     ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
  //     ..bccRecipients.add(Address('bccAddress@example.com'))
  //     ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
  //     ..text = 'This is the plain text.\nThis is line 2 of the text part.'
  //     ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     print('Message sent: ' + sendReport.toString());
  //   } on MailerException catch (e) {
  //     print('Message not sent.');
  //     for (var p in e.problems) {
  //       print('Problem: ${p.code}: ${p.msg}');
  //     }
  //   }
  //   // DONE

  //   // Let's send another message using a slightly different syntax:
  //   //
  //   // Addresses without a name part can be set directly.
  //   // For instance `..recipients.add('destination@example.com')`
  //   // If you want to display a name part you have to create an
  //   // Address object: `new Address('destination@example.com', 'Display name part')`
  //   // Creating and adding an Address object without a name part
  //   // `new Address('destination@example.com')` is equivalent to
  //   // adding the mail address as `String`.
  //   final equivalentMessage = Message()
  //     ..from = Address(username, 'Your name 😀')
  //     ..recipients.add(Address('destination@example.com'))
  //     ..ccRecipients
  //         .addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
  //     ..bccRecipients.add('bccAddress@example.com')
  //     ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
  //     ..text = 'This is the plain text.\nThis is line 2 of the text part.'
  //     ..html =
  //         '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
  //     ..attachments = [
  //       FileAttachment(File('exploits_of_a_mom.png'))
  //         ..location = Location.inline
  //         ..cid = '<myimg@3.141>'
  //     ];

  //   final sendReport2 = await send(equivalentMessage, smtpServer);

  //   // Sending multiple messages with the same connection
  //   //
  //   // Create a smtp client that will persist the connection
  //   var connection = PersistentConnection(smtpServer);

  //   // Send the first message
  //   await connection.send(message);

  //   // send the equivalent message
  //   await connection.send(equivalentMessage);

  //   // close the connection
  //   await connection.close();
  // }
}
