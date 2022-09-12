part of 'services.dart';

class GeocodeService {
  static Future<GeocodeModel> getDataGeocode(String lat, String lon,
      {http.Client? client}) async {
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" +
        lat +
        "," +
        lon +
        "&key=AIzaSyCnPyYhvmSixevpGuHdNJ1T_G9OKRnbF-4";

    client ??= http.Client();
    var response = await client.get(Uri.parse(url));

    var data = json.decode(response.body);

    if (data['status'] == "OK") {
      return GeocodeModel(
          status: data['status'],
          data: (data['results'] as List)
              .map((e) =>
                  GeoCodeEntity(formattedAddress: e['formatted_address']))
              .toList());
    } else {
      return GeocodeModel(status: data['status']);
    }
  }
}
