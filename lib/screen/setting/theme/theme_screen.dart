import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mood_press/providers/theme_provider.dart';
import 'package:mood_press/screen/setting/theme/widget/bottom_sheet_preview.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(S.of(context).theme),
        centerTitle: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1/1.6,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: AppTheme.values.skip(1).map((theme) =>
                    InkWell(
                      onTap: (){
                        Get.bottomSheet(
                            BottomSheetPreview(
                              imagePreview: theme.imagePreview,
                              onPress: () {
                                context.read<ThemeProvider>().setTheme(theme);
                                showLoadingDialog(message: S.of(context).please_wait);
                                Timer(2.seconds, (){
                                  Get.back();
                                  Get.back();
                                });
                              },
                            ),
                            isScrollControlled: true,
                            ignoreSafeArea: false
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 1.5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: theme.imageThumb.image(fit: BoxFit.cover)
                        ),
                      ),
                    )
                ).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                context.read<ThemeProvider>().setTheme(AppTheme.normal);
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(Get.width, 42),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),
                  backgroundColor: Theme.of(context).splashColor
              ),
              child: Text(S.of(context).reset_theme,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            ),
          ],
        ),
      ),
    );
  }
}
