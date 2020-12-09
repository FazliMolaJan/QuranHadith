import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: 'Qur’ān ',
            style: TextStyle(
                fontFamily: 'Philosopher',
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w900,
                letterSpacing: 3),
            children: <TextSpan>[
              TextSpan(
                  text: 'Hadith',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black12,
                      fontFamily: 'Philosopher',
                      fontWeight: FontWeight.w300,
                      letterSpacing: 3)),
            ],
          ),
        )
      ],
    );
  }
}
