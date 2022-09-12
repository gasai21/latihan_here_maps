part of 'models.dart';

class GeocodeModel extends Equatable {
  final String? status;

  final List<GeoCodeEntity>? data;

  const GeocodeModel({@required this.status, this.data});

  @override
  List<Object?> get props => [status, data];
}

class GeoCodeEntity extends Equatable {
  final String? formattedAddress;

  const GeoCodeEntity({@required this.formattedAddress});

  @override
  List<Object?> get props => [formattedAddress];
}
