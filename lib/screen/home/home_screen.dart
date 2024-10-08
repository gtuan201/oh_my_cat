import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_press/helper/date_time_helper.dart';
import 'package:mood_press/providers/home_provider.dart';
import 'package:mood_press/providers/theme_provider.dart';
import 'package:mood_press/screen/home/widget/calendar_widget.dart';
import 'package:mood_press/screen/setting/theme/theme_screen.dart';
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
  late Locale locale;

  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().getMoods();
    _pageController = PageController(initialPage: month.value - 1);
  }

  @override
  Widget build(BuildContext context) {
    locale = Get.locale!;
    return Stack(
      children: [
        Consumer<ThemeProvider>(
          builder: (context,themeProvider,_){
            return themeProvider.imageBackground != null
                ? themeProvider.imageBackground!.image(
                  width: Get.width,height: Get.height,fit: BoxFit.cover
                )
                : const SizedBox();
          }
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
                    Obx(() => Text(DateTimeHelper.getLocalizedDate(DateTime(year,month.value),locale.languageCode),
                      style: Theme.of(context).appBarTheme.titleTextStyle,)
                    ),
                    IconButton(
                        onPressed: () {

                        },
                        icon: FaIcon(FontAwesomeIcons.list,color: Colors.grey.shade300,)
                    ),
                    IconButton(
                        onPressed: () {
                          Get.to(() => const ThemeScreen());
                        },
                        icon: FaIcon(FontAwesomeIcons.brush,color: Colors.grey.shade300,)
                    ),
                  ],
                ),
                const SizedBox(height: 24,),
                _buildDaysOfWeek(),
                Expanded(
                  child: PageView.builder(
                    itemCount: DateTime.now().month,
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
              DateFormat.E(locale.languageCode).format(DateTime(2021, 1, index + 4)),
              style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.bodySmall?.color),
            ),
          ),
        );
      }),
    );
  }
}
