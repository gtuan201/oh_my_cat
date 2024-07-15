import 'package:flutter/material.dart';
import 'package:mood_press/data/model/self_care.dart';

import '../pdf_self_care_screen.dart';

class ItemSelfCare extends StatelessWidget {
  final SelfCare selfCare;
  const ItemSelfCare({super.key, required this.selfCare});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => PdfSelfCareScreen(pdfUrl: selfCare.pdfUrl),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = 0.0;
              var end = 1.0;
              var curve = Curves.ease;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var scaleAnimation = animation.drive(tween);
              var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
              return ScaleTransition(
                scale: scaleAnimation,
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: child,
                ),
              );
            },
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: selfCare.image.image(fit: BoxFit.cover,),
      ),
    );
  }
}
