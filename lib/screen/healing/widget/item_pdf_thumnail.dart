import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class PdfThumbnail extends StatelessWidget {
  final String pdfUrl;

  const PdfThumbnail({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: AbsorbPointer(
        child: FutureBuilder<File>(
          future: _getFilePathFromUrl(pdfUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 110,
                  height: 160,
                  child: SfPdfViewer.file(
                    snapshot.data!,
                    pageSpacing: 0,
                    pageLayoutMode: PdfPageLayoutMode.single,
                    scrollDirection: PdfScrollDirection.vertical,
                    enableDoubleTapZooming: false,
                    canShowPaginationDialog: false,
                    canShowScrollHead: false,
                    canShowScrollStatus: false,
                    canShowPageLoadingIndicator: false,
                  ),
                ),
              );
            } else {
              return Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 110,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8), // Tùy chọn: bo góc
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<File> _getFilePathFromUrl(String url) async {
    final FileInfo fileInfo = await DefaultCacheManager().downloadFile(url);
    return fileInfo.file;
  }
}