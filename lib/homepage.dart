import 'dart:developer';

import 'package:burger/main.dart';
import 'package:burger/models/burgers.dart';
import 'package:burger/utils/bottomsheet.dart';
import 'package:burger/utils/colors.dart';
import 'package:burger/utils/quantity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
    required this.burgers,
  }) : super(key: key);

  final List<BurgerData> burgers;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late BurgerData currentBurger;
  late List orders = [];
  late List burgersSelected = [];

  void _toCart() {
    buildGenericBottomSheet(
        context,
        Container(
          height: 350,
          child: Container(),
        ));
  }

  selectCurrentBurger(BurgerData selected) {
    log("selectcurrentburger");
    log(selected.ref);
    setState(() {
      currentBurger = selected;
    });
    // return currentBurger;
  }

  addToCart() {
    orders.add(currentBurger.ref);
    burgersSelected.add(currentBurger);
    setState(() {});
    // return currentBurger;
  }

  removeInCart() {
    print("removeinCart");
    orders.remove(currentBurger.ref);
    burgersSelected.remove(currentBurger);
    print(burgersSelected);

    setState(() {});
    // return currentBurger;
  }

  @override
  void initState() {
    super.initState();
    currentBurger = widget.burgers[0];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var f = NumberFormat("####,##", "en");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(children: [
                    ...widget.burgers.map(
                      (item) => LeftBurgerItem(
                        burger: item,
                        selectBurger: () => selectCurrentBurger(item),
                      ),
                    )
                  ]),
                ),
              ),
              Expanded(
                flex: 8,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        CachedNetworkImage(
                          imageUrl: currentBurger.thumbnail,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Wrap(
                          children: [
                            Text(
                              currentBurger.title,
                              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          f.format(currentBurger.price),
                          style: TextStyle(color: AppColor.main2, fontSize: 45),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          currentBurger.description,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomQuantity(
                          burger: currentBurger,
                          ordersRefs: orders,
                          burgersSelected: burgersSelected,
                          addToCart: addToCart,
                          removeInCart: removeInCart,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toCart,
        tooltip: 'cart',
        child: const Icon(Icons.shopping_bag_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
