import 'package:flutter/material.dart';
import 'package:home_furniture/pages/cart.dart';
import 'package:home_furniture/pages/catalog.dart';
import 'package:home_furniture/pages/featured.dart';
import 'package:home_furniture/pages/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    CatalogPage(),
    FeaturedPage(),
    CartPage(),
    ProflilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: AnimatedCrossFade(
                  firstChild: const Icon(
                    Icons.home,
                    color: Color.fromRGBO(121, 147, 174, 1),
                  ),
                  secondChild: const Icon(
                    Icons.home_outlined,
                    color: Color.fromRGBO(121, 147, 174, 1),
                  ),
                  crossFadeState: _selectedIndex == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 300),
                ),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: AnimatedCrossFade(
                  firstChild: const Icon(
                    Icons.favorite,
                    color: Color.fromRGBO(121, 147, 174, 1),
                  ),
                  secondChild: const Icon(
                    Icons.favorite_outline,
                    color: Color.fromRGBO(121, 147, 174, 1),
                  ),
                  crossFadeState: _selectedIndex == 1 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 300),
                ),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: AnimatedCrossFade(
                  firstChild: const Icon(
                    Icons.shopping_cart,
                    color: Color.fromRGBO(121, 147, 174, 1),
                  ),
                  secondChild: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Color.fromRGBO(121, 147, 174, 1),
                  ),
                  crossFadeState: _selectedIndex == 2 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 300),
                ),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: AnimatedCrossFade(
                  firstChild: const Icon(
                    Icons.person,
                    color: Color.fromRGBO(121, 147, 174, 1),
                  ),
                  secondChild: const Icon(
                    Icons.person_outlined,
                    color: Color.fromRGBO(121, 147, 174, 1),
                  ),
                  crossFadeState: _selectedIndex == 3 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 300),
                ),
                label: ' ',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}