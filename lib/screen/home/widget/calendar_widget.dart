import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/helper/date_time_helper.dart';
import 'package:mood_press/providers/emoji_provider.dart';
import 'package:mood_press/providers/home_provider.dart';
import 'package:mood_press/screen/home/widget/add_emotion_widget.dart';
import 'package:mood_press/screen/home/widget/input_info_mood_widget.dart';
import 'package:mood_press/ulti/constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import '../../../data/model/mood.dart';
import '../../../ulti/function.dart';
import 'package:el_tooltip/el_tooltip.dart';
import 'package:home_widget/home_widget.dart';

class CalendarPage extends StatefulWidget {
  final int month;
  const CalendarPage({super.key, required this.month});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  DateTime currentDate = DateTime.now();
  List<DateTime?> daysInMonth = [];
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    _generateDaysInMonth();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(3.seconds, (){
        screenshotController.capture().then((capturedImage) async {
          final directory = (await getApplicationDocumentsDirectory()).path;
          String fileName = '$directory/${DateTime.now().toIso8601String()}.png';
          File imgFile = File(fileName);
          if(capturedImage != null){
            imgFile.writeAsBytes(capturedImage).then((file) async {
              await _updateHomeWidget(file.path);
            });
          }
        });
      });
    });
  }

  Future<void> _updateHomeWidget(String filePath) async {
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    try {
      await HomeWidget.saveWidgetData<String>('imagePath', filePath).then((value) async {
        await HomeWidget.saveWidgetData<String>('widgetColor', colorToHexNoAlpha(Theme.of(context).primaryColor));
      });
      await HomeWidget.saveWidgetData<String>('dateTime', 'Tháng $month năm $year');

      await HomeWidget.updateWidget(
        name: Constant.androidWidget,
        androidName: Constant.androidWidget,
      );
    } catch (e) {
      log('Error updating widget: $e');
    }
  }


  void _generateDaysInMonth() {
    daysInMonth.clear();
    DateTime firstDayOfMonth = DateTime(currentDate.year, widget.month, 1);
    DateTime lastDayOfMonth = DateTime(currentDate.year, widget.month + 1, 0);
    for (int i = 0; i < firstDayOfMonth.weekday - 1; i++) {
      daysInMonth.add(null);
    }
    for (int i = 0; i < lastDayOfMonth.day; i++) {
      daysInMonth.add(DateTime(currentDate.year, widget.month, i + 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Screenshot(
          controller: screenshotController,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 0.7
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: daysInMonth.length,
            itemBuilder: (context, index) {
              return _buildDayItem(daysInMonth[index],context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDayItem(DateTime? day,BuildContext context) {
    if (day == null) {
      return Container();
    }
    bool isToday = DateTimeHelper.checkIsToday(day);

    bool afterNow = day.isAfter(DateTime.now());

    return Selector<HomeProvider,List<Mood>>(
        builder: (_,listMood,child){
          Mood? mood = moodOfDay(day, listMood);
          ElTooltipController tooltipController = ElTooltipController();
          final listMoodOfDay = listMood.where((mood) => DateTimeHelper.areDatesEqual(mood.date,day)).toList();
          return Column(
            children: [
              InkWell(
                onTap: afterNow ? null : (){
                  if(listMoodOfDay.isNotEmpty && listMoodOfDay.length > 1){
                    tooltipController.show();
                  }
                  else{
                    navigationToMood(day, mood);
                  }
                },
                child: listMoodOfDay.length == 1
                  ? Consumer<EmojiProvider>(builder: (context,emojiProvider,_){
                      return emojiProvider.currentEmojiList[mood!.mood].svg(width: 52,height: 52);
                    })
                  : listMoodOfDay.length > 1 ? ElTooltip(
                      controller: tooltipController,
                      position: ElTooltipPosition.bottomCenter,
                      appearAnimationDuration: 300.milliseconds,
                      disappearAnimationDuration: 300.milliseconds,
                      content: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...listMoodOfDay.map((m) =>
                              InkWell(
                                onTap: () async {
                                  navigationToMood(day, m);
                                  await tooltipController.hide();
                                },
                                child: Consumer<EmojiProvider>(builder: (context,emojiProvider,_){
                                  return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      child: emojiProvider.currentEmojiList[m.mood].svg(width: 40,height: 40));
                                })
                              )),
                        ],
                      ),
                      child: SizedBox(
                        width: 52,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 52,
                            autoPlay: true,
                            viewportFraction: 1,
                            animateToClosest: true,
                            enableInfiniteScroll: true,
                          ),
                          items: listMoodOfDay.map((m) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Consumer<EmojiProvider>(builder: (context,emojiProvider,_){
                                  return emojiProvider.currentEmojiList[m.mood].svg(width: 52,height: 52);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  : Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isToday ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                    ),
                    padding: EdgeInsets.all(afterNow ? 1 : 4),
                            child: Icon(
                              Icons.circle,
                              color: isToday
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : afterNow
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                              size: afterNow ? 50 : 40,
                            ),
                          ),
              ),
              const SizedBox(height: 4,),
              Text('${day.day}',
                style: TextStyle(color: listMoodOfDay.isNotEmpty && listMoodOfDay.every((mood) => mood.isSpecial == 1)
                    ? Colors.yellow : Theme.of(context).textTheme.bodySmall?.color,fontWeight: FontWeight.w600,
                shadows: listMoodOfDay.firstWhereOrNull((m) => m.isSpecial == 1) != null ? [
                  for (int i = 1; i < 8; i++)
                    Shadow(
                      color: Colors.orange.withOpacity(0.5),
                      blurRadius: (5 * i).toDouble(),
                    ),
                ] : [] ,),)
            ],
          );
        },
        selector: (_,provider) => provider.listMood
    );
  }
  Mood? moodOfDay(DateTime day,List<Mood> listMood){
    return listMood.firstWhereOrNull((mood) => DateTimeHelper.areDatesEqual(day, mood.date));
  }
  void navigationToMood(DateTime day,Mood? mood) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => mood != null
            ? InputInfoMoodWidget(moodIndex: mood.mood, date: mood.date,mood: mood,)
            : AddEmotionWidget(date: day,),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ).then((result){
      if (result != null && result is Map<String, dynamic>) {
        if (result['showToast'] == true) {
          showCustomToast(context: context, message: result['message'],marginBottom: 62);
        }
      }
    });
  }
}