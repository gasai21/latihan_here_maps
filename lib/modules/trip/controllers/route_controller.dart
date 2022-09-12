part of 'controllers.dart';

// A callback to notify the hosting widget.
typedef ShowDialogFunction = void Function(String title, String message);

class RouteController extends GetxController {
  late final HereMapController hereMapController;
  List<MapPolyline> mapPolylines = [];
  late RoutingEngine routingEngine;
  late final ShowDialogFunction showDialog;
}
