// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sambaposapp/constants/constantInit.dart';
import 'package:sambaposapp/models/mainMenuModel.dart';
import 'package:sambaposapp/models/menuItemsModel.dart';
import 'package:sambaposapp/models/subItemModel.dart';

class Basket extends StatefulWidget {
  MenuItemModel mainMenu;
  List<SubItemModel> selectedSubs;
  Basket({Key key, this.mainMenu, this.selectedSubs}) : super(key: key);

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  String currentTime;
  double totalPrice;
  TextStyle myTextStyle = TextStyle(fontFamily: 'veteran');

  taketime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat.yMd().add_jm();
    final String formatted = formatter.format(now);
    currentTime = formatted;
    setState(() {});
  }

  fetchTotalPrice({MenuItemModel menuItem, List<SubItemModel> selectedSubs}) {
    double total = menuItem.price;
    if (selectedSubs.isNotEmpty) {
      selectedSubs.forEach((element) {
        total += (element.price ?? 0);
      });
    }
    totalPrice = total;

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    this.taketime();
    fetchTotalPrice(
        menuItem: widget.mainMenu, selectedSubs: widget.selectedSubs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sepet'),
        backgroundColor: customColors.mainYellow,
      ),
      backgroundColor: customColors.cWhite,
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                child: Container(
                  width: size.width,
                  // height: size.height * .6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .07),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * .05,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Bizi tercih ettiğiniz için teşekkür ederiz',
                                style: myTextStyle,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                currentTime,
                                style: myTextStyle,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * .05,
                        ),
                        widget.selectedSubs.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.selectedSubs.length,
                                itemBuilder: (_, basketItemIndex) {
                                  return basketItem(
                                    name: basketItemIndex == 0
                                        ? widget.mainMenu.name
                                        : widget
                                            .selectedSubs[basketItemIndex].name,
                                    price: basketItemIndex == 0
                                        ? widget.mainMenu.price.toString()
                                        : widget
                                            .selectedSubs[basketItemIndex].price
                                            .toString(),
                                  );
                                })
                            : basketItem(
                                name: widget.mainMenu.name,
                                price: widget.mainMenu.price.toString()),
                        SizedBox(
                          height: size.height * .1,
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            Text(
                              'Toplam Tutar: ',
                              style: myTextStyle,
                            ),
                            Spacer(),
                            Text(
                              totalPrice.toString() + ' TL',
                              style: myTextStyle,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: size.height * .05,
                        ),
                        Center(
                          child: Text(
                            'Lütfen fişlerinizi yere atmayınız :)',
                            style: myTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * .05,
            ),
            InkWell(
              onTap: () {
                Fluttertoast.showToast(
                  msg: 'Sepet Onaylandı',
                  backgroundColor: customColors.mainRed,
                );
                Navigator.pop(context);
              },
              child: Container(
                width: size.width * .4,
                height: size.height * .07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: customColors.mainYellow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Onayla',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row basketItem({
    String name,
    String price,
  }) {
    return Row(
      children: [
        Text(
          name,
          style: myTextStyle,
        ),
        Spacer(),
        Text(
          price + ' TL',
          style: myTextStyle,
        )
      ],
    );
  }
}
