import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

const apiKey = '0f4abf9e48d2bdc335bac3abbe5c0e4b';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //---------------------------------------------------------
  void getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=$apiKey'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      var longitude = jsonDecode(data)['coord']['lon'];
      var weatherDescription = jsonDecode(data)['weather'][0]['main'];
      var temperature = jsonDecode(data)['main']['temp'];
      var cityName = jsonDecode(data)['name'];

      // print(data); //print json all data
      print(temperature);
      print(weatherDescription);
      print(longitude);
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print(position);
  }

  @override
  void initState() {
    super.initState();
    print('app opened');
    getData();
  }

//---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  getData();
                },
                child: Text('get Json Data'),
              ),
              ElevatedButton(
                onPressed: () {
                  getLocation();
                },
                child: Text('get current lat and log'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
