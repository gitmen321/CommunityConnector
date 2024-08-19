import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Lottie.asset('assets/animations/Animation - 1707294599861.json',height: 150),
    );
  }
}