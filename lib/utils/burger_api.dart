import 'dart:developer';

import 'package:burger/models/burgers.dart';
import 'package:http/http.dart' as http;

Future<dynamic> fetchBurgers() async {
  Uri uri = Uri.parse('https://uad.io/bigburger/');
  http.Response response = await http.get(uri);
  log(response.statusCode.toString());

  if (response.statusCode == 200) {
    var burgerList = burgerDataFromJson(response.body);
    log(burgerList[0].price.toString());

    return burgerList;
  } else {
    Future.delayed(const Duration(seconds: 3), () {
      log("refetching");
      fetchBurgers();
    });
  }
  throw Error.safeToString('infiniteload : Error loading search products');
}
