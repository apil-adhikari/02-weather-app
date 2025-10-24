import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_information.dart';
import 'package:weather_app/hourly_forecast_card.dart';
import 'package:weather_app/secrets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final String cityName = 'Kathmandu';

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$openWeatherAPIKey',
        ),
      );

      final data = jsonDecode(response.body);

      if (data['cod'] != '200') {
        throw data['message'];
      }

      return data;
      // (data['list'][0]['main']['temp']);
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }

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

      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          // Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("snapshot $snapshot");
            return Center(child: CircularProgressIndicator.adaptive());
          }

          // Error State
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          // Data Loaded State
          // Same as: if(snapshot.hasData) {} because it checks for null too
          final data = snapshot.data!;

          final currentWeatherData = data['list'][0];

          final currentTempK = currentWeatherData['main']['temp'];
          // final currentTempC = currentTempK - 273.15;
          // final currentTempF =
          //     (currentTempK - 273.15) * 9 / 5 +
          //     32; // Convert Kelvin to Fahrenheit
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final cityLocation = data['city']['name'];
          final countryLocation = data['city']['country'];

          // DateTime sunriseTime = DateTime.fromMillisecondsSinceEpoch(
          //   data['city']['sunrise'] * 1000,
          //   isUtc: true,
          // ).toUtc();
          // final sunriseTimeFormatted = DateFormat(
          //   'hh:mm a',
          // ).format(sunriseTime);
          // print(sunriseTimeFormatted);
          // DateTime sunsetTime = DateTime.fromMillisecondsSinceEpoch(
          //   data['city']['sunset'] * 1000,
          //   isUtc: true,
          // ).toUtc();
          // final sunsetTimeFormatted = DateFormat('hh:mm a').format(sunsetTime);
          // print(sunsetTimeFormatted);
          // Extract timestamps
          final int sunriseTimestamp = data['city']['sunrise'];
          final int sunsetTimestamp = data['city']['sunset'];
          final int timezoneOffset = data['city']['timezone'];

          // Convert sunrise and sunset from UTC UNIX timestamp
          final DateTime sunriseUtc = DateTime.fromMillisecondsSinceEpoch(
            sunriseTimestamp * 1000,
            isUtc: true,
          );
          final DateTime sunsetUtc = DateTime.fromMillisecondsSinceEpoch(
            sunsetTimestamp * 1000,
            isUtc: true,
          );

          // Apply the timezone offset to get city’s local time
          final DateTime sunriseLocal = sunriseUtc.add(
            Duration(seconds: timezoneOffset),
          );
          final DateTime sunsetLocal = sunsetUtc.add(
            Duration(seconds: timezoneOffset),
          );

          // Format times
          final String sunriseFormatted = DateFormat(
            'hh:mm a',
          ).format(sunriseLocal);
          final String sunsetFormatted = DateFormat(
            'hh:mm a',
          ).format(sunsetLocal);

          // Print or display
          print('Sunrise: $sunriseFormatted');
          print('Sunset: $sunsetFormatted');

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Icon(Icons.pin_drop_rounded),
                        Text(
                          "$cityLocation, $countryLocation",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

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
                                  "$currentTempK K",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Icon(
                                  currentSky == "Clouds"
                                      ? Icons.cloud
                                      : currentSky == "Rain"
                                      ? Icons.beach_access
                                      : currentSky == "Clear"
                                      ? Icons.wb_sunny
                                      : Icons.wb_cloudy,

                                  size: 64,

                                  semanticLabel: "Weather Icon",
                                ),
                                Text(
                                  currentSky,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
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

                        // SingleChildScrillView is allowing horizontal scrolling of Row widget
                        // Performance issue with large data is that this renders all children widgets at once
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: Row(
                        //     children: [
                        //       for (int i = 0; i < 39; i++)
                        //         HourlyForecastCard(
                        //           timeText: hourlyForecastData[i + 1]['dt']
                        //               .toString(),
                        //           weatherIcon:
                        //               hourlyForecastData[i +
                        //                       1]['weather'][0]['main'] ==
                        //                   "Clouds"
                        //               ? Icons.cloud
                        //               : hourlyForecastData[i +
                        //                         1]['weather'][0]['main'] ==
                        //                     "Rain"
                        //               ? Icons.beach_access
                        //               : hourlyForecastData[i +
                        //                         1]['weather'][0]['main'] ==
                        //                     "Clear"
                        //               ? Icons.wb_sunny
                        //               : Icons.wb_cloudy,
                        //           temperatureText:
                        //               hourlyForecastData[i + 1]['main']['temp']
                        //                   .toString(),
                        //         ),
                        //     ],
                        //   ),
                        // ),

                        // OPTIMIZATION using Lazy Loading with ListView.builder
                        // Using ListView.builder for better performance with large data sets
                        // Data for Hourly Forecast
                        // final hourlyTime = hourlyForecastData['dt_txt'];
                        // final hourlyTempK = hourlyForecastData['main']['temp'];
                        // final hourlySky = hourlyForecastData['weather'][0]['main'];
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                5, // improves the ability of the [ListView] to estimate the maximum scroll extent.
                            itemBuilder: (context, index) {
                              final hourlyForecastData =
                                  data['list'][index +
                                      1]; // In ListView, index starts with 0
                              final time = DateTime.parse(
                                hourlyForecastData['dt_txt'],
                              );

                              return HourlyForecastCard(
                                /// Date Extraction
                                /// 1) Using substring (YYYY-MM-DD )
                                /// 2) Using package like 'intl'
                                timeText: DateFormat.j().format(time),
                                weatherIcon:
                                    hourlyForecastData['weather'][0]['main'] ==
                                        "Clouds"
                                    ? Icons.cloud
                                    : hourlyForecastData['weather'][0]['main'] ==
                                          "Rain"
                                    ? Icons.beach_access
                                    : hourlyForecastData['weather'][0]['main'] ==
                                          "Clear"
                                    ? Icons.wb_sunny
                                    : Icons.wb_cloudy,
                                temperatureText:
                                    hourlyForecastData['main']['temp']
                                        .toString(),
                              );
                            },
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
                                  value: "$currentWindSpeed m/s",
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
                                  value: "$currentPressure hPa",
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
                                  value: "$currentHumidity%",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 10,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Sunrise",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Icon(
                                    Icons.wb_sunny,
                                    size: 50,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    sunriseFormatted,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),
                        Expanded(
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 10,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Sunset",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Icon(
                                    Icons.nights_stay,
                                    size: 50,
                                    color: Colors.orange.shade900,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    sunsetFormatted,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
