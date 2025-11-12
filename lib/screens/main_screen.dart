import 'package:flutter/material.dart';
import '/utils/theme_colors.dart';
import '/views/orders_List.dart';
import '/views/profile_page.dart';
import '/views/table_reservations.dart';
import '/views/view_restaurent_page_search.dart';
import 'package:get/get.dart';
import 'package:pandabar/pandabar.dart';
import '/views/home_screen.dart';

/// This is the main application widget.
class MainScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MainScreen> {
  String page = 'Home';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: PandaBar(
        backgroundColor: Colors.white,
        buttonColor: Colors.blueGrey,
        buttonSelectedColor: ThemeColors.baseThemeColor,
        fabIcon: InkWell(
            onTap: () {
              Get.to(ViewRestaurantPageSearch(type: 0));
            },
            child: Icon(
              Icons.search,
              color: Colors.white,
            )),
        fabColors: [ThemeColors.baseThemeColor, ThemeColors.baseThemeColor],
        buttonData: [
          PandaBarButtonData(id: 'Home', icon: Icons.home, title: 'HOME'.tr),
          PandaBarButtonData(
              id: 'Orders',
              icon: Icons.sticky_note_2_sharp,
              title: 'ORDERS'.tr),
          PandaBarButtonData(
              id: 'Reservations',
              icon: Icons.event_note,
              title: "RESERVATIONS".tr),
          PandaBarButtonData(
              id: 'Profile', icon: Icons.person, title: 'PROFILE'.tr),
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        onFabButtonPressed: () {},
      ),
      body: Builder(
        builder: (context) {
          switch (page) {
            case 'Home':
              return HomePage();
            case 'Orders':
              return OrderList();
            case 'Profile':
              return ProfilePage();
            case 'Reservations':
              return TableReservations();
            default:
              return HomePage();
          }
        },
      ),
    );
  }
}
