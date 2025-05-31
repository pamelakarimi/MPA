import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mpa/models/content_item_model.dart';


class CarService {
  static Future<List<ContentItem>> loadLocalCarData() async {
    final data = await rootBundle.loadString('assets/data/cars.json');
    final List<dynamic> jsonList = json.decode(data);
    return jsonList.map((json) => ContentItem.fromJson(json)).toList();
  }
}
