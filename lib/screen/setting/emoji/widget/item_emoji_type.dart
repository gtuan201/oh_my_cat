import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/providers/emoji_provider.dart';
import 'package:mood_press/screen/setting/emoji/widget/bottom_sheet_preview_emoji.dart';
import '../../../../gen/assets.gen.dart';

class ItemEmojiType extends StatelessWidget {
  final EmojiType emojiType;
  final bool isSelected;
  const ItemEmojiType({super.key, required this.emojiType, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.bottomSheet(
          BottomSheetPreviewEmoji(emojiType: emojiType),
          isScrollControlled: true,
          ignoreSafeArea: false
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.6) : Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isSelected ? Theme.of(context).splashColor : Theme.of(context).cardTheme.shadowColor!,
                width: 3
            )
        ),
        height: 80,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: emojiType.listEmoji.sublist(emojiType.listEmoji.length - 5).map((element) => element.svg(width: 52,height: 52)).toList(),
          ),
        ),
      ),
    );
  }
}
