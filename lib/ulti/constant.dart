import 'package:flutter/material.dart';
import 'package:mood_press/gen/colors.gen.dart';

import '../gen/assets.gen.dart';

class Constant{

  static const String BASE_URL_MAP = "https://nominatim.openstreetmap.org";
  static const String AI_URL = 'https://openrouter.ai';
  static const String GET_ADDRESS = "reverse.php";
  static const String ENDPOINT_AI = 'api/v1/chat/completions';

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

  static List<SvgGenImage> listEmojiBear = [
    Assets.image.cry3,
    Assets.image.sad3,
    Assets.image.angry3,
    Assets.image.annoyed3,
    Assets.image.worry3,
    Assets.image.confused3,
    Assets.image.shocked3,
    Assets.image.sleep3,
    Assets.image.tears3,
    Assets.image.happy3,
    Assets.image.heartEyes3,
  ];

  static Map<String, List<String>> emojiNames = {
    'vi': [
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
    ],
    'en': [
      'Crying',
      'Sad',
      'Angry',
      'Annoyed',
      'Worried',
      'Confused',
      'Shocked',
      'Sleepy',
      'Emotional',
      'Happy',
      'Love',
    ],
  };

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

  static const String enableLocalAuth = "enable_local_auth";
  static const String enableAuthBiometric = "enable_auth_biometric";
  static const String password = "password";
  static const String reminderBackup = "reminder_backup";
  static const String theme = "theme";
  static const String emoji = "emoji";
  static const String imagePath = "imagePath";
  static const String widgetColor = "widgetColor";
  static const String dateTime = "dateTime";
  static const String showToast = "showToast";
  static const String message = "message";
  static const String isLocal = "isLocal";
  static const String notAvailable = "NotAvailable";
  static const String notEnrolled = "NotEnrolled";
  static const String languages = "Languages";
  static const String googleApiKey = "AIzaSyC1sswvFkexF72r2-UWCwPM1vPmW_QHo84";
  static const String aiApiKey = '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';
  static const int addMood = 0;
  static const int widget = 1;
  static const int forgotPassword = 2;
  static const int backup = 3;
  static const int changeEmoji = 4;
  static const int changeTheme = 5;

  //widget
  static const String androidWidget = "CalendarEmojiWidget";

  //ID notification
  static int NOTIFICATION_BACKUP = 101;
}