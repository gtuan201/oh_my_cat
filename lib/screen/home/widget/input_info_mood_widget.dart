import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mood_press/gen/assets.gen.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:mood_press/helper/date_time_helper.dart';
import 'package:mood_press/providers/home_provider.dart';
import 'package:mood_press/providers/statisticaL_provider.dart';
import 'package:mood_press/screen/home/widget/item_image.dart';
import 'package:mood_press/screen/home/widget/map_widget.dart';
import 'package:mood_press/ulti/constant.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../../data/model/mood.dart';
import '../../../providers/emoji_provider.dart';

class InputInfoMoodWidget extends StatefulWidget {
  final int moodIndex;
  final DateTime date;
  final Mood? mood;
  const InputInfoMoodWidget({super.key, required this.moodIndex, required this.date, this.mood});

  @override
  State<InputInfoMoodWidget> createState() => _InputInfoMoodWidgetState();
}

class _InputInfoMoodWidgetState extends State<InputInfoMoodWidget> {

  var timeNow = DateTime.now().obs;
  var isSpecial = false.obs;
  var alignType = Constant.ALIGN_CENTER.obs;
  var indexOfMood = 0.obs;
  TextEditingController noteController = TextEditingController();
  FocusNode noteFocusNode = FocusNode();
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    indexOfMood.value = widget.moodIndex;
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(widget.mood == null){
        noteFocusNode.requestFocus();
      }
      else{
        context.read<HomeProvider>().setUpInfoMood(widget.mood!);
        noteController.text = widget.mood?.note ?? '';
        alignType.value = widget.mood?.align ?? Constant.ALIGN_CENTER;
        if(widget.mood!.location != null && widget.mood!.location!.isNotEmpty) {
          context.read<HomeProvider>().selectLocation(widget.mood!.location!);
        }
        timeNow.value = widget.date;
        isSpecial.value = widget.mood?.isSpecial == 1 ? true : false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.colorPrimary,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorName.colorPrimary,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        leading: Container(
          margin: const EdgeInsets.only(right: 6),
          child: IconButton(
              onPressed: (){
                FocusScope.of(context).unfocus();
                Get.back();
              },
              icon: FaIcon(widget.mood == null ? FontAwesomeIcons.xmark : FontAwesomeIcons.arrowLeft,color: Colors.grey.shade400,)
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16,top: 16,bottom: 4),
            child: ElevatedButton(
                onPressed: (){
                  widget.mood != null ? updateMood() :insertMood();
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(72, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: Colors.green.shade700
                ),
                child: const Text('Lưu')
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        color: Colors.blueGrey.shade900,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(() => IconButton(
                onPressed: switchAlign,
                visualDensity: const VisualDensity(horizontal: -4,vertical: -4),
                icon: FaIcon(iconAlign(alignType.value),color: Colors.grey.shade400,size: 24,)
            ),),
            const SizedBox(width: 10,),
            IconButton(
                onPressed: () async {
                  await context.read<HomeProvider>().pickImage();
                },
                visualDensity: const VisualDensity(horizontal: -4,vertical: -4),
                icon: Icon(Icons.add_photo_alternate_outlined,color: Colors.grey.shade400,size: 28,)
            ),
            const SizedBox(width: 10,),
            IconButton(
                onPressed: (){
                  isSpecial.value = !isSpecial.value;
                },
                visualDensity: const VisualDensity(horizontal: -4,vertical: -4),
                icon: Obx(() => FaIcon(isSpecial.value ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
                  color: isSpecial.value ? Colors.yellow : Colors.grey.shade400,size: 26,
                ))
            ),
            const SizedBox(width: 10,),
            IconButton(
                onPressed: () async {
                  bool permissionGranted = await handleLocationPermission(context);
                  if(permissionGranted){
                    Get.to(() => const MapWidget(),transition: Transition.downToUp,curve: Curves.easeInOut);
                  }
                },
                visualDensity: const VisualDensity(horizontal: -4,vertical: -4),
                icon: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      LinearGradient gradient = const LinearGradient(
                        colors: [Colors.red,Colors.orange ,Colors.yellow, Colors.green],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      );
                      return gradient.createShader(bounds);
                    },
                    child: Icon(Icons.location_on_sharp,color: Colors.grey.shade400,size: 30,))
            ),
          ],
        ),
      ),
      body: PopScope(
        onPopInvoked: (b){
          context.read<HomeProvider>().clear();
        },
        child: SingleChildScrollView(
          child: Screenshot(
            controller: _screenshotController,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 32,vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 2,
                  color: Colors.blueGrey
                )
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${DateTimeHelper.dateTimeToString(widget.date)}\n${DateTimeHelper.getWeekdayName(widget.date.weekday)}",
                        style: TextStyle(color: Colors.grey.shade300,fontSize: 14,decoration: TextDecoration.underline),
                      ),
                      if(widget.mood != null)
                      InkWell(
                        onTap: (){
                          showOptionsBottomSheet(context);
                        },
                        child: Icon(Icons.more_vert,color: Colors.grey.shade300)
                      )
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Consumer<EmojiProvider>(builder: (context,emojiProvider,_) => Obx(() => InkWell(
                      onTap: (){
                        showGridBottomSheet(context);
                      },
                      child: emojiProvider.currentEmojiList[indexOfMood.value].svg(width: 80,height: 80)
                  ),),),
                  const SizedBox(height: 16,),
                  Obx(() => Text(Constant.listEmojiNames[indexOfMood.value],
                    style: TextStyle(color: Colors.grey.shade300,fontSize: 20,fontWeight: FontWeight.w600),
                  ),),
                  const SizedBox(height: 16,),
                  InkWell(
                    onTap: showTimePicker,
                    child: Obx(() => Text("-- ${DateTimeHelper.formatTimeHHMM(timeNow.value)} --",
                      style: TextStyle(color: Colors.grey.shade300,fontSize: 20),))
                  ),
                  Consumer<HomeProvider>(builder: (context, homeProvider, child){
                    return ListView.builder(
                      itemCount: homeProvider.listImage.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                      return ItemImage(file: homeProvider.listImage[index], index: index,);
                    });
                  }),
                  Obx(() => TextField(
                    controller: noteController,
                    focusNode: noteFocusNode,
                    style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 16
                    ),
                    maxLines: null,
                    minLines: 1,
                    textAlign: textAlign(alignType.value),
                    cursorWidth: 3,
                    cursorColor: Colors.green.shade700,
                    decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none
                    ),
                  )),
                  Consumer<HomeProvider>(
                    builder: (context, homeProvider, child) {
                      return homeProvider.selectedLocation.isNotEmpty ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on_sharp,color: Colors.white,size: 20,),
                          const SizedBox(width: 6,),
                          Expanded(
                            child: Text(homeProvider.selectedLocation,
                              style: TextStyle(color: Colors.grey.shade300,fontSize: 16),
                            ),
                          ),
                        ],
                      ) : const SizedBox();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void showTimePicker(){
    Navigator.of(context).push(
        showPicker(
          context: context,
          is24HrFormat: true,
          cancelText: 'Đóng',
          okText: 'Chọn',
          backgroundColor: ColorName.colorPrimary,
          accentColor: Colors.white,
          okStyle: const TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.w800,fontSize: 18),
          cancelStyle: const TextStyle(color: Colors.grey,fontWeight: FontWeight.w800,fontSize: 18),
          value: Time.fromTimeOfDay(TimeOfDay.fromDateTime(timeNow.value), 0),
          onChange: (time){
            timeNow.value = DateTime(
                timeNow.value.year,
                timeNow.value.month,
                timeNow.value.day,
                time.hour,
                time.minute
            );
          },
        )
    );
  }
  TextAlign textAlign(int type){
    switch(type){
      case Constant.ALIGN_CENTER : return TextAlign.center;
      case Constant.ALIGN_LEFT : return TextAlign.left;
      case Constant.ALIGN_RIGHT : return TextAlign.right;
      default : return TextAlign.center;
    }
  }
  void switchAlign(){
    switch(alignType.value){
      case Constant.ALIGN_CENTER : alignType.value = Constant.ALIGN_LEFT;
      case Constant.ALIGN_LEFT : alignType.value = Constant.ALIGN_RIGHT;
      case Constant.ALIGN_RIGHT : alignType.value = Constant.ALIGN_CENTER;
    }
  }
  IconData iconAlign(int type){
    switch(type){
      case Constant.ALIGN_CENTER : return FontAwesomeIcons.alignCenter;
      case Constant.ALIGN_LEFT : return FontAwesomeIcons.alignLeft;
      case Constant.ALIGN_RIGHT : return FontAwesomeIcons.alignRight;
      default : return FontAwesomeIcons.alignCenter;
    }
  }
  void insertMood(){
    FocusScope.of(context).unfocus();
    Mood mood = Mood(
        mood: indexOfMood.value,
        note: noteController.text,
        date: DateTime(widget.date.year,widget.date.month,widget.date.day,timeNow.value.hour,timeNow.value.minute),
        isSpecial: isSpecial.value ? 1 : 0,
        align: alignType.value,
    );
    context.read<HomeProvider>().insertMood(mood);
    context.read<StatisticalProvider>().percentOfMood();
    Navigator.of(context).pop();
    Navigator.of(context).pop({'showToast': true, 'message': 'Vâng! Đã thêm thành công'});
  }

  void updateMood(){
    Mood mood = Mood(
      id: widget.mood?.id,
      mood: indexOfMood.value,
      note: noteController.text,
      date: DateTime(widget.date.year,widget.date.month,widget.date.day,timeNow.value.hour,timeNow.value.minute),
      isSpecial: isSpecial.value ? 1 : 0,
      align: alignType.value,
    );
    context.read<HomeProvider>().updateMood(mood);
    if(noteFocusNode.hasFocus){
      noteFocusNode.unfocus();
      Timer(500.milliseconds, (){
        showCustomToast(context: context, message: 'Vâng! Đã cập nhật thành công', imagePath: Assets.image.logo.path);
      });
    }
    else{
      showCustomToast(context: context, message: 'Vâng! Đã cập nhật thành công', imagePath: Assets.image.logo.path);
    }
  }

  void showGridBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorName.darkBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bạn cảm thấy thế nào?',
                          style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: const Icon(Icons.clear,color: Colors.white,)),
                ],
              ),
              const SizedBox(height: 20),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: Constant.listEmoji.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      indexOfMood.value = index;
                      Get.back();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<EmojiProvider>(builder: (context,emojiProvider,_){
                          return emojiProvider.currentEmojiList[index].svg(width: 60,height: 60);
                        }),
                        const SizedBox(height: 8),
                        Text(
                          Constant.listEmojiNames[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
  void showOptionsBottomSheet(BuildContext contextParent) {
    showModalBottomSheet(
      context: contextParent,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: ColorName.darkBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Xóa', textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),),
                      onTap: () {
                        Navigator.pop(context);
                         showConfirmationDialog(context).then((value) {
                          if(value == true){
                            contextParent.read<HomeProvider>().removeMood(widget.mood!);
                            Navigator.of(contextParent).pop({'showToast': true, 'message': 'Đã xoá thành công'});
                          }
                        });
                      },
                      visualDensity: const VisualDensity(vertical: -2),
                    ),
                    Divider(height: 1,color: Colors.lightBlue.shade300,),
                    ListTile(
                      title: const Text('Chia sẻ', textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
                      onTap: ()  {
                        captureAndShareScreen();
                        Navigator.pop(context);
                      },
                      visualDensity: const VisualDensity(vertical: -2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: const Text('Đóng', textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  visualDensity: const VisualDensity(vertical: -2),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Future<void> captureAndShareScreen() async {
    final Uint8List? imageBytes = await _screenshotController.capture();
    if (imageBytes != null) {
      final directory = await getTemporaryDirectory();
      final imagePath = await File('${directory.path}/screenshot.png').create();
      await imagePath.writeAsBytes(imageBytes);

      final xFile = XFile(imagePath.path);
      await Share.shareXFiles([xFile]);
    }
  }
}
