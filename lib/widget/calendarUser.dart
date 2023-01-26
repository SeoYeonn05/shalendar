import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/color.dart';

class CalendarUsers extends StatelessWidget {
  String name;
  CalendarUsers(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: ColorStyles.themeBlack,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            name,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
