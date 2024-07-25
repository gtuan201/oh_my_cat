import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:mood_press/providers/test_provider.dart';
import 'package:mood_press/screen/healing/test/result_sceen.dart';
import 'package:mood_press/screen/healing/test/widget/item_question.dart';
import 'package:provider/provider.dart';

import '../../../data/model/test.dart';

class TestDetailScreen extends StatefulWidget {
  final Test test;
  const TestDetailScreen({super.key, required this.test});

  @override
  State<TestDetailScreen> createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.colorPrimary,
      appBar: AppBar(
        backgroundColor: ColorName.colorPrimary,
        elevation: 0,
      ),
      body: PopScope(
        onPopInvoked: (b){
          context.read<TestProvider>().endTest = false;
          widget.test.clearAllAnswers();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(widget.test.note ?? '',
                style: TextStyle(color: Colors.blueGrey.shade100,fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28,),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => ItemQuestion(
                    question: widget.test.questions[index],
                    index: index,
                    length: widget.test.questions.length,
                    test: widget.test,
                  ),
                  separatorBuilder: (_,index) => const SizedBox(height: 20,),
                  itemCount: widget.test.questions.length,
                  shrinkWrap: true,
                ),
              ),
              Selector<TestProvider,bool>(
                  builder: (context,enable,child) => ElevatedButton(
                      onPressed: enable ? (){
                        Get.off(() => ResultScreen(test: widget.test,));
                        widget.test.dateCompleted = DateTime.now();
                        context.read<TestProvider>().addTestResult(widget.test);
                      } : null,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: enable ? Colors.green : Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      child: const Text("Làm xong")
                  ),
                  selector: (_,provider) => provider.endTest
              )
            ],
          ),
        ),
      ),
    );
  }
}
