import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quran_hadith/anim/particle_canvas.dart';
import 'package:quran_hadith/controller/lastRead.dart';
import 'package:quran_hadith/controller/quranAPI.dart';
import 'package:quran_hadith/widgets/suratTile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QPage extends StatefulWidget {
  @override
  _QPageState createState() => _QPageState();
}

class _QPageState extends State<QPage> {
  //   @override
  // void initState() {
  //   LastReadQ.getLastRead();
  //   getData();
  //   super.initState();
  // }
  //      getData()async {
  //       final SharedPreferences pref =await SharedPreferences.getInstance();
  //        String ayahNo = await pref.getString('savedDataKey');
  //        String surahName = await pref.getString('savedDataKey');
  //       }

  @override
  Widget build(BuildContext context) {
    var quranAPI = Provider.of<QuranAPI>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xffeef2f5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              width: MediaQuery.of(context).size.width - 320,
              child: FutureBuilder(
                  future: quranAPI.getSuratList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: ParticleCanvas(
                              height: size.height, width: size.width));
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
                      return GridView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 40.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: snapshot.data.surahs.length,
                        itemBuilder: (context, index) {
                          return SuratTile(
                            colorO: Color(0xff01AC68),
                            colorI: Color(0xffe0f5f0),
                            radius: 20,
                            ayahList: snapshot.data.surahs[index].ayahs,
                            suratNo: snapshot.data.surahs[index].number,
                            icon: FontAwesomeIcons.heart,
                            revelationType:
                                snapshot.data.surahs[index].revelationType,
                            englishTrans: snapshot
                                .data.surahs[index].englishNameTranslation,
                            englishName:
                                snapshot.data.surahs[index].englishName,
                            name: snapshot.data.surahs[index].name,
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
              width: 200,
              child: ListView(
                children: [
                  ListTile(
                    title: Text(
                      'LAST READ',
                      style: TextStyle(color: Color(0xff01AC68)),
                    ),
                    // hoverColor: Colors.green,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    subtitle: Column(
                      children: [Text("AL FATIHA"), Text('Ayah no. 3')],
                    ),
                    trailing: IconButton(
                      icon: FaIcon(FontAwesomeIcons.book),
                      onPressed: () {},
                    ),
                  ),
                  Divider(height: 65, endIndent: 35, indent: 35),
                  ListTile(
                    title: Text(
                      'LAST LISTENED',
                      style: TextStyle(color: Color(0xff01AC68)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    subtitle: Column(
                      children: [Text('AL FATIHA'), Text('Ayah no. 3')],
                    ),
                    trailing: IconButton(
                      icon: FaIcon(FontAwesomeIcons.headphonesAlt),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    // height: 100,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: Color(0xff01AC68),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AYAH OF THE DAY',
                            style: TextStyle(color: Color(0xffdae1e7))),
                        SizedBox(height: 10),
                        Text(
                          'It is Allah who erected the heavens without pillars that you[can] see; '
                          'then He established Himself above the Throne ...',
                          style: TextStyle(
                              color: Color(0xffdae1e7), letterSpacing: 2),
                        ),
                        Divider(height: 65, endIndent: 30, indent: 30),
                        Text('Read now',
                            style: TextStyle(color: Color(0xffdae1e7))),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
