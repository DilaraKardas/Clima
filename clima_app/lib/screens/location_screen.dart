import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:clima_app/utilities/constants.dart';
import 'package:clima_app/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();

  final locationWeather;
  LocationScreen({this.locationWeather});
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();


  int temprature=0;
  String weatherIcon = '';
  String weatherMessage = '';
  String ?cityName;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather); //150. video 2.57. saniye / 5.49. saniye
  }

  void updateUI(dynamic weatherData){
    setState(() {
      if(weatherData == null){
        temprature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get access weather data';
        cityName = '';
        return;
      }
      var condition = weatherData['weather'][0]['id'];
      print(condition);
      weatherIcon = weather.getWeatherIcon(condition);
      double temp = weatherData['main']['temp'];
      temprature = temp.toInt();
      weatherMessage = weather.getMessage(temprature);
      cityName = weatherData['name'];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if(typedName != null){
                        var weatherData = await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}