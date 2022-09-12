part of 'models.dart';

class SearchModel extends Equatable {
  final List<SearchModelEntity> data;

  const SearchModel(this.data);

  @override
  List<Object?> get props => [data];
}

class SearchModelEntity extends Equatable {
  final String label;
  final double lat;
  final double lon;

  const SearchModelEntity(this.label, this.lat, this.lon);

  factory SearchModelEntity.fromJson(Map<String, dynamic> json) =>
      SearchModelEntity(
        json.containsKey("address") ? json['address']['label'] : "-",
        json.containsKey("position") ? json['position']['lat'] : 0,
        json.containsKey("position") ? json['position']['lng'] : 0,
      );

  @override
  List<Object?> get props => [label, lat, lon];
}
