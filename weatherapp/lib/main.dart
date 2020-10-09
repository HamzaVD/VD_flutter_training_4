import 'package:flutter/material.dart';
import 'package:weatherapp/weather_model.dart';
import 'package:weatherapp/weather_service.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Weather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.refresh,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () async {
                await WeatherService.getWeatherData('Karachi', http.Client());
              },
            ),
          ],
        ),
        body: FutureBuilder<WeatherResponse>(
            future: WeatherService.getWeatherData('Karachi', http.Client()),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? weatherWidgetBody(snapshot)
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }

  Widget weatherWidgetBody(snapshot) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new RichText(
            text: new TextSpan(
              style: new TextStyle(fontSize: 22.0, color: Colors.black),
              children: <TextSpan>[
                new TextSpan(
                    text: '${convertToCentigrade(snapshot.data.main.temp)}'),
                new TextSpan(
                    text: ' °',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red)),
                new TextSpan(text: 'C')
              ],
            ),
          ),
          new RichText(
            text: new TextSpan(
              style: new TextStyle(fontSize: 22.0, color: Colors.black),
              children: <TextSpan>[
                new TextSpan(
                    text:
                        '${convertToCentigrade(snapshot.data.main.tempMin)} - '),
                new TextSpan(
                    text: '${convertToCentigrade(snapshot.data.main.tempMax)}'),
                new TextSpan(
                    text: ' °',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red)),
                new TextSpan(text: 'C')
              ],
            ),
          ),
          Text(
            snapshot.data.weather.first.main,
            style: TextStyle(
                color: Colors.red, fontSize: 34, fontWeight: FontWeight.bold),
          ),
          Text(
            snapshot.data.name,
            style: TextStyle(fontSize: 22),
          ),
          Text(
            snapshot.data.sys.country,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  double convertToCentigrade(double tempInKelvin) {
    return tempInKelvin - 273.15;
  }
}
