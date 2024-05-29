import 'package:flutter/material.dart';
import 'package:home_furniture/components/buttons.dart';
import 'package:home_furniture/models/user_model.dart';

class ItemOfProduct extends StatelessWidget {
  const ItemOfProduct({
    super.key,
    required this.product,
    required this.user,
  });

  final Map<String, dynamic> product;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: Colors.white,
        boxShadow: [BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          spreadRadius: 1.0,
          blurRadius: 10.0,
          offset: Offset(0.0, 0.1),
        )]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            product['img'],
            width: 100.0,
            height: 100.0,
          ),
          Column(
            children: [
              Text(
                product['name'],
                style: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 28.0,
                  fontFamily: 'Hauora'
                ),
              ),
              Text(
                '¥${product['price']}',
                style: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 20.0,
                  fontFamily: 'Hauora'
                )
              )
            ],
          ),
          Column(
            children: [
              FavoriteButton(user: user, product: product),
              CartButton(user: user, product: product)
            ],
          )
        ],
      ),
    );
  }
}