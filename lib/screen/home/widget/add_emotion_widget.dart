import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mood_press/gen/assets.gen.dart';
import 'package:mood_press/providers/emoji_provider.dart';
import 'package:mood_press/screen/home/widget/ai_suggestion_screen.dart';
import 'package:mood_press/screen/home/widget/custom_tooltip.dart';
import 'package:mood_press/screen/home/widget/input_info_mood_widget.dart';
import 'package:mood_press/screen/setting/emoji/emoji_screen.dart';
import 'package:mood_press/ulti/constant.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../../helper/date_time_helper.dart';
import '../../../ulti/function.dart';

class AddEmotionWidget extends StatefulWidget {
  final DateTime? date;

  const AddEmotionWidget({super.key, required this.date});
  @override
  CircleListAnimationState createState() => CircleListAnimationState();
}

class CircleListAnimationState extends State<AddEmotionWidget> {
  final int itemCount = 11;
  final double radius = 166;
  var selectedDate = DateTime.now().obs;
  final isShowTooltip = false.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.date != null){
        selectedDate.value = widget.date!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
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
            margin: const EdgeInsets.only(right: 8),
            child: InkWell(
                onTap: (){
                  Get.to(() => const AIMoodSuggestionScreen());
                },
                child: Assets.image.computerCat.svg(width: 32),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 6),
            child: IconButton(
              onPressed: (){
                Get.to(() => const EmojiScreen());
              },
              icon: FaIcon(FontAwesomeIcons.sliders,color: Colors.grey.shade400)
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Get.height*0.08,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: Obx(() => Text(DateTimeHelper.checkIsToday(selectedDate.value)
                  ? S.of(context).feeling_today
                  : S.of(context).feel_that_day ,
                style: TextStyle(color: Colors.grey.shade400,fontSize: 24,fontWeight: FontWeight.w800,),textAlign: TextAlign.center,
              ),)
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.calendarWeek,color: Colors.grey.shade400,size: 18,),
                const SizedBox(width: 8,),
                InkWell(
                  onTap: (){
                    selectDate(context,initialDate: selectedDate.value, (date) async {
                      selectedDate.value = date;
                    });
                  },
                  child: Obx(() => Text(DateTimeHelper.formatDate(selectedDate.value,Get.locale!.languageCode),
                    style: TextStyle(color: Colors.grey.shade400,fontSize: 20,fontWeight: FontWeight.w400,decoration: TextDecoration.underline),
                  ),),
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
                              date: selectedDate.value,
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

  const CircleItem({super.key, required this.index, required this.totalItems, required this.radius, required this.isShowTooltip, required this.date});

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
            isShowTooltip ? CustomTooltipShape(message: Constant.emojiNames[Get.locale!.languageCode]![index]) : const SizedBox(height: 36,),
            Consumer<EmojiProvider>(builder: (context,emojiProvider,child){
              return emojiProvider.currentEmojiList[index].svg(height: 62,width: 62);
            })
          ],
        ),
      ),
    );
  }
}


class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay;

  const DelayedAnimation({super.key, required this.child, required this.delay});

  @override
  DelayedAnimationState createState() => DelayedAnimationState();
}

class DelayedAnimationState extends State<DelayedAnimation> with SingleTickerProviderStateMixin {
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
