import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showNotification(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

void showNotificationError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    backgroundColor: Colors.red,
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    behavior: SnackBarBehavior.floating,
    //margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height-120),
    elevation: 100,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  ),
).closed.then((reason) {
  // Do something when the snackbar is dismissed
});
}

void showNotificationSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    backgroundColor: Colors.green,
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    behavior: SnackBarBehavior.floating,
    //margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height-120),
    elevation: 100,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  ),
).closed.then((reason) {
  // Do something when the snackbar is dismissed
});
}
void showNotificationSuccessWithDuration(BuildContext context, String message,int duration) {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    backgroundColor: Colors.green,
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    behavior: SnackBarBehavior.floating,
    //margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height-120),
    elevation: 100,
    duration: Duration(seconds: duration),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  ),
).closed.then((reason) {
  // Do something when the snackbar is dismissed
});
}
