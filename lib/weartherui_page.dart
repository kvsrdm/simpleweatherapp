import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'weather.dart';
import 'weatherapp_page.dart';

class WeatherUI extends StatefulWidget {
  @override
  _WeatherUIState createState() => _WeatherUIState();
}

class _WeatherUIState extends State<WeatherUI> {
  String city = "";
  var cityId;

  final TextEditingController _textController = TextEditingController();

  WeatherApp weatherApp = WeatherApp();
  Weather weather = Weather();
  Parent parent = Parent();
  double maxTemp;
  double minTemp;

  bool data = false;

  final String text = 'HAVA DURUMU';
  final String hintText = 'Ara: "Ankara", "İstanbul", "London"..';
  final String noCityData = "Şehre ait verilere ulaşılamıyor!";
  final String max = "Max : ";
  final String min = "Min : ";
  final String degree = " ℃";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white70,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(text,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 300,
                        margin: EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: hintText),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            city = _textController.text;
                            weatherApp.getResult(city).then((value) {
                              if (value == null) {
                                Toast.show(noCityData, context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              } else {
                                setState(() {
                                  maxTemp =
                                      value.consolidatedWeather[0].maxTemp;
                                  minTemp =
                                      value.consolidatedWeather[0].maxTemp;
                                  data = true;
                                });
                              }
                            });
                          }),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(city.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24)),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Visibility(
                      visible: data,
                      child: Text(
                        max + maxTemp.toString() + degree,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Visibility(
                    visible: data,
                    child: Center(
                      child: Text(
                        min + minTemp.toString() + degree,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
