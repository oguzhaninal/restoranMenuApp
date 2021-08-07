// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

class SubItemModel {
  final String name, image, subMenuName, caption;
  final int subKeyIndex;
  final double price;
  final List<SubItemModel> items;

  SubItemModel({
    Key key,
    @required this.name,
    @required this.price,
    @required this.subKeyIndex,
    @required this.items,
    @required this.image,
    @required this.caption,
    @required this.subMenuName,
  });

  factory SubItemModel.fromJson(
      {YamlMap data, String subName, int subKeyIndex}) {
    var tempImagePath = data['image'].toString();
    var imagePath = 'assets${tempImagePath.substring(1, tempImagePath.length)}';
    return SubItemModel(
      subMenuName: subName,
      name: data['name'],
      subKeyIndex: subKeyIndex,
      items: data['items'] != null
          ? List.generate(
              data['items'].length,
              (index) => SubItemModel.fromJson(
                  data: data['items'][index],
                  subName: subName,
                  subKeyIndex: subKeyIndex))
          : [],
      caption: data['caption'],
      price: data['price'] != null
          ? double.parse(data['price'].toString().replaceAll(',', '.'))
          : data['items'] != null
              ? null
              : 0.0,
      image: imagePath,
    );
  }
}
