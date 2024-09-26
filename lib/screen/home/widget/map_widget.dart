import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mood_press/gen/assets.gen.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:mood_press/ulti/constant.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../../providers/home_provider.dart';
import '../../../ulti/function.dart';


class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  var lat = 0.0.obs;
  var long = 0.0.obs;
  var loading = false.obs;
  double zoom = 16;
  var loadingChooseAddress = false.obs;
  final geocoding = GoogleGeocodingApi(Constant.googleApiKey);
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

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
            child: Obx(() => Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(lat.value, long.value),
                    zoom: 16,
                  ),
                  minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
                  zoomGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  indoorViewEnabled: true,
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onCameraMove: (cameraPosition){
                    lat.value = cameraPosition.target.latitude;
                    long.value = cameraPosition.target.longitude;
                    zoom = cameraPosition.zoom;
                  },
                ),
                const Center(child: Icon(Icons.location_on_sharp,color: Colors.red,size: 34,),),
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
                            showLoadingDialog(message: S.of(context).please_wait);
                            context.read<HomeProvider>().getAddress(lat.value, long.value, zoom).then((location){
                              if(location != null){
                                context.read<HomeProvider>().selectLocation(location);
                                Get.back();
                                Get.back();
                              }
                              else{
                                showCustomToast(context: context, message: S.of(context).address_not_found);
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade700
                          ),
                          child: Text(S.of(context).select_location)
                      ),
                    ))
              ],
            ),),
          )
      ),
    );
  }
  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      final response = await geocoding.reverse(
        '$latitude,$longitude',
        language: Get.locale!.languageCode
      );

      if (response.results.isNotEmpty) {
        return response.results.first.formattedAddress;
      } else {
        return S.of(context).address_not_found;
      }
    } catch (e) {
      return '${S.of(context).error}: $e';
    }
  }
}
