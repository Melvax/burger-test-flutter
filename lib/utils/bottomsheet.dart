import 'dart:ui';

import 'package:flutter/material.dart';

Future<void> buildGenericBottomSheet(context, build,
    {bool? isSingleScroll, bool isBlack = false, bool scrollWhenKeyboard = false, bool? useRootNavigator}) async {
  return await showModalBottomSheet(
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            32.0,
            MediaQuery.of(context).size.height * 0.04,
            32.0,
            scrollWhenKeyboard
                ? MediaQuery.of(context).viewInsets.bottom + 32
                : MediaQuery.of(context).size.height * 0.04,
          ),
          decoration: BoxDecoration(
            color: isBlack ? Colors.black : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 20,
                spreadRadius: 15,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: build,
        ),
      ),
    ),
    context: context,
    elevation: 0,
    barrierColor: Colors.white.withOpacity(0.3),
    isScrollControlled: true,
    useRootNavigator: useRootNavigator ?? true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
  );
}

Future<void> buildProductBottomSheet(context, build, {bool? useRootNavigator}) async {
  return await showModalBottomSheet(
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: build,
    ),
    context: context,
    elevation: 0,
    barrierColor: Colors.white.withOpacity(0.3),
    isScrollControlled: true,
    useRootNavigator: useRootNavigator ?? true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
  );
}
