import 'package:flutter/cupertino.dart';

class CupertinoTime extends StatefulWidget {
  const CupertinoTime({super.key});

  @override
  State<CupertinoTime> createState() => _CupertinoTimeState();
}

class _CupertinoTimeState extends State<CupertinoTime> {
  int minuteInterval = 15;
  @override
  Widget build(BuildContext context) {
    DateTime initialDateTime = DateTime.now();
    int initialMinute = initialDateTime.minute;

    if (initialDateTime.minute % 15 != 0) {
      initialMinute = initialDateTime.minute - initialDateTime.minute % 15 + 15;
    }
    // else {
    //   initialMinute = initialDateTime.minute - initialDateTime.minute % 5 + 5;
    // }
    return SizedBox(
      height: 500,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: DateTime(initialDateTime.year, initialDateTime.month,
            initialDateTime.day, initialDateTime.hour, initialMinute),
        // initialDateTime: initialDateTime,
        onDateTimeChanged: (DateTime newDateTime) {
          if (newDateTime.hour == 23 &&
              newDateTime.minute == 45 &&
              minuteInterval != 1) {
            setState(() {
              minuteInterval = 1;
            });
          } else if (newDateTime.hour != 23 && minuteInterval != 15) {
            setState(() {
              minuteInterval = 15;
            });
          }
        },
        minuteInterval: minuteInterval,
        maximumDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 1, 1, 15),
        use24hFormat: false,
      ),
    );
  }
}
