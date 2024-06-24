import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:mood_press/providers/home_provider.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';


class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  var lat = 0.0.obs;
  var long = 0.0.obs;
  var loading = false.obs;
  var loadingChooseAddress = false.obs;

  @override
  void initState() {
    super.initState();
    loading.value = true;
    Geolocator.getCurrentPosition().then((position){
      lat.value = position.latitude;
      long.value = position.longitude;
      loading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => loading.value 
          ? const Center(child: CircularProgressIndicator(color: ColorName.darkBlue,),) 
          : Opacity(
            opacity: loadingChooseAddress.value ? 0.5 : 1,
            child: FlutterMap(
              options: MapOptions(
                  initialCenter: LatLng(lat.value, long.value),
                  initialZoom: 13,
                  onPositionChanged: (m,b) async {
                    lat.value = m.center.latitude;
                    long.value = m.center.longitude;
                  }
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(lat.value, long.value),
                      width: 80,
                      height: 80,
                      child: const Icon(Icons.location_on_sharp,color: Colors.red,size: 30,),
                    ),
                  ],
                ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 46),
                    child: IconButton(
                        onPressed: (){
                          Get.back();
                        },
                        icon: const Icon(Icons.clear,size: 34,)
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            loadingChooseAddress.value = true;
                            showLoadingDialog(message: 'Vui lòng đợi...');
                            getAddressFromLatLng(lat.value, long.value).then((location){
                              context.read<HomeProvider>().selectLocation(location);
                              Get.back();
                              Get.back();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade700
                          ),
                          child: const Text('Chọn địa điểm')
                      ),
                    )
                )
              ],
            ),
          )
      ),
    );
  }
  Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.street}${place.street!.isNotEmpty ? ", " :""}${place.locality}, ${place.country}";
      }
      return "Không tìm thấy địa chỉ";
    } catch (e) {
      return "Lỗi: $e";
    }
  }
}
