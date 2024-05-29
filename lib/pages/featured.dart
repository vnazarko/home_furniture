import 'package:flutter/material.dart';
import 'package:home_furniture/components/buttons.dart';
import 'package:home_furniture/components/items.dart';
import 'package:home_furniture/http.dart';
import 'package:home_furniture/models/user_model.dart';
import 'package:provider/provider.dart';

class FeaturedPage extends StatefulWidget {
  const FeaturedPage({super.key});

  @override
  State<FeaturedPage> createState() => _FeaturedPageState();
}

class _FeaturedPageState extends State<FeaturedPage> {

  final ApiService apiService = ApiService(baseUrl: '8a639216091bfca0.mokky.dev');
  late Future<List<Map<String, dynamic>>> products;

  @override
  void initState() {
    super.initState();
    products = apiService.fetchData('products');
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Featured',
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
            fontSize: 30.0,
            fontFamily: 'Hauora'
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data'));
              } else {
                return Column(
                  children: [
                    for (Map<String, dynamic> product in snapshot.data!)
                      for (int feature in user.favorites)
                        if (product['id'] == feature)
                          Column(
                            children: [
                              ItemOfProduct(product: product, user: user),
                              const SizedBox(height: 30.0,)
                            ],
                          )
                  ],
                );
              }
          }
        )
      ),
    );
  }
}

