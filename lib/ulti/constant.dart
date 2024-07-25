import 'package:flutter/material.dart';
import 'package:mood_press/gen/colors.gen.dart';

import '../gen/assets.gen.dart';

class Constant{

  static const String BASE_URL_MAP = "https://nominatim.openstreetmap.org";
  static const String GET_ADDRESS = "reverse.php";

  static const int ALIGN_CENTER = 0;
  static const int ALIGN_LEFT = 1;
  static const int ALIGN_RIGHT = 2;

  static List<SvgGenImage> listEmoji = [
    Assets.image.cry,
    Assets.image.sad,
    Assets.image.angry,
    Assets.image.annoyed,
    Assets.image.worry,
    Assets.image.confused,
    Assets.image.shocked,
    Assets.image.sleep,
    Assets.image.tears,
    Assets.image.happy,
    Assets.image.heartEyes,
  ];

  static List<SvgGenImage> listEmojiHuman = [
    Assets.image.cry2,
    Assets.image.sad2,
    Assets.image.angry2,
    Assets.image.annoyed2,
    Assets.image.worry2,
    Assets.image.confused2,
    Assets.image.shocked2,
    Assets.image.sleep2,
    Assets.image.tears2,
    Assets.image.happy2,
    Assets.image.heartEyes2,
  ];

  static List<String> listEmojiNames = [
    'Khóc',
    'Buồn',
    'Giận dữ',
    'Khó chịu',
    'Lo lắng',
    'Bối rối',
    'Sốc',
    'Buồn ngủ',
    'Xúc động',
    'Vui vẻ',
    'Yêu',
  ];
  static List<Color> moodColor = [
    ColorName.cry,
    ColorName.sad,
    ColorName.angry,
    ColorName.annoyed,
    ColorName.worry,
    ColorName.confused,
    ColorName.shocked,
    ColorName.sleep,
    ColorName.tears,
    ColorName.happy,
    ColorName.heartEyes,
  ];

  static String emotionTestID = "1";
  static String worryTestID = "2";
  static String depressionTestID = "3";
  static String adhdTestID = "4";
}