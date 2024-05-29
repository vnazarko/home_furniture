import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_furniture/models/user_model.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.user,
    required this.product,
  });

  final UserModel user;
  final Map product;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
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
      crossFadeState: !user.favorites.contains(product['id']) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }
}

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    required this.user,
    required this.product,
  });

  final UserModel user;
  final Map product;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
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
      duration: const Duration(milliseconds: 200),
      crossFadeState: !user.cart.contains(product['id']) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}

class BigCartButton extends StatelessWidget {
  const BigCartButton({
    super.key,
    required this.user,
    required this.product,
  });

  final UserModel user;
  final Map product;
  

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: ElevatedButton(
        onPressed: () {
          user.addOrRemoveInCart(product['id']);
        }, 
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15.0, horizontal: 38.0)),
          backgroundColor: const MaterialStatePropertyAll(Color.fromRGBO(121, 147, 174, 1)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            )
          ),
        ),
        child: const Text(
          'In the cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            fontFamily: 'Hauora'
          ),
        ),
      ),
      secondChild: OutlinedButton(
        onPressed: () {
          user.addOrRemoveInCart(product['id']);
        }, 
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15.0, horizontal: 38.0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            )
          ),
        ),
        child: const Text(
          'Add to cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            fontFamily: 'Hauora'
          ),
        ),
      ),
      duration: const Duration(milliseconds: 500),
      crossFadeState: !user.cart.contains(product['id']) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}