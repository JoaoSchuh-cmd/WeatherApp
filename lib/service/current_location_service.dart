import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class CurrentLocationService {
  Future<Position?> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    return status == PermissionStatus.granted;
  }
}
