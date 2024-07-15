import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mood_press/screen/healing/test/infomation_test_screen.dart';
import '../../../../data/model/test.dart';
import '../../../home/widget/custom_tooltip.dart';

class LevelWidget extends StatelessWidget {
  final Test test;
  final int result;
  const LevelWidget({super.key, required this.test, required this.result});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20,bottom: 10,left: 16,right: 16),
          child: Row(
            children: test.conclude.levels.values.toList().asMap().entries.map((entry){
              int index = entry.key;
              String level = entry.value.scoringGuide;
              if (determineScoreLevel(index)) {
                return InkWell(
                  onTap: (){
                    Get.to(() => InformationTestScreen(test: test,indexResult: index,));
                  },
                  child: CustomTooltipShape(
                  color: Colors.teal.shade400,
                  child: Row(
                    children: [
                      Text(level,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                      const SizedBox(width: 10,),
                      const FaIcon(FontAwesomeIcons.solidCircleQuestion,color: Colors.white,)
                    ],
                  ),
                                ),
                );
              } else {
                return const Expanded(child: SizedBox());
              }
            }).toList(),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 16,top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: test.conclude.levels.values.toList().asMap().entries.map((entry) {
                int index = entry.key;
                String level = entry.value.scoringGuide;
                BorderRadius borderRadius = BorderRadius.zero;
                if (index == 0) {
                  borderRadius = const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  );
                } else if (index == test.conclude.levels.values.length - 1) {
                  borderRadius = const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  );
                }
                return Expanded(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: determineScoreLevel(index) ? Colors.teal.shade400 : Colors.teal.shade900,
                          borderRadius: borderRadius,
                        ),
                        margin: const EdgeInsets.only(right: 6),
                        height: 20,
                      ),
                      const SizedBox(height: 6,),
                      if(determineScoreLevel(index))
                        Text("$level (${test.conclude.levels.keys.elementAt(index)})",style: TextStyle(color: Colors.blueGrey.shade100),textAlign: TextAlign.center,)
                    ],
                  ),
                );
              }).toList(),
            )
        ),
      ],
    );
  }
  bool determineScoreLevel(int index) {
    List<String> range = test.conclude.levels.keys.elementAt(index).split("-");
    int minScore = int.parse(range[0]);
    int maxScore = int.parse(range[1]);
    return (result >= minScore && result <= maxScore);
  }
}
