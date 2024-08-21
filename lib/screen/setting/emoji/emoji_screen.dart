import 'package:flutter/material.dart';
import 'package:mood_press/providers/emoji_provider.dart';
import 'package:mood_press/screen/setting/emoji/widget/item_emoji_type.dart';
import 'package:provider/provider.dart';

class EmojiScreen extends StatefulWidget {
  const EmojiScreen({super.key});

  @override
  State<EmojiScreen> createState() => _EmojiScreenState();
}

class _EmojiScreenState extends State<EmojiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const Text('Biểu tượng cảm xúc'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => Consumer<EmojiProvider>(
                builder: (context,emojiProvider,_){
                  return ItemEmojiType(
                    emojiType: EmojiType.values[index],
                    isSelected: emojiProvider.currentEmojiList == EmojiType.values[index].listEmoji,
                  );
                }
            ),
            separatorBuilder: (context,index) => const SizedBox(height: 14,),
            itemCount: EmojiType.values.length
        ),
      ),
    );
  }
}
