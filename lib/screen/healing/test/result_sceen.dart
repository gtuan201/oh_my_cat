import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:mood_press/providers/test_provider.dart';
import 'package:mood_press/screen/healing/test/widget/conclude_widget.dart';
import 'package:mood_press/screen/healing/test/widget/level_widget.dart';
import 'package:provider/provider.dart';
import '../../../data/model/test.dart';

class ResultScreen extends StatelessWidget {
  final Test test;

  const ResultScreen({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.colorPrimary,
      appBar: AppBar(
        backgroundColor: ColorName.colorPrimary,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
              Get.back();
              test.clearAllAnswers();
            },
            icon: Icon(
              Icons.close_rounded,
              size: 32,
              color: Colors.blueGrey.shade100,
            )),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Kểt quả của bạn",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 12,),
            Text(
              "${result()}",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700, fontSize: 54),
              textAlign: TextAlign.center,
            ),
            LevelWidget(test: test, result: result()),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Kết luận",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    levelDetail()?.conclusion ?? '',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                child: ElevatedButton(
                  onPressed: () async {
                    context.read<TestProvider>().generatePdf(levelDetail()!, test);
                  },
                  child: const Text("Xuất Pdf")
                ),
              ),
            ),
            ConcludeWidget(title: "Lời khuyên", content: levelDetail()?.recommendations ?? ''),
            if(levelDetail()?.strengths != null)
              ConcludeWidget(title: "Điểm mạnh", content: levelDetail()?.strengths ?? ''),
            if(levelDetail()?.weaknesses != null)
              ConcludeWidget(title: "Điểm yếu", content: levelDetail()?.weaknesses ?? ''),
          ],
        ),
      ),
    );
  }

  int result() {
    int total = 0;
    for (var q in test.questions) {
      total += q.selectedOptionIndex!;
    }
    return total;
  }
  LevelDetail? levelDetail(){
    for (var r in test.conclude.levels.keys) {
      List<String> range = r.split("-");
      int minScore = int.parse(range[0]);
      int maxScore = int.parse(range[1]);
      if(result() >= minScore && result() <= maxScore){
        return test.conclude.levels[r];
      }
    }
    return null;
  }
}
