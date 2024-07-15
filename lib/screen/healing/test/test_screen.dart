import 'package:flutter/material.dart';
import 'package:mood_press/providers/healing_provider.dart';
import 'package:mood_press/screen/healing/test/widget/item_test_big_image.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HealingProvider>(
        builder: (context,healingProvider,child){
          return CustomScrollView(
            slivers: [
              SliverAnimatedList(
                initialItemCount: healingProvider.listTest.length,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                    position: animation.drive(Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    )),
                    child: ItemTestBigImage(test: healingProvider.listTest[index],),
                  );
                },
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          );
        }
    );
  }
}
