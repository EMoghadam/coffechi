import 'package:coffechi2/screens_coustomer/profile_screen_customer.dart';
import 'package:coffechi2/screens_managment/profile_screen_manager.dart';
import 'package:coffechi2/screens_managment/submit_order_manager.dart';
import 'package:coffechi2/screens_managment/table_reservation_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_colors.dart';
import 'cafe_list_screen.dart';
import 'my_orders _screen.dart';

class BaseScreenCostomer extends StatefulWidget {
  const BaseScreenCostomer({super.key});

  @override
  State<BaseScreenCostomer> createState() => _BaseScreenCostomerState();
}

class _BaseScreenCostomerState extends State<BaseScreenCostomer> {
  int selectedBottomNavigationIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black9,
      extendBody: true,
      body: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 65,
        ),
        child: IndexedStack(
          index: selectedBottomNavigationIndex,
          children: getScreens(),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(
                color: AppColors.white.withOpacity(0.8),
                blurRadius: 1,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.tertiary,
            elevation: 0,
            currentIndex: selectedBottomNavigationIndex,
            onTap: (int index) {
              setState(() {
                selectedBottomNavigationIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.secondary,
            unselectedItemColor: AppColors.black5,
            selectedLabelStyle: Theme.of(context).textTheme.bodyLarge,
            unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
            items: [
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Icon(FontAwesomeIcons.userLarge, size: 22),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Icon(FontAwesomeIcons.userLarge, size: 22),
                ),
                label: 'پروفایل',
              ),
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Icon(FontAwesomeIcons.basketShopping, size: 22),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Icon(FontAwesomeIcons.basketShopping, size: 22),
                ),
                label: 'کافه و رستوران',
              ),
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Icon(FontAwesomeIcons.add, size: 22),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Icon(FontAwesomeIcons.add, size: 22),
                ),
                label: 'سفارش ها',
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getScreens() {
    return <Widget>[
      const CustomerProfilePage(),
      const CafeListPage(),
      const MyOrdersPage(),
    ];
  }
}