// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:sambaposapp/components/itemCard.dart';
import 'package:sambaposapp/constants/constantInit.dart';
import 'package:sambaposapp/models/mainMenuModel.dart';
import 'package:sambaposapp/models/menuItemsModel.dart';

import 'basket.dart';

class MenuDeteails extends StatefulWidget {
  MainMenuModel selectedMainMenu;
  MenuDeteails({
    Key key,
    this.selectedMainMenu,
  }) : super(key: key);

  @override
  _MenuDeteailsState createState() => _MenuDeteailsState();
}

class _MenuDeteailsState extends State<MenuDeteails> {
  void goBasket({MenuItemModel selectedMenuItem}) {
    Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70.withOpacity(.95),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          toolbarHeight: kToolbarHeight,
          title: Text(
            widget.selectedMainMenu.name,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          flexibleSpace: Stack(
            children: [
              Container(
                width: size.width,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    widget.selectedMainMenu.image,
                  ),
                ),
              ),
              Container(
                height: size.height * .12,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(.1),
                      Colors.white70,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .02,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.selectedMainMenu.items.length,
                itemBuilder: (_, listIndex) {
                  return ItemCard(
                    index: listIndex,
                    selectedMainMenu: widget.selectedMainMenu,
                    function: () {
                      goBasket(
                        selectedMenuItem:
                            widget.selectedMainMenu.items[listIndex],
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
