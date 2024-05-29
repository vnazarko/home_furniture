
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  double _opacityLevelButton = 0.0;
  double _opacityLevelText = 0.0;

  void _changeOpacity() {
    setState(() => _opacityLevelButton = 1.0);
    setState(() => _opacityLevelText = 1.0);
  }
  

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    void _stopAnimation() {
      _changeOpacity();
    }

    Timer(const Duration(milliseconds: 900), _stopAnimation); 

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/bg2.png"), 
              fit: BoxFit.cover,
            )
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 1.0,
                left: 20.0
              ),
              child: Stack( 
                children: [
                  AnimatedOpacity(
                    opacity: _opacityLevelText,
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height - 150)),
                      child: const Text(
                        "Find the best home furniture for your room.",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 28.0,
                          fontFamily: 'Hauora'
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _opacityLevelButton,
                    duration: const Duration(seconds: 1),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.only(right: 20, bottom: 20),
                      child: IconButton.filled(
                        onPressed: () {
                          Navigator.pushNamed(context, '/catalog');
                        }, 
                        icon: const Icon(Icons.chevron_right_rounded, color: Color.fromRGBO(255, 255, 255, 1), weight: 1.0,),
                        style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(Color.fromRGBO(121, 147, 174, 1)),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            )
                          )
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}