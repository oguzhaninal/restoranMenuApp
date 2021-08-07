// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:sambaposapp/constants/constantInit.dart';
import 'package:sambaposapp/models/mainMenuModel.dart';
import 'package:sambaposapp/models/subItemModel.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart';

class MenuServices {
  Future<YamlMap> fetchYamlMenu() async {
    final data = await rootBundle.loadString('assets/menuYaml/menu.yaml');
    return loadYaml(data);
  }

  Future<List<MainMenuModel>> getMainMenuList() async {
    var mapData = await fetchYamlMenu();
    var menuJson = mapData['menus'][0]['items'];
    print(menuJson);
    return List.generate(
        menuJson.length, (index) => MainMenuModel.fromJson(menuJson[index]));
  }

  Future<List<SubItemModel>> getSubMenuWithKey(
      {@required String subMenuKey}) async {
    var mapData = await fetchYamlMenu();
    var subMenuJson = mapData['menus'];
    int subMenuIndex;

    for (var i = 0; i < subMenuJson.length; i++) {
      if (subMenuJson[i]['key'] == subMenuKey) {
        subMenuIndex = i;
      }
    }
    var subMenuJsonDetails = mapData['menus'][subMenuIndex]['items'];
    return List.generate(
        subMenuJsonDetails.length,
        (index) => SubItemModel.fromJson(
            data: subMenuJsonDetails[index],
            subName: mapData['menus'][subMenuIndex]['description'],
            subKeyIndex: subMenuIndex));
  }
}
