import 'package:flutter/material.dart';
import '../constants/constants.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}
