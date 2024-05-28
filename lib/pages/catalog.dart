import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        
      });
      print("Выбрана вкладка: ${_tabController.index}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Find the home furniture",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 30.0,
                        fontFamily: 'Hauora'
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 103.0,
                  child: TabBar(
                    controller: _tabController,
                    indicator: const BoxDecoration(),
                    dividerColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    tabs: [
                      _buildTab(0, 'All', '', ''),
                      _buildTab(1, '', 'assets/img/sofa.png', 'assets/img/sofa-selected.png'),
                      _buildTab(2, '', 'assets/img/tv.png', 'assets/img/tv-selected.png'),
                      _buildTab(3, '', 'assets/img/lamp.png', 'assets/img/lamp-selected.png'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          elevation: 0.0,
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            Text('1'),
            Text('2'),
            Text('3'),
            Text('4'),
          ]
        ),
      ),
    );
  }

  Widget _buildTab(int index, String label, String imageAsset, String imageSelectedAsset) {
    bool isSelected = _tabController.index == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: isSelected ? 103 : 81,
      decoration: BoxDecoration(
        color: isSelected ? Color.fromRGBO(121, 147, 174, 1) : Color.fromRGBO(207, 207, 207, 1),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Tab(
        child: Container(
          alignment: Alignment.center,
          child: label.isNotEmpty
              ? Text(label, style: TextStyle(color: isSelected ? Color.fromRGBO(255, 255, 255, 1) : Color.fromRGBO(121, 147, 174, 1)))
              : Image.asset(isSelected ? imageSelectedAsset : imageAsset),
        ),
      ),
    );
  }

}