import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/screen/healing/test/test_detail_screen.dart';
import '../../../data/model/test.dart';
import '../../../generated/l10n.dart';

class TestDescriptionScreen extends StatelessWidget {
  final Test test;
  const TestDescriptionScreen({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(test.imageUrl ?? '')
            ),
            const SizedBox(height: 20,),
            Text(test.title,style: TextStyle(color: Colors.blueGrey.shade100,fontWeight: FontWeight.w600,fontSize: 17),),
            const SizedBox(height: 12,),
            Text(test.description,style: TextStyle(color: Colors.blueGrey.shade200,fontSize: 16),textAlign: TextAlign.center,),
            const Spacer(),
            ElevatedButton(
                onPressed: (){
                  Get.to(() => TestDetailScreen(test: test,));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  fixedSize: Size(Get.width - 64, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  )
                ),
                child: Text(S.of(context).start_quiz)
            ),
            const SizedBox(height: 12,),
          ],
        ),
      ),
    );
  }
}
