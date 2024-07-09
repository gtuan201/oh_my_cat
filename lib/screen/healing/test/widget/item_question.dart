import 'package:flutter/material.dart';
import 'package:mood_press/data/model/test.dart';
import 'package:mood_press/providers/test_provider.dart';
import 'package:mood_press/screen/healing/test/widget/item_option.dart';
import 'package:provider/provider.dart';

class ItemQuestion extends StatefulWidget {
  final Question question;
  final int index;
  final int length;
  final Test test;
  const ItemQuestion({super.key, required this.question, required this.index, required this.length, required this.test});

  @override
  State<ItemQuestion> createState() => _ItemQuestionState();
}

class _ItemQuestionState extends State<ItemQuestion> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Câu hỏi ${widget.index + 1} / ${widget.length}",style: TextStyle(color: Colors.blueGrey.shade100),),
          const SizedBox(height: 6,),
          Text(widget.question.text,style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
          Divider(color: Colors.blueGrey.shade100,),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index)
              => ItemOption(
                option : widget.question.options[index],
                index: index,
                selectedOption: widget.question.selectedOptionIndex,
                onChange: (value){
                  setState(() {
                    widget.question.selectOption(value!);
                    context.read<TestProvider>().changeStatusTest(widget.test);
                  });
                },
              ),
              separatorBuilder: (_,index) => Divider(color: Colors.blueGrey.shade100,),
              itemCount: widget.question.options.length
          )
        ],
      ),
    );
  }
}
