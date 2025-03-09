import 'package:clima_app/services/location.dart';
import 'package:clima_app/services/networking.dart';

const apiKey = '7b8b7755c75b371f4c27e3e8799bf4e0';
const openWeatherMap = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async{
    var url = '$openWeatherMap?q=$cityName&appid=$apiKey&units=metric'; //cityname olayını apinin özelliklerini incelerekn bulduk (openweatherapi sitesinden)
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async{
    Location location = Location(145,23);
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper('$openWeatherMap?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric'); //sondaki metric kısmı celcius birimi olmasını sağlıyor. bu api nin sağladığı bir özellik.
    var response = await networkHelper.getData();
    print('response is: $response');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}


