part of 'services.dart';

class SearchService {
  static Future<List<Map<String, dynamic>>> doSearchLocation(String query,
      {http.Client? client}) async {
    String url =
        "https://autosuggest.search.hereapi.com/v1/autosuggest?at=-2.4153279,108.8516932&limit=100&lang=id&q=" +
            query +
            "&apiKey=YOUR_API_KEY";

    client ??= http.Client();
    var response = await client.get(Uri.parse(url));

    Iterable json = convert.jsonDecode(response.body);
    List<SearchModelEntity> dataLocation = [];
    dataLocation = List<SearchModelEntity>.from(
      json.map(
        (model) => SearchModelEntity.fromJson(model),
      ),
    );

    return Future.value(dataLocation
        .map((e) => {'label': e.label, 'lat': e.lat, 'lon': e.lon})
        .toList());
  }

  static Future<List<SearchModelEntity>> doSearchLocation2(String query,
      {http.Client? client}) async {
    String url =
        "https://autosuggest.search.hereapi.com/v1/autosuggest?at=-2.4153279,108.8516932&limit=100&lang=id&q=" +
            query +
            "&apiKey=YOUR_API_KEY";

    client ??= http.Client();
    var response = await client.get(Uri.parse(url));

    var data = json.decode(response.body);

    return ((data['items'] ?? []) as List)
        .map((e) => SearchModelEntity.fromJson(e))
        .toList();
  }
}
