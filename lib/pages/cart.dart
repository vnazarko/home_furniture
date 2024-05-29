import 'package:flutter/material.dart';
import 'package:home_furniture/components/items.dart';
import 'package:home_furniture/http.dart';
import 'package:home_furniture/models/user_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

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
        title: FutureBuilder(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text(
                'In the Cart: 0',
                style: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 30.0,
                  fontFamily: 'Hauora'
                ),
              );
            } else if (snapshot.hasError) {
              return Text(
                'Error',
                style: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 30.0,
                  fontFamily: 'Hauora'
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text(
                'In the Cart: 0',
                style: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 30.0,
                  fontFamily: 'Hauora'
                ),
              );
            } else {
              num totalPrice = 0;
              for (Map<String, dynamic> product in snapshot.data!) {
                if (user.cart.contains(product['id'])) {
                  totalPrice += product['price'];
                }
              }
              return Text(
                'In the Cart: $totalPrice',
                style: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 30.0,
                  fontFamily: 'Hauora'
                ),
              );
            }
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
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
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> product = snapshot.data![index];
                  if (user.cart.contains(product['id'])) {
                    return Column(
                      children: [
                        ItemOfProduct(product: product, user: user),
                        const SizedBox(height: 30.0,),
                      ],
                    );
                  } else {
                    return SizedBox.shrink(); // Пустой виджет, если товар не в корзине
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
