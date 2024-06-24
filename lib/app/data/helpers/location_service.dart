import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

Future<Position> getPosition() async {
  try {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  } catch (e) {
    Get.snackbar("Location Service Error", e.toString());
    return Future.error(e);
  }
}

// void _startLocationStream() {
//   var positionStream = Geolocator.getPositionStream(
//     locationSettings: LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 1, // Change according to your requirement
//     ),
//   ).listen((Position position) {
//     _uploadLocationToFirestore(position);
//   });
// }

// void _uploadLocationToFirestore(Position position) {
//   FirebaseFirestore.instance.collection('locations').add({
//     'latitude': position.latitude,
//     'longitude': position.longitude,
//     'timestamp': FieldValue.serverTimestamp(),
//   });
// }
