// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sambaposapp/constants/constantInit.dart';
import 'package:sambaposapp/models/mainMenuModel.dart';

class ItemCard extends StatelessWidget {
  MainMenuModel selectedMainMenu;
  int index;
  Function function;
  ItemCard({
    Key key,
    this.selectedMainMenu,
    this.index,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .04,
        vertical: size.height * .01,
      ),
      child: Container(
        width: size.width,
        height: size.height * .1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: size.width * .3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    selectedMainMenu.items[index].image,
                  ),
                ),
              ),
            ),
            SizedBox(width: size.width * .02),
            Container(
              width: size.width * .5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    selectedMainMenu.items[index].name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    selectedMainMenu.items[index].price.toString() + ' ₺',
                    style: TextStyle(
                      color: customColors.mainRed,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            InkWell(
              onTap: function,
              child: Container(
                width: size.width * .1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: customColors.mainYellow,
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
