part of 'controllers.dart';

class SearchController extends GetxController {
  //SET VARIABLES DATA
  final alamatController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late HereMapController hereMapControllers;
  late MapMarker mapMarker;
  late GeoCoordinates myGeoCoordinates;
  List<MapMarker> mapMarkerList = [];
  List<SearchModelEntity> dataSearch = [];

  void onMapCreated(HereMapController hereMapController) {
    hereMapControllers = hereMapController;

    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError? error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      const double distanceToEarthInMeters = 8000;
      MapMeasure mapMeasureZoom =
          MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
      hereMapController.camera.lookAtPointWithMeasure(
          GeoCoordinates(-6.171932943243747, 106.76575871736435),
          mapMeasureZoom);

      // addMapMarker(GeoCoordinates(-6.171932943243747, 106.76575871736435));

      setTapGestureHandler();
    });
  }

  void setMapCamera(GeoCoordinates coordinates) {
    const double distanceToEarthInMeters = 8000;
    MapMeasure mapMeasureZoom =
        MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
    hereMapControllers.camera
        .lookAtPointWithMeasure(coordinates, mapMeasureZoom);
  }

  void setTapGestureHandler() {
    hereMapControllers.gestures.tapListener = TapListener((Point2D touchPoint) {
      // _pickMapMarker(touchPoint);

      var geoCoordinates = hereMapControllers.viewToGeoCoordinates(touchPoint);

      // print(geoCoordinates);

      addMapMarker(geoCoordinates!);
    });
  }

  void addMapMarker(GeoCoordinates geoCoordinates) {
    // print(mapMarkerList.length.toString() + "test");
    if (mapMarkerList.length > 0) {
      hereMapControllers.mapScene.removeMapMarkers(mapMarkerList);
    }

    getNameAddress(geoCoordinates.latitude.toString(),
        geoCoordinates.longitude.toString());

    int imageWidth = 60;
    int imageHeight = 60;
    MapImage mapImage = MapImage.withFilePathAndWidthAndHeight(
        "assets/marker.png", imageWidth, imageHeight);

    mapMarker = MapMarker(geoCoordinates, mapImage);
    mapMarkerList.add(mapMarker);
    hereMapControllers.mapScene.addMapMarker(mapMarker);

    setMapCamera(geoCoordinates);
  }

  Future<void> getNameAddress(String lat, String lon) async {
    GeocodeModel data = await GeocodeService.getDataGeocode(lat, lon);

    if (data.status == "OK") {
      // print(data.data![0].formattedAddress);

      // Get.snackbar("Alamat", data.data![0].formattedAddress!);

      alamatController.text = data.data![0].formattedAddress!;
    } else {
      // print("Alamat tidak ditemukan");

      Get.snackbar("Alamat", "Alamat tidak ditemukan");
    }
  }

  void addAddressToList() {
    dataSearch.add(SearchModelEntity(alamatController.text,
        myGeoCoordinates.latitude, myGeoCoordinates.longitude));
    Get.back(result: "testtt");
  }
}
