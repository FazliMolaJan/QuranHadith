import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:quran_hadith/screens/about.dart';
import 'package:quran_hadith/screens/favorite.dart';
import 'package:quran_hadith/screens/hPage.dart';
import 'package:quran_hadith/screens/qPage.dart';
import 'package:quran_hadith/screens/settings.dart';
import 'package:quran_hadith/widgets/headerTitle.dart';
import 'package:url_launcher/url_launcher.dart';

enum MenuOptions { request, About, donate, report }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> screens = [QPage(), HPage(), Favorite(), Settings()];

  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  GlobalKey btnKey2 = GlobalKey();
  GlobalKey btnKey3 = GlobalKey();

  @override
  void initState() {
    menu = PopupMenu(items: [
      MenuItem(
          title: 'Donate on Patreon',
          image: Icon(Icons.mail, color: Colors.white)),
      MenuItem(
          title: 'Report Bug', image: Icon(Icons.power, color: Colors.white)),
      MenuItem(
          title: 'Feature Request',
          image: Icon(Icons.settings, color: Colors.white)),
      MenuItem(title: 'About', image: Icon(Icons.menu, color: Colors.white))
    ], onClickMenu: onClickMenu, onDismiss: onDismiss, maxColumn: 4);
    super.initState();
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  void customBackground() {
    PopupMenu menu = PopupMenu(
        backgroundColor: Colors.teal,
        lineColor: Colors.tealAccent,
        maxColumn: 2,
        items: [
          MenuItem(title: 'Copy', image: Image.asset('assets/copy.png')),
          MenuItem(
              title: 'Home',
              // textStyle: TextStyle(fontSize: 10.0, color: Colors.tealAccent),
              image: Icon(
                Icons.home,
                color: Colors.white,
              )),
          MenuItem(
              title: 'Mail',
              image: Icon(
                Icons.mail,
                color: Colors.white,
              )),
          MenuItem(
              title: 'Power',
              image: Icon(
                Icons.power,
                color: Colors.white,
              )),
          MenuItem(
              title: 'Setting',
              image: Icon(
                Icons.settings,
                color: Colors.white,
              )),
          MenuItem(
              title: 'PopupMenu',
              image: Icon(
                Icons.menu,
                color: Colors.white,
              ))
        ],
        onClickMenu: (MenuItemProvider item) {

        },
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKey2);
  }

  //eef2f5
  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    double height = MediaQuery.of(context).size.height;
    final searchFocusNode = FocusNode();
    final _searchBox = Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 10, 5),
      child: TextField(
        maxLines: 1,
        // enabled: true,
        focusNode: searchFocusNode,
        style: const TextStyle(fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 10),
          filled: true,
          focusColor: Color(0xffeef2f5),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Color(0xffeef2f5)),
          ),
          suffixIcon: const Icon(FontAwesomeIcons.search, color: Colors.black),
          hintStyle: const TextStyle(fontWeight: FontWeight.w700),
          hintText: '   Search',
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Color(0xffeef2f5)),
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: HeaderText(),
        actions: [
          SizedBox(child: _searchBox, width: 350),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 10,
              width: 43,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffeef2f5)),
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                  key: btnKey2,
                  onPressed: customBackground,
                  icon: Icon(FontAwesomeIcons.headphonesAlt),
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 10,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffeef2f5)),
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                  key: btnKey3,
                  onPressed: customBackground,
                  icon: Icon(FontAwesomeIcons.bell),
                  color: Colors.black),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: height * 0.01, horizontal: 20),
            child: PopupMenuButton(
              elevation: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xff01AC68),
                  borderRadius: BorderRadius.circular(20),
                ),
                child:
                    Text('Support', style: TextStyle(color: Color(0xffdae1e7))),
              ),
              color: Color(0xffeef2f5),
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<MenuOptions>>[
                PopupMenuItem(
                  child: Text('Donate on Patreon'),
                  value: MenuOptions.donate,
                ),
                PopupMenuItem(
                  child: Text('Bug Report'),
                  value: MenuOptions.report,
                ),
                PopupMenuItem(
                  child: Text('Feature Request'),
                  value: MenuOptions.request,
                ),
                PopupMenuItem(child: Text('About'), value: MenuOptions.About),
              ],
              onSelected: (MenuOptions options) {
                switch (options) {
                  case MenuOptions.request:
                    launch(
                        "https://github.com/kherld-hussein/quran_hadith/issues/");
                    break;
                  case MenuOptions.About:
                    showDialog(context: context, builder: (context) => About());
                    break;
                  case MenuOptions.donate:
                    launch("https://www.patreon.com/join/kherld/checkout?ru=undefined");
                    break;
                  case MenuOptions.report:
                    launch(
                        "https://github.com/kherld-hussein/quran_hadith/issues/");
                    break;
                }
              },
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 5.0),
          child: CircleAvatar(
            radius: 60,
            child: IconButton(
                icon: Icon(FontAwesomeIcons.quran), onPressed: () {}),
          ),
        ),
      ),
      body: Row(
        children: [
          NavigationRail(
            destinations: [
              NavigationRailDestination(
                icon: FaIcon(FontAwesomeIcons.bookOpen),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: SizedBox.shrink(),
                ),
              ),
              NavigationRailDestination(
                icon: FaIcon(FontAwesomeIcons.bookReader),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: SizedBox.shrink(),
                ),
              ),
              NavigationRailDestination(
                icon: FaIcon(FontAwesomeIcons.heart),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: SizedBox.shrink(),
                ),
              ),
              NavigationRailDestination(
                icon: FaIcon(FontAwesomeIcons.cog),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox.shrink(),
                ),
              ),
            ],
            selectedIndex: _selectedIndex,
            unselectedIconTheme: IconThemeData(color: Colors.black),
            selectedIconTheme: IconThemeData(color: Color(0xff01AC68)),
            selectedLabelTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.0,
                decoration: TextDecoration.underline),
            unselectedLabelTextStyle: TextStyle(color: Color(0xff01AC68)),
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            // groupAlignment: 1.0,
            labelType: NavigationRailLabelType.all,
            trailing: IconButton(
              tooltip: 'Exit',
              icon: FaIcon(FontAwesomeIcons.signOutAlt),
              onPressed: () => SystemNavigator.pop(animated: true),
            ),
          ),
          Expanded(child: screens[_selectedIndex])
        ],
      ),
    );
  }
}
