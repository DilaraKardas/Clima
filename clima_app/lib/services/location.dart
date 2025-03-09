import 'package:geolocator/geolocator.dart';
class Location{
  double latitude;
  double longitude;

  Location(this.latitude,this.longitude);

  Future<void>getCurrentLocation() async{
    print('latitude is: $latitude longitude is: $longitude');
    try{
      Position position = await Geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    }
    catch (e){
      print(e);
    }
  }

}