import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/datetime/date_time.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatmap extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDateYYYYMMDD;




  const MyHeatmap({
    super.key, 
    required this.datasets, 
    required this.startDateYYYYMMDD,
    
    });

  @override
  Widget build(BuildContext context) {
    return Container( 
      padding: const EdgeInsets.all(16.0),
      color: Colors.transparent,
      child: HeatMap(
        startDate: createDateTimeObject(startDateYYYYMMDD),
        endDate: DateTime.now().add(const Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[800],
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const{
          1: Colors.green,

        },
      ),
    );
  }
}