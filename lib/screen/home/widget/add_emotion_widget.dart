import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:mood_press/screen/home/widget/custom_tooltip.dart';
import 'package:mood_press/screen/home/widget/input_info_mood_widget.dart';
import 'package:mood_press/ulti/constant.dart';

import '../../../helper/date_time_helper.dart';

class AddEmotionWidget extends StatefulWidget {
  final DateTime date;

  const AddEmotionWidget({super.key, required this.date});
  @override
  _CircleListAnimationState createState() => _CircleListAnimationState();
}

class _CircleListAnimationState extends State<AddEmotionWidget> {
  final int itemCount = 11;
  final double radius = 166;
  final isShowTooltip = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.colorPrimary,
      appBar: AppBar(
        backgroundColor: ColorName.colorPrimary,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 40,
        leading: Container(
          margin: const EdgeInsets.only(right: 6),
          child: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: FaIcon(FontAwesomeIcons.arrowLeft,color: Colors.grey.shade400,)
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 6),
            child: IconButton(
              onPressed: (){

              },
              icon: FaIcon(FontAwesomeIcons.sliders,color: Colors.grey.shade400)
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Get.height*0.05,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: Text(DateTimeHelper.checkIsToday(widget.date) ? 'Yo! Hôm nay bạn cảm thấy thế nào?' : 'Bạn cảm thấy thế nào vào ngày hôm đó?',
                style: TextStyle(color: Colors.grey.shade400,fontSize: 24,fontWeight: FontWeight.w800,),textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.calendarWeek,color: Colors.grey.shade400,size: 18,),
                const SizedBox(width: 8,),
                InkWell(
                  onTap: (){

                  },
                  child: Text("Ngày ${DateTimeHelper.dateTimeToString(widget.date)}",
                    style: TextStyle(color: Colors.grey.shade400,fontSize: 20,fontWeight: FontWeight.w400,decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 460,
              child: Obx(() => GestureDetector(
                onLongPress: (){
                  isShowTooltip.value = true;
                  Timer(3.seconds, (){
                    isShowTooltip.value = false;
                  });
                },
                child: Center(
                  child: SizedBox(
                    width: Get.width,
                    child: Stack(
                      alignment: Alignment.center,
                      children: List.generate(itemCount, (index) {
                        return DelayedAnimation(
                          delay: index * 50,
                          child: CircleItem(
                              index: index,
                              totalItems: itemCount,
                              radius: radius,
                              isShowTooltip: isShowTooltip.value,
                              date: widget.date,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),),
            ),
          ],
        ),
      )
    );
  }
}

class CircleItem extends StatelessWidget {
  final int index;
  final int totalItems;
  final double radius;
  final bool isShowTooltip;
  final DateTime date;

  CircleItem({required this.index, required this.totalItems, required this.radius, required this.isShowTooltip, required this.date});

  @override
  Widget build(BuildContext context) {
    final double angle = (2 * pi / totalItems) * index;
    final double x = radius * cos(angle);
    final double y = radius * sin(angle);
    return Transform.translate(
      offset: Offset(x, y),
      child: GestureDetector(
        onTap: () {
          Get.to(() => InputInfoMoodWidget(moodIndex: index,date: date,),
              transition: Transition.downToUp,duration: 350.milliseconds,
              curve: Curves.easeInOut);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isShowTooltip ? CustomTooltipShape(message: Constant.listEmojiNames[index]) : const SizedBox(height: 36,),
            Constant.listEmoji[index].svg(width: 62,height: 62),
          ],
        ),
      ),
    );
  }
}


class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay;

  DelayedAnimation({required this.child, required this.delay});

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
