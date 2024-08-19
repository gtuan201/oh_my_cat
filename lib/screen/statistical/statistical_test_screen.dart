import 'package:flutter/material.dart';
import 'package:mood_press/helper/date_time_helper.dart';
import 'package:mood_press/screen/statistical/widget/item_result.dart';
import '../../data/model/test.dart';
import '../../gen/colors.gen.dart';
import '../healing/test/widget/level_widget.dart';

class StatisticalTestScreen extends StatefulWidget {
  final List<Test> listTestResult;
  const StatisticalTestScreen({super.key, required this.listTestResult});

  @override
  State<StatisticalTestScreen> createState() => _StatisticalTestScreenState();
}

class _StatisticalTestScreenState extends State<StatisticalTestScreen> {

  late Test test;

  @override
  void initState() {
    super.initState();
    test = widget.listTestResult.last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.colorPrimary,
      appBar: AppBar(
        backgroundColor: ColorName.colorPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Kểt quả ngày ${DateTimeHelper.dateTimeToString(test.dateCompleted)}",
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Theme.of(context).cardTheme.shadowColor!,
                      width: 3
                  )
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Thống kê kết quả kiểm tra',style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),),
                  const SizedBox(height: 10,),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context,index){
                      return ItemResult(test: widget.listTestResult[index], result: widget.listTestResult[index].result());
                    },
                    itemCount: widget.listTestResult.length,
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
                  )
                ],
              ),
            )
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
