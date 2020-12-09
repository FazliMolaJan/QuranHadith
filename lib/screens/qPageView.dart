import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_hadith/controller/quranAPI.dart';
import 'package:quran_hadith/models/surahModel.dart';
import 'package:quran_hadith/widgets/suratTile.dart';

class QPageView extends StatelessWidget {
  final List<Ayah> ayahList;
  final String suratName;
  final String suratEnglishName;
  final String englishMeaning;
  final int suratNo;

  // final int data;

  const QPageView(
      {Key key,
      this.ayahList,
      // this.data,
      this.suratName,
      this.suratEnglishName,
      this.englishMeaning,
      this.suratNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffeef2f5),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.fromLTRB(20, 10, 15, 10),
                  width: 350,
                  child: FutureBuilder(
                      future: QuranAPI().getSuratList(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (snapshot.connectionState ==
                                ConnectionState.done &&
                            !snapshot.hasData) {
                          return Center(
                              child: Text(
                                  "Connectivity Error! Please Try Again Later :)"));
                        } else if (snapshot.hasData == null) {
                          return Center(
                              child: Text(
                                  "Connectivity Error! Please Check your Internet Connection"));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text(
                            "Something went wrong on our side!\nWe are trying to reconnect :)",
                            textAlign: TextAlign.center,
                          ));
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data.surahs.length,
                            itemBuilder: (context, index) {
                              return SuratTile(
                                colorO: Color(0xffe0f5f0),
                                radius: 8,
                                colorI: Color(0xff01AC68),
                                ayahList: snapshot.data.surahs[index].ayahs,
                                suratNo: snapshot.data.surahs[index].number,
                                // icon: FontAwesomeIcons.heart,
                                revelationType:
                                    snapshot.data.surahs[index].revelationType,
                                englishTrans: snapshot
                                    .data.surahs[index].englishNameTranslation,
                                englishName:
                                    snapshot.data.surahs[index].englishName,
                                // name: snapshot.data.surahs[index].name,
                              );
                            },
                          );
                        } else {
                          return Center(
                              child: Text(
                                  "Connectivity Error! Please Try Again Later"));
                        }
                      }),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 550,
                  child: ListView.custom(
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) => qTile(index),
                      childCount: ayahList.length,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget qTile(int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        title: AutoSizeText(
          "$suratNo:${ayahList[index].number.toString()}",
          style: TextStyle(color: Color(0xff01AC68), height: 1.5),
        ),
        subtitle: AutoSizeText(
          ayahList[index].text,
          textAlign: TextAlign.right,
          style: TextStyle(height: 2.5, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
