import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/ui/constant/color_pallete.dart';
import 'package:movie/ui/screen/home/home_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [
        HomePage(),
        SizedBox(),
        SizedBox(),
        SizedBox(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon:
              const Icon(Icons.movie), //Image.asset('assets/images/film.png'),
          title: ("Movie"),
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          activeColorSecondary: CupertinoColors.white,
          activeColorPrimary: ColorPallete.colorOrange,
          inactiveColorPrimary: CupertinoColors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset('assets/images/Coupons.png'),
          title: ("Tickets"),
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          activeColorSecondary: CupertinoColors.white,
          activeColorPrimary: ColorPallete.colorOrange,
          inactiveColorPrimary: CupertinoColors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset('assets/images/Bookmark.png'),
          title: ("Favorite"),
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          activeColorSecondary: CupertinoColors.white,
          activeColorPrimary: ColorPallete.colorOrange,
          inactiveColorPrimary: CupertinoColors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset('assets/images/Personnel.png'),
          title: ("Profile"),
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          activeColorSecondary: CupertinoColors.white,
          activeColorPrimary: ColorPallete.colorOrange,
          inactiveColorPrimary: CupertinoColors.white,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      padding: const EdgeInsets.all(2),
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      navBarHeight: kBottomNavigationBarHeight + 20,
      decoration: NavBarDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(
            24,
          ),
        ),
        colorBehindNavBar: ColorPallete.colorPrimary,
        useBackdropFilter: true,
      ),
      backgroundColor: ColorPallete.colorOrange,
      confineToSafeArea: false,
      navBarStyle: NavBarStyle.style7,
    );
  }
}
