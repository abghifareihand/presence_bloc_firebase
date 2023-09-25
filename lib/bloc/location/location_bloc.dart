import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:presence_bloc_firebase/data/datasources/location_datasource.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationDatasource datasource;

  LocationBloc(
    this.datasource,
  ) : super(LocationInitial()) {
    on<GetLocationEvent>((event, emit) async {
      emit(LocationLoading());
      try {
        // Permission dulu
        final position = await datasource.getPermissionLocation();
        final address = await datasource.getAddressPosition(position);
        double distance = Geolocator.distanceBetween(
          -6.325912189356302,
          106.8011669839052,
          position.latitude,
          position.longitude,
        );
        await datasource.presensi(position, address, distance);

        emit(LocationLoaded());
      } catch (e) {
        emit(LocationError(message: e.toString()));
      }
    });
  }
}
