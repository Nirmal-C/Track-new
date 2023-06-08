// import 'package:firebase_database/firebase_database.dart';

// class Marker {
//   String country;
//   late double latitude;
//   late double longitude;

//   Marker(
//       {required this.country, required this.latitude, required this.longitude});

//   Marker.fromJson(this.country, Map data) {
//     latitude = data['latitude'];
//     longitude = data['longitude'];
//   }
// }

// late List<Marker> _markers;

// // Get the markers from database for a local collection.
// Future<List<Marker>> getMarkers() async {
//   _markers.clear();

//   var _dbRef = FirebaseDatabase(
//           databaseURL:
//               'https://track-6aeb6-default-rtdb.asia-southeast1.firebasedatabase.app/')
//       .ref().once();
//   await _dbRef.then(
//     (dataSnapShot) async {
//       // Access the markers from database.
//       Map<dynamic, dynamic> mapMarkers = dataSnapShot.;

//       // Get the markers in a local collection.
//       mapMarkers.forEach(
//         (key, value) {
//           Marker marker = Marker.fromJson(key, value);
//           _markers.add(Marker(
//               country: key,
//               latitude: double.parse(marker.latitude.toString()),
//               longitude: double.parse(marker.longitude.toString())));
//         },
//       );
//     },
//   );
//   return _markers;
// }
