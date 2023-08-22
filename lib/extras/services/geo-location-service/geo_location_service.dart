import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:location/location.dart';
import 'package:untitled05/extras/helpers/show_toast_helper.dart';
import 'package:untitled05/out-buildings/app_logger.dart';

class GeoLocationService {
  ///Finals
  static final Location _location = Location();

  ///To use this controller you must run [runLocationService]
  static StreamController<LocationData>? _locationDataStreamController;
  static StreamController<LocationData>? get locationDataStreamController => _locationDataStreamController;

  ///OnLocation Change Implementation
  static LocationData? _locationData;
  static LocationData? get locationData => _locationData;
  static StreamSubscription? _locationDataSubscription;

  static void runLocationService() => {
    _location.changeSettings(interval: 1000, distanceFilter: 100,),
    _locationDataStreamController ??= StreamController<LocationData>.broadcast(),
    _locationDataSubscription ??= _location.onLocationChanged.listen(
      (locationData,) => _onLocationChangedCallBack(locationData,),
    ),
  };

  static void _onLocationChangedCallBack(LocationData locationData,) => {
    _locationData = locationData,
    _locationDataStreamController?.add(locationData,),
  };

  static void disposeLocationService() => {
    _locationDataSubscription?.cancel().then((_,) => _locationDataSubscription = null,),
    _locationDataStreamController?.close().then((_,) => _locationDataStreamController = null,),
  };

  ///Get Current Location
  static Future<Either<dynamic, LocationData>> getCurrentLocation() async{
    try {
      final currentLocation = await _location.getLocation().timeout(
        const Duration(seconds: 3,),
        onTimeout: () => Future.value(_locationData,),
      );
      return Right(currentLocation,);
    }
    on Exception catch (e) {
      e.exceptionErrorLog("Get current location",);
      return const Left(null,);
    }
  }

  ///CHECK LOCATION SERVICE IS ENABLED
  static Future<bool> checkServiceIsEnabled() async{
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        showErrorToast("Location services are disabled.",);
        return false;
      }
    }
    return true;
  }
}

