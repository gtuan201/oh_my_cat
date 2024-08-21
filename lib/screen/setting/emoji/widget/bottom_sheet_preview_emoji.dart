import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/providers/emoji_provider.dart';
import 'package:mood_press/ulti/constant.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:provider/provider.dart';


class BottomSheetPreviewEmoji extends StatelessWidget {
  final EmojiType emojiType;
  const BottomSheetPreviewEmoji({super.key, required this.emojiType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const Text('Xem trước biểu tượng cảm xúc'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
                children: emojiType.listEmoji.map((element) => Container(
                    padding: const EdgeInsets.all(14),
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
                      element.svg(width: 52,height: 52),
                      const SizedBox(height: 12,),
                      Text(
                        Constant.listEmojiNames[emojiType.listEmoji.indexOf(element)],
                        style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .color,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  )
                )
                ).toList(),
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  context.read<EmojiProvider>().changeEmoji(emojiType);
                  showLoadingDialog(message: 'Vui lòng đợi');
                  Timer(2.seconds,(){
                    Get.back();
                    Get.back();
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).splashColor,
                    fixedSize: Size(Get.width, 42)
                ),
                child: const Text('Dùng nó')
            )
          ],
        ),
      ),
    );
  }
}
