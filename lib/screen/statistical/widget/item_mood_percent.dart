import 'package:flutter/material.dart';
import 'package:mood_press/gen/assets.gen.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ItemMoodPercent extends StatelessWidget {
  final SvgGenImage imageGen;
  final double percent;
  final Color color;
  final String mood;
  const ItemMoodPercent({super.key, required this.imageGen, required this.percent, required this.color, required this.mood});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        imageGen.svg(width: 40,height: 40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearPercentIndicator(
                animation: true,
                lineHeight: 12.0,
                animationDuration: 1000,
                percent: percent/100,
                trailing: Text("${percent.round()} %",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500)),
                barRadius: const Radius.circular(12),
                progressColor: color,
                backgroundColor: Theme.of(context).cardColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(mood,style: TextStyle(color: Colors.blueGrey.shade100,fontSize: 13,fontWeight: FontWeight.w500),),
              )
            ],
          ),
        ),
      ],
    );
  }
}
