import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_information.dart';
import 'package:weather_app/hourly_forecast_card.dart';

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

                    // Row(
                    //   children: [
                    //     Flexible(
                    //       fit: FlexFit.tight,
                    //       flex: 1,
                    //       child: SizedBox(child: AdditionalInformation(icon: Icons.air,
                    //       label: "Wind Speed",
                    //       value: "3 km/h",
                    //     ))),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: SizedBox(
                            child: AdditionalInformation(
                              icon: Icons.air,
                              label: "Wind Speed",
                              value: "3 km/h",
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: SizedBox(
                            child: AdditionalInformation(
                              icon: Icons.thermostat,
                              label: "Pressure",
                              value: "1014mb",
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: SizedBox(
                            child: AdditionalInformation(
                              icon: Icons.shield,
                              label: "UV Index",
                              value: "High(7)",
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: SizedBox(
                            child: AdditionalInformation(
                              icon: Icons.water_drop,
                              label: "Humidity",
                              value: "94%",
                            ),
                          ),
                        ),
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
