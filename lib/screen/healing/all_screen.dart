import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/providers/healing_provider.dart';
import 'package:mood_press/screen/healing/widget/item_all_music.dart';
import 'package:mood_press/screen/healing/widget/item_test.dart';
import 'package:provider/provider.dart';
import '../../data/model/test.dart';
import '../../ulti/audio.dart';
import '../../ulti/constant.dart';
import 'widget/item_pdf_thumnail.dart';
import 'widget/item_quote.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});

  @override
  AllScreenState createState() => AllScreenState();
}

class AllScreenState extends State<AllScreen> {

  List<Widget> items = [];

  @override
  void initState() {
    super.initState();
    context.read<HealingProvider>().getListTest();
    context.read<HealingProvider>().getListQuotes();
    for (int i = 0; i < 8; i += 2) {
      items.add(Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ItemAllMusic(Audio.listAudio[i]),
          const SizedBox(height: 10,),
          if (i + 1 < Audio.listAudio.length)
            ItemAllMusic(Audio.listAudio[i + 1]),
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Âm thanh thư giãn',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w700,fontSize: 16),),
                  Icon(Icons.arrow_forward,color: Colors.white,)
                ],
              ),
            ),
            const SizedBox(height: 12,),
            CarouselSlider(
              options: CarouselOptions(
                  height: 222.0,
                  viewportFraction: 0.92,
                  initialPage: 0,
                  enableInfiniteScroll: false
              ),
              items: items,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tự chăm sóc',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w700,fontSize: 16),),
                  Icon(Icons.arrow_forward,color: Colors.white,)
                ],
              ),
            ),
            SizedBox(
              width: Get.width,
              height: 156,
              child: ListView.separated(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                itemBuilder: (context,index)
                => Container(
                  padding: EdgeInsets.only(left: index == 0 ? 24 : 0, right: index == 3 ? 24 : 0),
                    child: PdfThumbnail(pdfUrl: Constant.listSelfCare[index])),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 14,);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Bài kiểm tra',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w700,fontSize: 16),),
                  InkWell(
                      onTap: () {

                      },
                      child: const Icon(Icons.arrow_forward,color: Colors.white,))
                ],
              ),
            ),
            Selector<HealingProvider,List<Test>>(
                builder: (context,listTest,child){
                  List<Widget> itemsTest = [];
                  for (int i = 0; i < listTest.length; i += 2) {
                    itemsTest.add(Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ItemTest(test:listTest[i]),
                        const SizedBox(height: 10,),
                        if (i + 1 < listTest.length)
                          ItemTest(test: listTest[i + 1]),
                      ],
                    ));
                  }
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 222.0,
                        viewportFraction: 0.92,
                        initialPage: 0,
                        enableInfiniteScroll: false
                    ),
                    items: itemsTest,
                  );
                },
                selector: (context,provider) => provider.listTest
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Quote về sức khỏe tinh thần',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w700,fontSize: 16),),
                  InkWell(
                      onTap: () {

                      },
                      child: const Icon(Icons.arrow_forward,color: Colors.white,)
                  ),
                ],
              ),
            ),
            Selector<HealingProvider,List<String>>(
                builder: (context,listQuote,child){
                  return CarouselSlider(
                    options: CarouselOptions(
                        viewportFraction: 0.92,
                        height: 340,
                        initialPage: 0,
                        enableInfiniteScroll: false
                    ),
                    items: listQuote.map((url) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ItemQuote(imageUrl: url))).toList(),
                  );
                },
                selector: (context,provider) => provider.listQuotes
            ),
            const SizedBox(height: 32,),
          ],
        ),
      ),
    );
  }
}