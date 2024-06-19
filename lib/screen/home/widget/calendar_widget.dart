import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:mood_press/helper/date_time_helper.dart';
import 'package:mood_press/screen/home/widget/add_emotion_widget.dart';

import '../../../gen/assets.gen.dart';

class CalendarPage extends StatefulWidget {
  final int month;
  const CalendarPage({super.key, required this.month});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  DateTime currentDate = DateTime.now();
  List<DateTime?> daysInMonth = [];

  @override
  void initState() {
    super.initState();
    _generateDaysInMonth();
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
      backgroundColor: ColorName.colorPrimary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.7
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: daysInMonth.length,
          itemBuilder: (context, index) {
            return _buildDayItem(daysInMonth[index]);
          },
        ),
      ),
    );
  }

  Widget _buildDayItem(DateTime? day) {
    if (day == null) {
      return Container();
    }
    bool isToday = DateTimeHelper.checkIsToday(day);

    bool afterNow = day.isAfter(DateTime.now());

    return Column(
      children: [
        InkWell(
          onTap: afterNow ? null : (){
            Get.bottomSheet(AddEmotionWidget(date: day,),isScrollControlled: true,ignoreSafeArea: false);
          },
          child: !isToday ? Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isToday ? Colors.lightBlue : Colors.blueGrey.shade400,
            ),
            padding: EdgeInsets.all(afterNow ? 1 : 4),
            child: Icon(Icons.circle,color: isToday ? Colors.lightBlue.shade100 : afterNow ? ColorName.colorPrimary : Colors.blueGrey.shade500,size: afterNow ? 50 : 40,),
          ) : Assets.image.happy.svg(width: 52,height: 52),
        ),
        const SizedBox(height: 4,),
        Text('${day.day}',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)
      ],
    );
  }
}