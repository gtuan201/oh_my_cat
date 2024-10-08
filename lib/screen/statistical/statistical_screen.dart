import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mood_press/providers/emoji_provider.dart';
import 'package:mood_press/providers/statisticaL_provider.dart';
import 'package:mood_press/screen/statistical/widget/item_mood_percent.dart';
import 'package:mood_press/screen/statistical/widget/item_test_result.dart';
import 'package:mood_press/screen/statistical/widget/mood_pie_chart_widget.dart';
import 'package:mood_press/ulti/constant.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../data/model/test.dart';
import '../../generated/l10n.dart';
import '../../ulti/function.dart';
import '../home/widget/add_emotion_widget.dart';

class StatisticalScreen extends StatefulWidget {
  const StatisticalScreen({super.key});

  @override
  State<StatisticalScreen> createState() => _StatisticalScreenState();
}

class _StatisticalScreenState extends State<StatisticalScreen> {


  RxBool toggleChart = true.obs;
  RxInt itemLength = 5.obs;

  @override
  void initState() {
    super.initState();
    context.read<StatisticalProvider>().percentOfMood();
    context.read<StatisticalProvider>().getListTest().then((_){
      context.read<StatisticalProvider>().getListTestResult();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(S.of(context).statistics),
            centerTitle: true,
            pinned: true,
            floating: true,
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Theme.of(context).cardTheme.shadowColor!,
                      width: 3
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).test_results,style: const TextStyle(color: Colors.white70,fontWeight: FontWeight.w700,fontSize: 16),),
                  const SizedBox(height: 4,),
                  Text(S.of(context).test_scores_note,style: const TextStyle(color: Colors.white70),),
                  const SizedBox(height: 10,),
                  ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        Test test = context.watch<StatisticalProvider>().listTest[index];
                        return ItemTestResult(test: test, index: index);
                      },
                      separatorBuilder: (context,index) => const SizedBox(height: 10,),
                      itemCount: context.watch<StatisticalProvider>().listTest.length
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Theme.of(context).cardTheme.shadowColor!,
                      width: 3
                  )
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).mood_statistics,style: const TextStyle(color: Colors.white70,fontWeight: FontWeight.w700,fontSize: 16),),
                          const SizedBox(height: 4,),
                          Text(S.of(context).daily_data_note,style: const TextStyle(color: Colors.white70,),),
                        ],
                      ),
                      Selector<StatisticalProvider,bool>(
                        builder: (context,enable,_) => Visibility(
                          visible: enable,
                          child: ToggleSwitch(
                            minWidth: 40.0,
                            minHeight: 30.0,
                            initialLabelIndex: toggleChart.value ? 0 : 1,
                            cornerRadius: 10,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Theme.of(context).cardColor,
                            inactiveFgColor: Colors.white,
                            totalSwitches: 2,
                            icons: const [
                              FontAwesomeIcons.chartPie,
                              FontAwesomeIcons.solidChartBar,
                            ],
                            borderWidth: 4.0,
                            borderColor: [Theme.of(context).cardColor],
                            activeBgColors: [[Theme.of(context).splashColor], [Theme.of(context).splashColor]],
                            onToggle: (index) {
                              if(index == 1){
                                itemLength.value = 5;
                              }
                              toggleChart.value = index == 0;
                            },
                          ),
                        ),
                        selector: (context,provider) => provider.enableChart
                      ),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Obx(() => toggleChart.value ? const MoodPieChartWidget()
                      : Column(
                        children: [
                          Selector<StatisticalProvider,List<double>>(
                              builder: (context,listPercent,_){
                                return ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context,index){
                                      return Consumer<EmojiProvider>(
                                        builder: (context,emojiProvider,_){
                                          return ItemMoodPercent(
                                            imageGen: emojiProvider.currentEmojiList[index],
                                            percent: listPercent[index],
                                            color: Constant.moodColor[index],
                                            mood: Constant.emojiNames[Get.locale!.languageCode]![index],
                                          );
                                        }
                                      );
                                    },
                                    separatorBuilder: (context,index) => const SizedBox(height: 8,),
                                    itemCount: itemLength.value
                                );
                              },
                              selector: (context,provider) => provider.moodPercents
                          ),
                          const Divider(thickness: 2,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${itemLength.value} ${S.of(context).out_of_total}",style: const TextStyle(color: Colors.white70,),),
                              InkWell(
                                onTap: (){
                                  if(itemLength.value == 5){
                                    itemLength.value = Constant.listEmoji.length;
                                  }
                                  else{
                                    itemLength.value = 5;
                                  }
                                },
                                child: Text(itemLength.value == 5 ? S.of(context).show_all : S.of(context).collapse,
                                    style: const TextStyle(color: Colors.white70,)
                                )
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                  Selector<StatisticalProvider,bool>(
                    builder: (context,enable,_) => Visibility(
                      visible: !enable,
                      child: Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: ElevatedButton(
                            onPressed: (){
                              navigationToMood();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                              )
                            ),
                            child: Text(S.of(context).add_mood_log),
                        ),
                      ),
                    ),
                    selector: (context,provider) => provider.enableChart
                  )
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
        ],
      ),
    );
  }
  void navigationToMood() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>  AddEmotionWidget(date: DateTime.now(),),
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
        if (result[Constant.showToast] == true) {
          context.read<StatisticalProvider>().percentOfMood();
          showCustomToast(context: context, message: result[Constant.message]);
        }
      }
    });
  }
}