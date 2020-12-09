import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SurahInformation extends StatefulWidget {
  final int surahNumber;
  final String arabicName;
  final String englishName;
  final String englishNameTranslation;
  final int ayahs;
  final String revelationType;

  SurahInformation(
      {this.arabicName,
      this.surahNumber,
      this.ayahs,
      this.englishName,
      this.englishNameTranslation,
      this.revelationType});

  @override
  _SurahInformationState createState() => _SurahInformationState();
}

class _SurahInformationState extends State<SurahInformation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ScaleTransition(
      scale: scaleAnimation,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            width: width * 0.75,
            height: height * 0.37,
            decoration: ShapeDecoration(
                color: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Surat Info",
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.englishName,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    AutoSizeText(
                      widget.arabicName,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                AutoSizeText("Ayahs: ${widget.ayahs}"),
                AutoSizeText("Surah Number: ${widget.surahNumber}"),
                AutoSizeText("Chapter: ${widget.revelationType}"),
                AutoSizeText("Meaning: ${widget.englishNameTranslation}"),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.05,
                  child: FlatButton(
                      color: Color(0xff01AC68),
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
