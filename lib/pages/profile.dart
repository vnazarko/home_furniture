import 'package:flutter/material.dart';

class ProflilePage extends StatelessWidget {
  const ProflilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('Ты профиль не видел что-ли?'),
      ),
    );
  }
}