import 'package:flutter/material.dart';

class WaitingOverlay extends StatelessWidget {
  const WaitingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Stack(
        children: [
          ModalBarrier(color: Colors.black54),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: 100.0,
              height: 100.0,
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}