import 'package:clima_app/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() { // initState sadece bir defa ve başlangıçta çalıştırılır
    super.initState();
    getLocationData(); //widget çağrılır çağrılmaz lokasyonu almış olacak.
  }
  void getLocationData() async{
    var weatherData = await WeatherModel().getLocationWeather();
    if (weatherData != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(locationWeather: weatherData);
      }));
    } else {
      print("Weather data is null. Please check the API response.");
    }
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(
          locationWeather: weatherData);
    }
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}