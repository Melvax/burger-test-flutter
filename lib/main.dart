import 'package:burger/homepage.dart';

import 'package:burger/models/burgers.dart';
import 'package:burger/utils/burger_api.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Burger Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BurgerData currentBurger;
  late List orders = [];
  late List burgersSelected = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchBurgers(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => Homepage(
                    burgers: snapshot.data,
                  ),
                ),
              );
            },
          );
          return Container();
        }
      },
    );
  }
}

class LeftBurgerItem extends StatelessWidget {
  const LeftBurgerItem({
    super.key,
    required this.burger,
    required this.selectBurger,
  });

  final BurgerData burger;
  final Function() selectBurger;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectBurger,
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: burger.thumbnail,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
