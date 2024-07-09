import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConcludeWidget extends StatefulWidget {
  final String title;
  final String content;

  const ConcludeWidget({super.key, required this.title, required this.content});

  @override
  State<ConcludeWidget> createState() => _ConcludeWidgetState();
}

class _ConcludeWidgetState extends State<ConcludeWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: Colors.blueGrey.withBlue(140),
                width: 3
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(height: 12,),
            Text(
              widget.content,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        )
    );
  }
}
