// ignore_for_file: prefer_const_constructors, missing_return

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sambaposapp/constants/constantInit.dart';
import 'package:sambaposapp/models/mainMenuModel.dart';
import 'package:sambaposapp/models/menuItemsModel.dart';
import 'package:sambaposapp/view/menuDetails.dart';
import 'package:sambaposapp/view/subDetails.dart';
import 'package:yaml/yaml.dart';

import 'basket.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MenuItemModel selectedMenu;

  void goSubMenu({MenuItemModel mainMenuModel, YamlList subMenu}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SubDeteails(
          subList: subMenu,
          selectedKeyIndex: 0,
          selectedMainMenu: mainMenuModel,
          selectedSubItems: [],
        ),
      ),
    );
  }

  void goBasket({MenuItemModel selectedMenuItem}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Basket(
          mainMenu: selectedMenuItem,
          selectedSubs: [],
        ),
      ),
    );
  }

  void selectMenu({MenuItemModel selectedMainMenu}) {
    if (selectedMainMenu.subMenus != null) {
      goSubMenu(
        subMenu: selectedMainMenu.subMenus,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: FutureBuilder(
        future: menuService.getMainMenuList(),
        builder: (_, AsyncSnapshot<List<MainMenuModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: customColors.mainRed,
              ),
            );
          }
          return ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * .1,
                      vertical: size.height * .01,
                    ),
                    child: Text(
                      'İndirimli Menüler : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: customColors.mainRed,
                      ),
                    ),
                  ),
                  CarouselSlider(
                    items: List.generate(snapshot.data[0].items.length,
                        (sliderIndex) {
                      return InkWell(
                        onTap: () {
                          snapshot.data[0].items[sliderIndex].subMenus != null
                              ? goSubMenu(
                                  subMenu: snapshot
                                      .data[0].items[sliderIndex].subMenus,
                                  mainMenuModel:
                                      snapshot.data[0].items[sliderIndex])
                              : goBasket(
                                  selectedMenuItem:
                                      snapshot.data[0].items[sliderIndex],
                                );
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: size.height * .2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(snapshot
                                      .data[0].items[sliderIndex].image),
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * .3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  end: FractionalOffset.topCenter,
                                  begin: FractionalOffset.bottomCenter,
                                  colors: [
                                    Colors.white.withOpacity(0.0),
                                    Colors.black,
                                  ],
                                  stops: [0, 1],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 5,
                              child: Text(
                                snapshot.data[0].items[sliderIndex].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 5,
                                right: 5,
                                child: CircleAvatar(
                                  backgroundColor: customColors.mainYellow,
                                  radius: size.height * .04,
                                  child: Center(
                                    child: Text(
                                      snapshot.data[0].items[sliderIndex].price
                                              .toString() +
                                          ' ₺',
                                      style: TextStyle(
                                        color: customColors.mainRed,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      );
                    }),
                    options: CarouselOptions(
                      height: size.height * .2,
                      enlargeCenterPage: true,
                      autoPlay: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * .1,
                      vertical: size.height * .01,
                    ),
                    child: Text(
                      'Menüler :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: customColors.mainRed,
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length - 1,
                    itemBuilder: (_, listIndex) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MenuDeteails(
                                selectedMainMenu: snapshot.data[listIndex + 1],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * .004,
                            horizontal: size.width * .05,
                          ),
                          child: Hero(
                            tag: snapshot.data[listIndex + 1].caption,
                            child: Stack(
                              children: [
                                Container(
                                  width: size.width,
                                  height: size.height * .12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: customColors.mainYellow,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        snapshot.data[listIndex + 1].image,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: size.height * .12,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      colors: [
                                        Colors.white.withOpacity(.1),
                                        Colors.grey,
                                      ],
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      snapshot.data[listIndex + 1].name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        fontFamily: 'GowunBatang',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
