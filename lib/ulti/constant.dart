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
}