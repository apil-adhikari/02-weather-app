import 'package:flutter/material.dart';

class AdditionalInformation extends StatelessWidget {
  const AdditionalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    // return Column(

    //   children: [
    //     Icon(Icons.water_drop_rounded, size: 24),
    //     SizedBox(height: 6),
    //     Text("Humidity"),
    //     SizedBox(height: 6),
    //     Text("94"),
    //   ],
    // );

    return Card(
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          child: Column(
            children: [
              Icon(Icons.water_drop_rounded, size: 24),
              SizedBox(height: 6),
              Text("Humidity"),
              SizedBox(height: 6),
              Text("94"),
            ],
          ),
        ),
      ),
    );
  }
}
