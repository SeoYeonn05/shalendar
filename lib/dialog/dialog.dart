import 'package:flutter/material.dart';

Future<bool> dialog(BuildContext context, int type) async {
  String text;
  late String textField;
  if (type == 1) {
    text = "캘린더 이름\n";
  } else {
    text = "참가코드 입력\n";
  }

  return await showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (BuildContext context) => AlertDialog(
        buttonPadding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        content: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 24, 24, 1),
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                  TextField(

                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "테마 설정",
                    style: TextStyle(
                        color: Color.fromARGB(255, 24, 24, 1),
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                ]),
            ),
        actions: <Widget>[
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 55,
              child: Row(
                children: [
                  Flexible(
                      child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(234, 234, 234, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                color: Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                      )),
                  Flexible(
                      child: InkWell(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(240, 120, 5, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Ok",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          if (type == 1) {

                          } else {

                          }
                          Navigator.pop(context, true);
                          Navigator.pop(context, true);
                        },
                      ))
                ],
              ))
        ],
      ));
}
