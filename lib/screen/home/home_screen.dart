import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mood_press/gen/assets.gen.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_press/helper/database_helper.dart';
import 'package:mood_press/providers/emoji_provider.dart';
import 'package:mood_press/providers/home_provider.dart';
import 'package:mood_press/screen/home/widget/calendar_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int year = DateTime.now().year;
  var month = DateTime.now().month.obs;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: month.value - 1);
    super.initState();
    context.read<HomeProvider>().getMoods();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.image.imageBackground.image(
          width: Get.width,
          height: Get.height,
          fit: BoxFit.cover
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {

                        },
                        icon: FaIcon(FontAwesomeIcons.rectangleAd,color: Colors.grey.shade300,)
                    ),
                    Obx(() => Text('Tháng ${month.value} năm $year',
                      style: Theme.of(context).textTheme.bodyLarge,)
                    ),
                    IconButton(
                        onPressed: () {
                          context.read<EmojiProvider>().toggleEmojiList();
                        },
                        icon: FaIcon(FontAwesomeIcons.list,color: Colors.grey.shade300,)
                    ),
                    IconButton(
                        onPressed: () {

                        },
                        icon: FaIcon(FontAwesomeIcons.brush,color: Colors.grey.shade300,)
                    ),
                  ],
                ),
                const SizedBox(height: 24,),
                _buildDaysOfWeek(),
                Expanded(
                  child: PageView.builder(
                    itemCount: 12,
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    onPageChanged: (i){
                      month.value = i + 1;
                    },
                    itemBuilder: (context,index) =>
                        CalendarPage(month: index + 1,)
                  ),
                )
              ],
            ),
          )
        ),
      ],
    );
  }

  Widget _buildDaysOfWeek() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        return Expanded(
          child: Center(
            child: Text(
              DateFormat.E('vi_VN').format(DateTime(2021, 1, index + 4)),
              style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
        );
      }),
    );
  }
}
