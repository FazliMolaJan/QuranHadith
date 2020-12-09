import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_hadith/widgets/headerTitle.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Center(
          child: Card(
            elevation: 10,
            child: Container(
              height: 500,
              width: 500,
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
              child: AboutView(),
            ),
          ),
        ),
      ),
    );
  }
}

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: "Qur’ān Hadith"),
    Tab(text: "Authors"),
    Tab(text: "Licenses")
  ];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.timesCircle),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
        backgroundColor: Color(0xffdae1e7),
        title: Text("About Qur’ān Hadith"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.black,
          labelColor: Colors.white,
          indicator: BubbleTabIndicator(
            indicatorHeight: 25.0,
            indicatorColor: Color(0xff01AC68),
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: tabs,
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(),
                Text('Version: 1.0.2020', style: TextStyle(fontSize: 20)),
                Text(
                  'Qur’ān Hadith is an Online reader with fashion interface, smooth performance and more features. '
                  'It sharpens your focus on what you are reading or listening\n\nPlease consider donating',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  child: Row(
                    children: [
                      Chip(label: Text("Name")),
                      Chip(label: Text("Email")),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Khalid Hussein ',
                    style: TextStyle(fontSize: 20),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  trailing: Text(
                    'kherld@protonmail.com',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                Text(
                  "Qur’ān Hadith is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by "
                  "the Free Software Foundation, either version 3 of the License, or (at your option) any later version. \n\nQur’ān Hadith is distributed in the hope that it will be useful In Sha Allah, "
                  "You should have received a copy of the GNU General Public License along with this program. \nIf not, see",
                  style: TextStyle(fontSize: 20),
                ),
                InkWell(
                  child: Text(
                    "http://www.gnu.org/licenses/",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () => launch("http://www.gnu.org/licenses/"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
