import 'package:flutter/material.dart';
import 'package:home_furniture/components/buttons.dart';
import 'package:home_furniture/models/user_model.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> product = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final user = Provider.of<UserModel>(context);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FavoriteButton(user: user, product: product),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: Image.network(
                product['img'],
                width: 287.0,
                height: 287.0,
                fit: BoxFit.cover,
              )
            ),
            const SizedBox(height: 21.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product['name'],
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontFamily: 'Hauora'
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(231, 231, 231, 0.3),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity -= 1;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove, color: Colors.black,)
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'SF Pro Display'
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      IconButton(
                        onPressed: () {
                          if (quantity < 20) {
                            setState(() {
                              quantity += 1;
                            });
                          }
                        },
                        icon: const Icon(Icons.add, color: Colors.black,)
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14.0,),
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
            const SizedBox(height: 14.0),
            Text(
              product['description'],
              style: const TextStyle(
                fontSize: 14.0,
                fontFamily: 'Hauora',
                fontWeight: FontWeight.w500,
                letterSpacing: 1.8,
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '¥${product['price'] * quantity}',
                  style: const TextStyle(
                    fontFamily: 'Hauora',
                    fontSize: 24.0
                  ),
                ),
                BigCartButton(user: user, product: product)
              ]
            )
          ],
        ),
      ),
    );
  }
}