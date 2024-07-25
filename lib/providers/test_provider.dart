import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/data/model/test.dart';
import 'package:mood_press/helper/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:open_file/open_file.dart';
import '../helper/date_time_helper.dart';

class TestProvider extends ChangeNotifier{

  bool endTest = false;

  void changeStatusTest(Test test) {
    endTest = test.questions.every((e) => e.selectedOptionIndex != null);
    notifyListeners();
  }

  Future<void> addTestResult(Test test) async {
    await Get.find<DatabaseHelper>().insertTest(test);
  }

  Future<void> generatePdf(LevelDetail levelDetail, Test test) async {
    final font = await PdfGoogleFonts.openSansRegular();
    final fontBold = await PdfGoogleFonts.openSansBold();
    final doc = pw.Document(pageMode: PdfPageMode.fullscreen,);
    doc.addPage(
        pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Text("Ngày ${DateTimeHelper.dateTimeToString(DateTime.now())}", style: pw.TextStyle(fontSize: 8, font: font)),
                  ),
                  pw.Divider(color: PdfColors.grey, thickness: 1,),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("Về ${test.title}", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, font: fontBold)),
                            pw.SizedBox(height: 8,),
                            pw.Text(test.description, style: pw.TextStyle(fontSize: 10, font: font))
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 16,),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("Kết luận", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, font: fontBold)),
                            pw.SizedBox(height: 8,),
                            pw.Text(levelDetail.conclusion, style: pw.TextStyle(fontSize: 10, font: font))
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10,),
                  pw.Text("Đánh giá được thực hiện vào ngày ${DateTimeHelper.dateTimeToString(DateTime.now())}", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, font: fontBold)),
                  pw.SizedBox(height: 10,),
                  pw.Text(test.title, style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: fontBold)),
                  pw.SizedBox(height: 10,),
                  pw.Table(
                    columnWidths: {
                      0: const pw.FlexColumnWidth(1),
                      1: const pw.FlexColumnWidth(1),
                    },
                    children: List.generate(
                      ((test.questions.length > 14 ? 14 : test.questions.length) / 2).ceil(),
                          (rowIndex) => pw.TableRow(
                        children: List.generate(2, (colIndex) {
                            final index = rowIndex * 2 + colIndex;
                            if (index < (test.questions.length > 14 ? 14 : test.questions.length)) {
                              return pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                                child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      "${index + 1}. ${test.questions[index].text}",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                        font: font,
                                      ),
                                    ),
                                    pw.SizedBox(height: 4),
                                    pw.Text(
                                      test.questions[index].options[test.questions[index].selectedOptionIndex!],
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                        font: fontBold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return pw.Container();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  if(test.questions.length <= 14)
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Lời khuyên", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: fontBold)),
                      pw.SizedBox(height: 8,),
                      pw.Text(levelDetail.recommendations, style: pw.TextStyle(fontSize: 10, font: font)),
                    ]
                  ),
                  pw.Spacer(),
                  pw.Divider(color: PdfColors.grey, thickness: 1,),
                  pw.Text("Oh My Cat", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, font: fontBold)),
                  pw.SizedBox(height: 4,),
                  pw.Text(test.source.substring(0,test.source.indexOf(".")), style: pw.TextStyle(fontSize: 10, color: PdfColors.grey, font: font))
                ],
              );
            }
        )
    );
    if(test.questions.length > 14){
      doc.addPage(
        pw.Page(
          build: (pw.Context context){
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text("Ngày ${DateTimeHelper.dateTimeToString(DateTime.now())}", style: pw.TextStyle(fontSize: 8, font: font)),
                ),
                pw.Divider(color: PdfColors.grey, thickness: 1,),
                pw.Table(
                  columnWidths: {
                    0: const pw.FlexColumnWidth(1),
                    1: const pw.FlexColumnWidth(1),
                  },
                  children: List.generate(
                    ((test.questions.length - 14) / 2).ceil(),
                        (rowIndex) => pw.TableRow(
                      children: List.generate(2, (colIndex) {
                        final index = rowIndex * 2 + colIndex;
                        if (index < (test.questions.length - 14)) {
                          return pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "${14 + index + 1}. ${test.questions[14 + index].text}",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: font,
                                  ),
                                ),
                                pw.SizedBox(height: 4),
                                pw.Text(
                                  test.questions[ 14 + index].options[test.questions[14 + index].selectedOptionIndex!],
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                    font: fontBold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return pw.Container();
                        }
                      },
                      ),
                    ),
                  ),
                ),
                if(levelDetail.strengths != null)
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Điểm mạnh", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: fontBold)),
                      pw.SizedBox(height: 8,),
                      pw.Text(levelDetail.strengths ?? '', style: pw.TextStyle(fontSize: 10, font: font)),
                    ]
                  ),
                if(levelDetail.weaknesses != null)
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Điểm yếu", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: fontBold)),
                        pw.SizedBox(height: 8,),
                        pw.Text(levelDetail.weaknesses ?? '', style: pw.TextStyle(fontSize: 10, font: font)),
                      ]
                  ),
                pw.Text("Lời khuyên", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: fontBold)),
                pw.SizedBox(height: 8,),
                pw.Text(levelDetail.recommendations, style: pw.TextStyle(fontSize: 10, font: font)),
                pw.Spacer(),
                pw.Divider(color: PdfColors.grey, thickness: 1,),
                pw.Text("Oh My Cat", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, font: fontBold)),
                pw.SizedBox(height: 4,),
                pw.Text(test.source.substring(0,test.source.indexOf(".")), style: pw.TextStyle(fontSize: 10, color: PdfColors.grey, font: font))
              ]
            );
          }
        )
      );
    }
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File('${dir.path}/ohmycat_${DateTimeHelper.dateTimeToStringWithMinute(DateTime.now())}.pdf');
    await file.writeAsBytes(await doc.save());
    await Share.shareXFiles([XFile(file.path)]).then((result){
      if(result.status == ShareResultStatus.success){
        OpenFile.open(file.path);
      }
    });
  }
}