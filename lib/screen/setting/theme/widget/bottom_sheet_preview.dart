import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/gen/assets.gen.dart';

class BottomSheetPreview extends StatelessWidget {
  final AssetGenImage imagePreview;
  final Function() onPress;
  const BottomSheetPreview({super.key, required this.imagePreview, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const Text('Xem trước hình nền chủ đề'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: Get.width,
                  height: Get.height*0.74,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white)
                    ),
                    child: imagePreview.image(height: Get.height*0.74,fit: BoxFit.fitWidth)
                  )
                ),
              ),
            ),
            ElevatedButton(
              onPressed: onPress,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).splashColor,
                  fixedSize: Size(Get.width, 42)
              ),
              child: const Text('Dùng chủ đề')
            )
          ],
        ),
      ),
    );
  }
}
