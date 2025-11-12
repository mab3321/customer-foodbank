import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import '/utils/theme_colors.dart';

class DatePickerHorizontal extends StatefulWidget {
  DatePickerHorizontal({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _DatePickerHorizontalState createState() => _DatePickerHorizontalState();
}

class _DatePickerHorizontalState extends State<DatePickerHorizontal> {
  DatePickerController _controller = DatePickerController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      //   color: light_orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: DatePicker(
              DateTime.now(),
              width: 60,
              height: 80,
              controller: _controller,
              initialSelectedDate: DateTime.now(),
              selectionColor: ThemeColors.baseThemeColor,
              selectedTextColor: Colors.white,
              inactiveDates: [
                DateTime.now().add(Duration(days: 3)),
                //  DateTime.now().add(Duration(days: 4)),
                DateTime.now().add(Duration(days: 7))
              ],
              onDateChange: (date) {
                // New date selected
                setState(() {
                  
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
