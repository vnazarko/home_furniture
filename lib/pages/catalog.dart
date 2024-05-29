
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_furniture/http.dart';
import 'package:home_furniture/models/user_model.dart';
import 'package:provider/provider.dart';


class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final ApiService apiService = ApiService(baseUrl: '8a639216091bfca0.mokky.dev');
  late Future<List<Map<String, dynamic>>> products;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);

    products = apiService.fetchData('products');
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      width: 200.0,
                      child: const Text(
                        "Find the home furniture",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 30.0,
                          fontFamily: 'Hauora'
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 103.0,
                  child: TabBar(
                    onTap: (index) {
                      _tabController.animateTo(index);
                    },
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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data'));
              } else {
                return TabBarView(
                  controller: _tabController,
                  children: [
                    ScrollConfiguration(
                      behavior: MyCustomScrollBehavior(),
                      child: ListView(
                        children: [
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              for (Map product in snapshot.data!)
                                ProductComponent(product: product),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        for (Map product in snapshot.data!)
                          if (product['type'] == 'sofa')
                            ProductComponent(product: product),
                      ],
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        for (Map product in snapshot.data!)
                          if (product['type'] == 'tv')
                            ProductComponent(product: product),
                      ],
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        for (Map product in snapshot.data!)
                          if (product['type'] == 'lamp')
                            ProductComponent(product: product),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
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

class ProductComponent extends StatelessWidget {
  const ProductComponent({
    super.key,
    required this.product,
  });

  final Map product;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    bool isFavorite = user.favorites.contains(product['id']);

    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            spreadRadius: 1.0,
            blurRadius: 10.0,
            offset: Offset(0.0, 0.1),
          ),
        ]
      ),
      width: 162.0,
      height: 251.0,
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160.0,
            child: Stack(
              children: [
                Image.network(
                  product['img'],
                  width: 117.0,
                  height: 117.0,
                ),
                Positioned(
                  left: 112,
                  top: 30,
                  child: AnimatedCrossFade(
                    firstChild: IconButton(
                      onPressed: () {
                        user.addOrRemoveInFavorites(product['id']);
                      },
                      icon:const Icon(Icons.favorite, color: Color.fromRGBO(121, 147, 174, 1)),
                      splashColor: Colors.transparent,
                    ),
                    secondChild: IconButton(
                      onPressed: () {
                        user.addOrRemoveInFavorites(product['id']);
                      },
                      icon:const Icon(Icons.favorite_border, color: Color.fromRGBO(0, 0, 0, 1)),
                      splashColor: Colors.transparent,
                    ),
                    crossFadeState: !isFavorite ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 200),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 11.0),
            child: Text(
              product['name'],
              style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 16.0,
                fontFamily: 'Hauora'
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              for (String color in product['colors'])
                Row(
                  children: [
                    Container(
                      width: 15.0,
                      height: 15.0,
                      decoration: BoxDecoration(
                        color: Color(int.tryParse(color)!),
                        borderRadius: BorderRadius.circular(50.0)
                      ),
                    ),
                    const SizedBox(
                      width: 4.0,
                    )
                  ],
                )
            ],
          ),
          Row(
            children: [
              Text(
                '¥${product['price']}'
              ),
              Expanded(
                child: Container(),
              ),
              AnimatedCrossFade(
                firstChild: IconButton.filled(
                  onPressed: () {
                    user.addOrRemoveInCart(product['id']);
                  }, 
                  icon: const Icon(Icons.remove, color: Colors.white),
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(121, 147, 174, 1))
                  ),
                ),
                secondChild: IconButton.outlined(
                  onPressed: () {
                    user.addOrRemoveInCart(product['id']);
                  }, 
                  icon: const Icon(Icons.add, color: Colors.black),
                  
                ),
                duration: Duration(milliseconds: 200),
                crossFadeState: !user.cart.contains(product['id']) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              )
            ],
          )
        ],
      ),
    );
  }
}

class MyCustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    // Возвращаем дефолтный виджет для обрамления контента внутри области прокрутки
    return child;
  }
}
