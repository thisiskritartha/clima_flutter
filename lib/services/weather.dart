import 'package:clima_flutter/services/location.dart';
import 'package:clima_flutter/services/networking.dart';

const String apiKey = 'f575532a6ba332d9317b49e4325b5a2b';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather({required String cName}) async {
    String url = '$openWeatherMapURL?q=$cName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    var lat = location.latitude;
    var lon = location.longitude;

    String url =
        '$openWeatherMapURL?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
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
      return 'Its too hot for Work.';
    } else if (temp > 20) {
      return 'Time for shorts and T-shirts.';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤.';
    } else {
      return 'Bring a 🧥 just in case.';
    }
  }
}
