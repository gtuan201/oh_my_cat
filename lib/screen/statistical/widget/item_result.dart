import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/helper/date_time_helper.dart';
import 'package:mood_press/screen/healing/test/result_sceen.dart';
import '../../../data/model/test.dart';

class ItemResult extends StatelessWidget {
  final Test test;
  final int result;
  const ItemResult({super.key, required this.test, required this.result});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(() => ResultScreen(test: test,onBack: (){
          Get.back();
        },));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Text(stringScoreLevel(),style: const TextStyle(color: Colors.white),),
            const Spacer(),
            Text(DateTimeHelper.dateTimeToString(test.dateCompleted),style: const TextStyle(color: Colors.white),),
            const SizedBox(width: 4,),
            const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 16,)
          ],
        ),
      ),
    );
  }
  String stringScoreLevel() {
    String value = "";
    for (var level in test.conclude.levels.keys) {
      List<String> range = level.split("-");
      int minScore = int.parse(range[0]);
      int maxScore = int.parse(range[1]);
      if (result >= minScore && result <= maxScore){
        value = test.conclude.levels[level]?.scoringGuide ?? '';
      }
    }
    return value;
  }
}
