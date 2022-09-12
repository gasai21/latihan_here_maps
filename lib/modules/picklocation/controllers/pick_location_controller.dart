part of 'controllers.dart';

class PickLocationController extends GetxController {
  // SET VARIABLES
  late HereMapController _hereMapControllers;
  late MapMarker mapMarker;
  List<MapMarker> mapMarkerList = [];

  void onMapCreated_old(HereMapController hereMapController) {
    _hereMapControllers = hereMapController;

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

      _addMapMarker(GeoCoordinates(-6.171932943243747, 106.76575871736435));

      _setTapGestureHandler();
    });
  }

  void onMapCreated(HereMapController hereMapController) {
    _hereMapControllers = hereMapController;
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
    });

    _addMapMarker(GeoCoordinates(-6.171932943243747, 106.76575871736435));

    _setTapGestureHandler();
  }

  void _setTapGestureHandler() {
    _hereMapControllers.gestures.tapListener =
        TapListener((Point2D touchPoint) {
      // _pickMapMarker(touchPoint);

      var geoCoordinates = _hereMapControllers.viewToGeoCoordinates(touchPoint);

      // print(geoCoordinates);

      _addMapMarker(geoCoordinates!);
    });
  }

  void _addMapMarker(GeoCoordinates geoCoordinates) {
    // print(mapMarkerList.length.toString() + "test");
    if (mapMarkerList.length > 0) {
      _hereMapControllers.mapScene.removeMapMarkers(mapMarkerList);
    }

    getNameAddress(geoCoordinates.latitude.toString(),
        geoCoordinates.longitude.toString());

    int imageWidth = 60;
    int imageHeight = 60;
    MapImage mapImage = MapImage.withFilePathAndWidthAndHeight(
        "assets/marker.png", imageWidth, imageHeight);

    mapMarker = MapMarker(geoCoordinates, mapImage);
    mapMarkerList.add(mapMarker);
    _hereMapControllers.mapScene.addMapMarker(mapMarker);
  }

  Future<void> getNameAddress(String lat, String lon) async {
    GeocodeModel data = await GeocodeService.getDataGeocode(lat, lon);

    if (data.status == "OK") {
      // print(data.data![0].formattedAddress);

      Get.snackbar("Alamat", data.data![0].formattedAddress!);
    } else {
      // print("Alamat tidak ditemukan");

      Get.snackbar("Alamat", "Alamat tidak ditemukan");
    }
  }
}
