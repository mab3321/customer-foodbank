import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/theme/colors.dart';
import '/utils/theme_colors.dart';

class Variation extends StatefulWidget {
  @override
  _VariationState createState() => _VariationState();
}

class _VariationState extends State<Variation> {
  var _value;

  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        //here change to your color
        unselectedWidgetColor: lightOrange,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          right: 15.0,
        ),
        child: Column(
          // crossAxisAlignment:CrossAxisAlignment.start,
          children: <Widget>[
            for (int i = 1; i <= 3; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio(
                          activeColor: ThemeColors.baseThemeColor,
                          value: i,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          }),
                      Text(
                        'FAMILY_PAN'.tr,
                        // style: Theme.of(context).textTheme.subtitle1.copyWith(color: i == 5 ? Colors.black38 : shrineBrown900),
                      ),
                    ],
                  ),
                  Text("\$ 1074"),
                ],
              ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Divider(),
            )
          ],
        ),
      ),
    );
  }
}
