import 'package:firebase_storage/firebase_storage.dart';
import 'package:mood_press/helper/api_client.dart';
import 'package:get/get.dart';
import 'package:mood_press/ulti/constant.dart';

class HomeRepo{
  final ApiClient api;

  HomeRepo({required this.api});

  Future<Response> getAddress(double lat, double long, double zoom) async {
    Map<String,dynamic> query = {
      "lat" : "$lat",
      "lon" : "$long",
      "zoom" : "${zoom.toInt()}",
      "format" : "jsonv2"
    };
    return await api.get(Constant.GET_ADDRESS,queryParams: query);
  }
  Future<List<String>> getVideoUrls() async {
    List<String> videoUrls = [];
    FirebaseStorage storage = FirebaseStorage.instance;
    ListResult result = await storage.ref('video').listAll();

    for (var item in result.items) {
      String downloadUrl = await item.getDownloadURL();
      videoUrls.add(downloadUrl);
    }

    return videoUrls;
  }
}