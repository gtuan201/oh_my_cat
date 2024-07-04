import 'package:flutter/material.dart';
import 'package:mood_press/data/model/test.dart';

class ItemTest extends StatelessWidget {
  final Test test;
  const ItemTest({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: Colors.blueGrey.withBlue(140),
                width: 3
            )
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(test.imageUrl ?? '',height: 80,width: 80,fit: BoxFit.cover,),
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(test.title,style: TextStyle(color: Colors.blueGrey.shade100,fontWeight: FontWeight.w800,fontSize: 16),),
                  const SizedBox(height: 2,),
                  Text(test.source,style: TextStyle(color: Colors.grey.shade400),maxLines: 2,overflow: TextOverflow.ellipsis,),
                ],
              ),
            )
          ],
        )
    );
  }
}
