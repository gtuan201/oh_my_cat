import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mood_press/gen/assets.gen.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import '../gen/colors.gen.dart';

Future<bool?> showConfirmationDialog(BuildContext context,{Widget? icon,String? title,String? content,String? confirm,String? nameDelete}) {
  const backgroundColor = Color(0xFF292929);
  const textColor = Colors.white;
  const accentColor = Colors.redAccent;

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ?? const Icon(Icons.delete_forever, color: accentColor, size: 56),
            const SizedBox(height: 16),
            Text(
              title ?? 'Xóa mục này?',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            if(nameDelete != null)
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text(
                  nameDelete,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ),
            const SizedBox(height: 8),
            Text(
              content ?? 'Bạn không thể hoàn tác hành động này.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[400]),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _DialogButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  text: 'Hủy',
                  color: Colors.grey[800]!,
                  textColor: textColor,
                ),
                _DialogButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  text: confirm ?? 'Xóa',
                  color: accentColor,
                  textColor: textColor,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void showCustomToast({
  required BuildContext context,
  required String message,
  String? imagePath,
  Function()? action,
  double? marginBottom,
  Color backgroundColor = Colors.teal,
  Color textColor = Colors.white,
  Duration duration = const Duration(seconds: 2),
}) {
  FToast fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    margin: EdgeInsets.only(bottom: marginBottom ?? 24),
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: backgroundColor,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath ?? Assets.image.logo.path,
          width: 24.0,
          height: 24.0,
        ),
        const SizedBox(width: 12.0),
        Flexible(
          child: Text(
            message,
            style: TextStyle(color: textColor,fontWeight: FontWeight.w500),
          ),
        ),
        if(action != null)
        const SizedBox(width: 12.0),
        if(action != null)
        InkWell(
          onTap: (){
            fToast.removeCustomToast();
            action();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.shade800,
              borderRadius: BorderRadius.circular(12)
            ),
            child: const Text("Xem",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12),),
          ),
        )
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: duration,
  );
}

String colorToHexNoAlpha(Color color) {
  return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
}

Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    final bool? openSettings = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: ColorName.darkBlue,
        title: const Text('Dịch vụ vị trí chưa được bật',style: TextStyle(color: Colors.white),),
        content: const Text('Ứng dụng cần truy cập vị trí của bạn để cung cấp các tính năng dựa trên vị trí. Bạn có muốn bật dịch vụ vị trí không?',style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Không',style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Có',style: TextStyle(color: Colors.lightBlue)),
          ),
        ],
      ),
    );

    if (openSettings == true) {
      if (Platform.isAndroid) {
        await Geolocator.openLocationSettings();
      } else if (Platform.isIOS) {
        await Geolocator.openAppSettings();
      }
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    }

    if (!serviceEnabled) {
      return false;
    }
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return false;
  }

  return true;
}

showLoadingDialog({String message = 'Đang tải...'}) {
  Get.dialog(
    Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: ColorName.darkBlue,),
            const SizedBox(height: 15),
            Text(message),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

Future<void> selectDate(BuildContext context, Function(DateTime) onDateSelected,{DateTime? initialDate}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          colorScheme: const ColorScheme.light(
            onPrimary: Colors.black, // selected text color
            onSurface: Color(0xFFEAC057), // default text color
            primary: Color(0xFFEAC057) // circle color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.amberAccent, // button text color
            ),
          ),
          dialogBackgroundColor:ColorName.colorPrimary,
        ),
        child: child!,
      );
    },
  );
  if (picked != null && picked != DateTime.now()) {
    onDateSelected(picked);
  }
}

Future<File> getFilePathFromUrl(String url) async {
  final FileInfo fileInfo = await DefaultCacheManager().downloadFile(url);
  return fileInfo.file;
}

Future<Duration> getAudioDuration(String audioPath) async {
  final player = AudioPlayer();
  await player.setFilePath(audioPath);
  final duration = player.duration;
  await player.dispose();
  return duration ?? Duration.zero;
}

Future<String> getLocalImagePath(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/${assetPath.split('/').last}');
  await file.writeAsBytes(byteData.buffer.asUint8List());
  return file.path;
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;
  
  final Map<int, Color> shades = {
  50: Color.fromRGBO(red, green, blue, .1),
  100: Color.fromRGBO(red, green, blue, .2),
  200: Color.fromRGBO(red, green, blue, .3),
  300: Color.fromRGBO(red, green, blue, .4),
  400: Color.fromRGBO(red, green, blue, .5),
  500: Color.fromRGBO(red, green, blue, .6),
  600: Color.fromRGBO(red, green, blue, .7),
  700: Color.fromRGBO(red, green, blue, .8),
  800: Color.fromRGBO(red, green, blue, .9),
  900: Color.fromRGBO(red, green, blue, 1),
  };
  
  return MaterialColor(color.value, shades);
}

class _DialogButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final Color textColor;

  const _DialogButton({
    required this.onPressed,
    required this.text,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(text),
    );
  }
}