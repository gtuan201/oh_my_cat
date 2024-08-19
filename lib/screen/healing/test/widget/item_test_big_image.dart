import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/model/test.dart';
import '../test_description_screen.dart';

class ItemTestBigImage extends StatelessWidget {
  final Test test;
  const ItemTestBigImage({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    final BorderSide borderSide = BorderSide(
        color: Theme.of(context).cardTheme.shadowColor!,
        width: 3
    );
    return InkWell(
      onTap: (){
        Get.to(() => TestDescriptionScreen(test: test,));
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
              child: Image.asset(
                test.imageUrl ?? '',
                height: 180,
                fit: BoxFit.fitWidth,
                width: double.infinity,
                alignment: Alignment.topCenter,
              )
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical:20),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
                  border: Border(
                    left: borderSide,
                    right: borderSide,
                    bottom: borderSide
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(test.title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),),
                  const SizedBox(height: 12,),
                  Text(test.description.substring(0,test.description.indexOf(".") + 1),style: const TextStyle(color: Colors.white70,fontWeight: FontWeight.w600,fontSize: 16),),
                ],
              ))
          ],
        ),
      ),
    );
  }
}
