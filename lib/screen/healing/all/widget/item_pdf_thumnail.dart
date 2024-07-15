import 'package:flutter/material.dart';
import 'package:mood_press/data/model/self_care.dart';
import 'package:mood_press/screen/healing/pdf_self_care_screen.dart';


class PdfThumbnail extends StatelessWidget {
  final SelfCare selfCare;

  const PdfThumbnail({super.key, required this.selfCare});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: SizedBox(
        width: 110,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: selfCare.image.image(),
            ),
            const SizedBox(height: 6,),
            Text(selfCare.title,
              style: TextStyle(color: Colors.blueGrey.shade100,fontSize: 11,fontWeight: FontWeight.w600),maxLines: 1, overflow: TextOverflow.ellipsis,)
          ],
        ),
      ),
    );
  }
}