import 'package:flutter/material.dart';

class TimeText extends StatelessWidget {
  const TimeText({required this.time, super.key});

  final Duration time;

  @override
  Widget build(BuildContext context) {
    final stringBuffer = StringBuffer();
    final days = time.inDays;
    final hours = time.inHours;
    final minutes = time.inMinutes;

    if (days > 0) stringBuffer.write('$days d ');
    if (hours > 0) stringBuffer.write('${hours % Duration.hoursPerDay} h ');
    if (minutes > 0) {
      stringBuffer.write('${minutes % Duration.minutesPerHour} m');
    }

    return Text('time: ${stringBuffer.toString()}');
  }
}
