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
}