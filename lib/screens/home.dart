import 'package:ask_enzo_app/data/configurazione.dart';
import 'package:ask_enzo_app/models/tourist.dart';

import 'package:ask_enzo_app/providers/users_provider.dart';
import 'package:ask_enzo_app/screens/Forms/login_screen.dart';
import 'package:ask_enzo_app/screens/Profiles/user_home_profile.dart';
import 'package:ask_enzo_app/widgets/AppBar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:ask_enzo_app/screens/contenuti.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ask_enzo_app/widgets/Drawer/custom_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ask_enzo_app/providers/navigation_service.dart';

bool kfirstRun = true;
/// The `HomePage` class is a stateful widget that extends `ConsumerStatefulWidget` and has an optional
/// `index` property.

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
    this.index,
  });
  final int? index;
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

/// The `_HomePageState` class is a stateful widget that represents the home page of an app with a
/// bottom navigation bar and different content based on the selected index.
class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index == null ? _selectedIndex : widget.index!;
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = ref.watch(userProvider)[0] != null;
    Tourist? user = ref.watch(userProvider)[0];

    Future<void> refresh() async {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {});
    }

    List<Widget> bottomBarPages = <Widget>[
      const ScreenContenuti(),
      isLoggedIn
          ? UserHomeProfile(
              user: user!,
            )
          : const LoginScreen(),
    ];

    void _onItemTapped(int index) {
      setState(() {
        if (index == 0) {
          routeNames.last = contenutiRoute;
        } else {
          routeNames.last = loginRoute;
        }
        if (!isLoggedIn && index == 1) {
          ref.read(navigationProvider.notifier).push(loginRoute);
        }
        _selectedIndex = index;
      });
    }

    return WillPopScope(
      onWillPop: () async {
        final navigationNotifier = ref.read(navigationProvider.notifier);
        if (!navigationNotifier.navigatorKey.currentState!.canPop()) {
          if (_selectedIndex == 0) {
            return navigationNotifier.showExitConfirmationDialog();
          } else {
            setState(() {
              _selectedIndex = 0;
            });
            return false;
          }
        }

        navigationNotifier.pop();
        return false;
      },
      child: RefreshIndicator(
        onRefresh: refresh,
        child: Scaffold(
          appBar: _selectedIndex == 1 //&& !isLoggedIn
              ? const CustomAppBar(
                  title: '',
                  useLogo: true,
                )
              : const CustomAppBar(
                  title: 'Ask Enzo',
                  useLogo: true,
                ),
          endDrawer: const CustomDrawer(),
          body: bottomBarPages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle:
                const TextStyle(fontFamily: Configurazione.fontFamilyBody),
            backgroundColor: const Color.fromARGB(255, 240, 244, 247),
            iconSize: 20,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              isLoggedIn
                  ? const BottomNavigationBarItem(
                      icon: Icon(
                        FontAwesomeIcons.personHiking,
                      ),
                      label: 'Your Profile',
                    )
                  : const BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.arrowRightToBracket),
                      label: 'LogIn',
                    ),
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: const Color.fromARGB(255, 95, 95, 95),
            selectedItemColor: const Color.fromARGB(255, 51, 133, 255),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
