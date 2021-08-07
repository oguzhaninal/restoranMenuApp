// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import 'menuItemsModel.dart';

class MainMenuModel {
  final String name, caption, image;
  final List<MenuItemModel> items;

  MainMenuModel(
      {Key key,
      @required this.name,
      @required this.caption,
      @required this.image,
      @required this.items});

  factory MainMenuModel.fromJson(YamlMap data) {
    var defaultImagePath = data['image'].toString();
    var imagePath =
        'assets${defaultImagePath.substring(1, defaultImagePath.length)}';
    return MainMenuModel(
        name: data['name'],
        caption: data['caption'],
        image: imagePath,
        items: List.generate(data['items'].length,
            (index) => MenuItemModel.fromJson(data['items'][index])));
  }
}
