import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dialog/calendar_setting.dart';
import '../theme/color.dart';

class ThemeButton extends StatelessWidget {
  ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            height: 23,
            width: 23,
            child: ElevatedButton(
              onPressed: () {
                color = ColorStyles.themeYellow.value;
              },
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.themeYellow,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            height: 23,
            width: 23,
            child: ElevatedButton(
              onPressed: () {
                color = ColorStyles.themeRed.value;
              },
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.themeRed,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            height: 23,
            width: 23,
            child: ElevatedButton(
              onPressed: () {
                color = ColorStyles.themePink.value;
              },
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.themePink,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            height: 23,
            width: 23,
            child: ElevatedButton(
              onPressed: () {
                color = ColorStyles.themeOrange.value;
              },
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.themeOrange,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            height: 23,
            width: 23,
            child: ElevatedButton(
              onPressed: () {
                color = ColorStyles.themeGreen.value;
              },
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.themeGreen,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            height: 23,
            width: 23,
            child: ElevatedButton(
              onPressed: () {
                color = ColorStyles.themeBlue.value;
              },
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.themeBlue,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            height: 23,
            width: 23,
            child: ElevatedButton(
              onPressed: () {
                color = ColorStyles.themeBlack.value;
              },
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.themeBlack,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
