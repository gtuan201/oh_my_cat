import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:mood_press/screen/statistical/statistical_test_screen.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:provider/provider.dart';
import '../../../data/model/test.dart';
import '../../../providers/statisticaL_provider.dart';

class ItemTestResult extends StatelessWidget {
  final Test test;
  final int index;
  const ItemTestResult({super.key, required this.test, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        final List<Test> listTestResult = context
            .read<StatisticalProvider>()
            .listTestResult
            .where((testResult) => testResult.id == test.id)
            .toList();
        if(listTestResult.isNotEmpty){
          Get.to(() => StatisticalTestScreen(listTestResult: listTestResult));
        }
        else{
          showCustomToast(context: context, message: "Bạn chưa làm bài kiểm tra này lần nào!");
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: ColorName.darkBlue,
            borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(test.title,style: const TextStyle(
                      color: Colors.white,fontWeight: FontWeight.w600
                  ),maxLines: 1,overflow: TextOverflow.ellipsis,),
                ),
                const SizedBox(width: 10,),
                const Icon(Icons.arrow_forward_ios,size: 12,color: Colors.white,)
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                Expanded(child: Text('Kết quả gần nhất',style: TextStyle(color: Colors.blueGrey.shade100),)),
                Selector<StatisticalProvider,List<String>>(
                    builder: (context,listDateComplete,_){
                      return Text(listDateComplete[index],style: TextStyle(color: Colors.blueGrey.shade100));
                    },
                    selector: (context,provider) => provider.dateComplete
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
