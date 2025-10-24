import "package:flutter/material.dart";

class HourlyForecastCard extends StatelessWidget {
  final String timeText;
  final IconData weatherIcon;
  final String temperatureText;

  const HourlyForecastCard({
    super.key,
    // Named Parameters(that why we are using curly braces and required keyword)
    required this.timeText,
    required this.weatherIcon,
    required this.temperatureText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      surfaceTintColor: Colors.purple,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Text(
              timeText,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Icon(weatherIcon, size: 28),
            SizedBox(height: 8),
            Text(temperatureText, style: TextStyle(fontSize: 14)),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
