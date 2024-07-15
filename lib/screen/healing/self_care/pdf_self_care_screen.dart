import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../ulti/function.dart';

class PdfSelfCareScreen extends StatelessWidget {
  final String pdfUrl;
  const PdfSelfCareScreen({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            FutureBuilder<File>(
              future: getFilePathFromUrl(pdfUrl),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return SfPdfViewer.file(
                    snapshot.data!,
                    initialPageNumber: 2,
                    pageLayoutMode: PdfPageLayoutMode.single,
                    scrollDirection: PdfScrollDirection.vertical,
                    canShowPageLoadingIndicator: true,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(color: ColorName.darkBlue,),);
                }
              },
            ),
            Positioned(
              top: 6,
              left: 6,
              child: InkWell(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.4)
                  ),
                  child: const Icon(Icons.close,color: Colors.white,),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
