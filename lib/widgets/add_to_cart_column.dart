import 'package:flutter/material.dart';
import '/utils/theme_colors.dart';

class AddToCartColumn extends StatefulWidget {
  final qty;
  const AddToCartColumn({required this.qty});

  @override
  _AddToCartColumnState createState() => _AddToCartColumnState();
}

class _AddToCartColumnState extends State<AddToCartColumn> {
  var mainHeight, mainWidth;
  var cartValue = 0;

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Container(
      width: mainWidth / 3,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.remove_circle,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                if (cartValue > 0) cartValue--;
              });
            },
          ),
          Text(
            '${cartValue + widget.qty}',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                cartValue++;
              });
            },
            icon: Icon(
              Icons.add_circle,
              color: ThemeColors.baseThemeColor,
            ),
          ),
        ],
      ),
    );
  }
}
