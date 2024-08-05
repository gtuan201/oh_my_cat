import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/ulti/constant.dart';

class PinCodeInput extends StatefulWidget {
  final RxString pin;

  PinCodeInput({super.key, required this.pin});

  @override
  _PinCodeInputState createState() => _PinCodeInputState();
}

class _PinCodeInputState extends State<PinCodeInput> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return index < widget.pin.value.length
          ? Container(
              margin: const EdgeInsets.symmetric(vertical: 24,horizontal: 8),
              child: Constant.listEmoji[9].svg(width: 24,height: 24))
          : Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.symmetric(vertical: 24,horizontal: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey,width: 2),
              ),
            );
      }),
    ));
  }
}