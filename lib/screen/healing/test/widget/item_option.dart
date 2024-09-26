import 'package:flutter/material.dart';

class ItemOption extends StatefulWidget {
  final String option;
  final int index;
  final int? selectedOption;
  final Function(int?) onChange;

  const ItemOption({
    super.key,
    required this.option,
    required this.index, this.selectedOption, required this.onChange,
  });

  @override
  State<ItemOption> createState() => _ItemOptionState();
}

class _ItemOptionState extends State<ItemOption> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onChange(widget.index);
      },
      child: Row(
        children: [
          Expanded(child: Text(widget.option, style: const TextStyle(color: Colors.white),maxLines: 2,)
          ),
          Radio(
            value: widget.index,
            groupValue: widget.selectedOption,
            fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Theme.of(context).splashColor;
              }
              return Colors.white;
            }),
            onChanged: widget.onChange
          )
        ],
      ),
    );
  }
}