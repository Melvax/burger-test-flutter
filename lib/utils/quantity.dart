import 'dart:developer';

import 'package:burger/models/burgers.dart';
import 'package:flutter/material.dart';

class CustomQuantity extends StatefulWidget {
  const CustomQuantity({
    Key? key,
    required this.burger,
    required this.ordersRefs,
    required this.burgersSelected,
    required this.addToCart,
    required this.removeInCart,
  }) : super(key: key);
  final BurgerData burger;
  final List ordersRefs;
  final List burgersSelected;

  final Function() addToCart;
  final Function() removeInCart;

  @override
  State<CustomQuantity> createState() => _CustomQuantityState();
}

class _CustomQuantityState extends State<CustomQuantity> {
  Widget showWidget(int qty) {
    if (qty == 0) {
      return TextButton(
        child: const Text(
          'Add Item',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onPressed: () {
          widget.addToCart();
          setState(() {});
        },
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              setState(() {
                widget.removeInCart();
              });
            },
          ),
          Text(qty.toString()),
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () {
              setState(() {
                widget.addToCart();
              });
            },
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    log(widget.burger.ref);
    var foundElements = widget.burgersSelected.where((e) => e == widget.burger);
    (foundElements.length);
    log("occurences top");

    return Card(
      color: Colors.yellow.shade700,
      child: SizedBox(
        height: 50,
        width: 130,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: showWidget(foundElements.length),
        ),
      ),
    );
  }
}
