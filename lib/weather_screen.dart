import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App", style: TextStyle(fontSize: 24)),
        actions: [
          //**We can use InkWell or GestureDetector() but we can use   */
          // InkWell(
          //   child: Icon(Icons.refresh),
          //   onTap: () {
          //     print("refresh");
          //   },
          // ),
          IconButton(
            onPressed: () {
              print("Refresh");
            },
            icon: Icon(Icons.refresh),
          ),
        ],
        centerTitle: true,
        elevation: 0.5,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),

                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              "25.5°C",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Icon(
                              Icons.sunny,
                              size: 64,
                              color: Colors.yellow,
                              semanticLabel: "Weather Icon",
                            ),
                            Text("Sunny", style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hourly Forecast",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          HourlyForecastCard(),
                          HourlyForecastCard(),
                          HourlyForecastCard(),
                          HourlyForecastCard(),
                          HourlyForecastCard(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Additional Information",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AdditionalInformation(),
                        AdditionalInformation(),
                        AdditionalInformation(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdditionalInformation extends StatelessWidget {
  const AdditionalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.water_drop_rounded, size: 24),
        SizedBox(height: 6),
        Text("Humidity"),
        SizedBox(height: 6),
        Text("94"),
      ],
    );
  }
}

class HourlyForecastCard extends StatelessWidget {
  const HourlyForecastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Text(
              "09:00",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Icon(Icons.cloud, size: 28),
            SizedBox(height: 8),
            Text("23.8°C", style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
