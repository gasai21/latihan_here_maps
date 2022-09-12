import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/gestures.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/search.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // SET VARIABLES
  late HereMapController _hereMapControllers;
  late MapMarker mapMarker;
  List<MapMarker> mapMarkerList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: HereMap(
          onMapCreated: _onMapCreated,
        ),
      ),
    );
  }

  void _onMapCreated(HereMapController hereMapController) {
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

  void _addMapMarker(GeoCoordinates geoCoordinates) {
    // print(mapMarkerList.length.toString() + "test");
    if (mapMarkerList.length > 0) {
      _hereMapControllers.mapScene.removeMapMarkers(mapMarkerList);
    }

    _getAddressForCoordinates(
        GeoCoordinates(geoCoordinates.latitude, geoCoordinates.longitude));

    int imageWidth = 60;
    int imageHeight = 60;
    MapImage mapImage = MapImage.withFilePathAndWidthAndHeight(
        "assets/marker.png", imageWidth, imageHeight);

    mapMarker = MapMarker(geoCoordinates, mapImage);
    mapMarkerList.add(mapMarker);
    _hereMapControllers.mapScene.addMapMarker(mapMarker);
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

  void _pickMapMarker(Point2D touchPoint) {
    double radiusInPixel = 2;
    _hereMapControllers.pickMapItems(touchPoint, radiusInPixel,
        (pickMapItemsResult) {
      if (pickMapItemsResult == null) {
        // Pick operation failed.
        return;
      }
      List<MapMarker> mapMarkerList = pickMapItemsResult.markers;
      if (mapMarkerList.length == 0) {
        print("No map markers found.");
        return;
      }

      MapMarker topmostMapMarker = mapMarkerList.first;
      // _hereMapControllers.mapScene.addMapMarker(topmostMapMarker);

      // _addMapMarker(mapMarkerList.first);
    });
  }

  Future<void> _getAddressForCoordinates(GeoCoordinates geoCoordinates) async {
    SearchOptions reverseGeocodingOptions = SearchOptions.withDefaults();
    reverseGeocodingOptions.languageCode = LanguageCode.enGb;
    reverseGeocodingOptions.maxItems = 1;
    var _searchEngine = SearchEngine();

    _searchEngine.searchByCoordinates(geoCoordinates, reverseGeocodingOptions,
        (SearchError? searchError, List<Place>? list) async {
      if (searchError != null) {
        // _showDialog("Reverse geocoding", "Error: " + searchError.toString());
        print("Reverse geocoding Error: " + searchError.toString());
        return;
      }

      // If error is null, list is guaranteed to be not empty.
      // _showDialog("Reverse geocoded address:", list!.first.address.addressText);
      print("Reverse geocoded address:" + list!.first.address.addressText);
    });
  }
}
