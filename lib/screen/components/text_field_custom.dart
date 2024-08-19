import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/gen/colors.gen.dart';

class TextFieldCustom extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final int? maxLength;
  final FocusNode? focusNode;

  const TextFieldCustom({super.key, required this.controller, this.hint, this.maxLength, this.focusNode});

  @override
  TextFieldCustomState createState() => TextFieldCustomState();
}

class TextFieldCustomState extends State<TextFieldCustom> {

  RxInt counter = 0.obs;

  @override
  void initState() {
    super.initState();
    counter.value = widget.controller.text.length;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          cursorColor: Theme.of(context).splashColor,
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: TextStyle(color: Colors.blueGrey.shade100),
          maxLines: null,
          maxLength: widget.maxLength,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
          onChanged: (s){
            counter.value = s.length;
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 30),
            hintStyle: TextStyle(color: Colors.blueGrey.shade200),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Theme.of(context).cardColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Theme.of(context).cardColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Theme.of(context).cardColor),
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            counterText: ''
          ),
        ),
        if(widget.maxLength != null)
        Obx(() => Positioned(
          right: 10,
          bottom: 10,
          child: Text('${counter.value} / ${widget.maxLength}',style: TextStyle(color: Theme.of(context)
              .switchTheme
              .thumbColor
              ?.resolve({WidgetState.selected})),),
        ),)
      ],
    );
  }
}
