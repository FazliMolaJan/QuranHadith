import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quran_hadith/anim/animated.dart';
import 'package:quran_hadith/controller/lastRead.dart';
import 'package:quran_hadith/models/surahModel.dart';
import 'package:quran_hadith/screens/qPageView.dart';
import 'package:quran_hadith/widgets/suratInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuratTile extends StatelessWidget {
  final int suratNo;
  final List<Ayah> ayahList;
  final String englishName;
  final String englishTrans;
  final String name;
  final String revelationType;
  final IconData icon;
  final Color colorI;
  final Color colorO;
  final double radius;

  const SuratTile({
    Key key,
    this.ayahList,
    @required this.suratNo,
    @required this.englishName,
    @required this.englishTrans,
    this.name,
    this.icon,
    this.revelationType,
    this.colorI,
    this.colorO,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        child: ListTile(
          onTap: () async {
            LastReadQ.saveLastRead(
                ayahNo: ayahList.length.toString(), surahName: name);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => QPageView(
                  ayahList: ayahList,
                  suratName: name,
                  suratEnglishName: englishName,
                  englishMeaning: englishTrans,
                  suratNo: suratNo,
                ),
              ),
            );
          },
          onLongPress: () {
            showDialog(
                context: context,
                builder: (context) {
                  return SurahInformation(
                    surahNumber: suratNo,
                    ayahs: ayahList.length,
                    englishName: englishName,
                    arabicName: name,
                    revelationType: revelationType,
                  );
                });
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                label: AutoSizeText(
                  suratNo.toString(),
                  style: TextStyle(color: colorO),
                ),
                backgroundColor: colorI,
              ),
              IconButton(icon: Icon(icon), onPressed: () {})
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                englishName,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              AutoSizeText(
                englishTrans,
                style: TextStyle(
                    color: Color(0xffdae1e7), fontWeight: FontWeight.w300),
              ),
            ],
          ),
          // trailing: AutoSizeText(name),
        ),
      ),
    );
  }
}
