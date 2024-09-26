import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/providers/test_provider.dart';
import 'package:mood_press/screen/healing/test/widget/conclude_widget.dart';
import 'package:mood_press/screen/healing/test/widget/level_widget.dart';
import 'package:provider/provider.dart';
import '../../../data/model/test.dart';
import '../../../generated/l10n.dart';

class ResultScreen extends StatelessWidget {
  final Test test;
  final Function()? onBack;

  const ResultScreen({super.key, required this.test, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: onBack ?? () {
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
            Text(
              S.of(context).your_result,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 12,),
            Text(
              "${test.result()}",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700, fontSize: 54),
              textAlign: TextAlign.center,
            ),
            LevelWidget(test: test, result: test.result()),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).conclusion,
                    style: const TextStyle(
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
                  child: Text(S.of(context).export_pdf)
                ),
              ),
            ),
            ConcludeWidget(title: S.of(context).advice, content: levelDetail()?.recommendations ?? ''),
            if(levelDetail()?.strengths != null)
              ConcludeWidget(title: S.of(context).strengths, content: levelDetail()?.strengths ?? ''),
            if(levelDetail()?.weaknesses != null)
              ConcludeWidget(title: S.of(context).weaknesses, content: levelDetail()?.weaknesses ?? ''),
          ],
        ),
      ),
    );
  }

  LevelDetail? levelDetail(){
    for (var r in test.conclude.levels.keys) {
      List<String> range = r.split("-");
      int minScore = int.parse(range[0]);
      int maxScore = int.parse(range[1]);
      if(test.result() >= minScore && test.result() <= maxScore){
        return test.conclude.levels[r];
      }
    }
    return null;
  }
}
