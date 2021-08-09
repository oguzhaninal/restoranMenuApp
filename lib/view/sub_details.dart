import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sambaposapp/components/transition.dart';
import 'package:sambaposapp/constants/constantInit.dart';
import 'package:sambaposapp/models/mainMenuModel.dart';
import 'package:sambaposapp/models/menuItemsModel.dart';
import 'package:sambaposapp/models/subItemModel.dart';
import 'package:sambaposapp/view/basket.dart';
import 'package:yaml/yaml.dart';

class SubDeteails extends StatefulWidget {
  final YamlList subList;
  final MenuItemModel selectedMainMenu;
  int selectedKeyIndex;
  List<SubItemModel> selectedSubItems = [];

  SubDeteails({
    Key key,
    this.subList,
    this.selectedKeyIndex,
    this.selectedSubItems,
    this.selectedMainMenu,
  }) : super(key: key);

  @override
  _SubDeteailsState createState() => _SubDeteailsState();
}

class _SubDeteailsState extends State<SubDeteails> {
  void nextSub({SubItemModel subItemModel}) {
    if (widget.selectedKeyIndex != (widget.subList.length - 1)) {
      widget.selectedKeyIndex += 1;
      widget.selectedSubItems.add(subItemModel);
      Navigator.pop(context);
      Navigator.push(
        context,
        SlideTransition1(
          SubDeteails(
            selectedKeyIndex: widget.selectedKeyIndex,
            subList: widget.subList,
            selectedSubItems: widget.selectedSubItems,
            selectedMainMenu: widget.selectedMainMenu,
          ),
        ),
      );
    } else {
      widget.selectedSubItems.add(subItemModel);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Basket(
            mainMenu: widget.selectedMainMenu,
            selectedSubs: widget.selectedSubItems,
          ),
        ),
      );
    }
  }

  Future<void> showOptions({
    List<SubItemModel> options,
    int optionIndex,
    Size size,
  }) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: const Text('Seçenekler'),
        actions: List.generate(
          options.length,
          (index) => Material(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                nextSub(subItemModel: options[index]);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .04),
                child: Container(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        width: size.width * .2,
                        height: size.height * .08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(options[index].image)),
                        ),
                      ),
                      SizedBox(width: size.width * .05),
                      Text(
                        options[index].name,
                        style: const TextStyle(
                          fontFamily: 'GowunBatang',
                        ),
                      ),
                      const Spacer(),
                      Text(
                        options[index].price == 0
                            ? 'Ücretsiz'
                            : options[index].price.toString() + ' ₺',
                        style: TextStyle(
                          color: customColors.mainRed,
                          fontFamily: 'GowunBatang',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: menuService.getSubMenuWithKey(
            subMenuKey: widget.subList[widget.selectedKeyIndex]),
        builder: (_, AsyncSnapshot<List<SubItemModel>> snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(
                  snapshot.error,
                ),
              ),
            );
          } else if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(customColors.mainRed),
                ),
              ),
            );
          }
          return Scaffold(
            backgroundColor: customColors.cWhite,
            appBar: AppBar(
              title: Text(snapshot.data[widget.selectedKeyIndex].subMenuName),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, listIndex) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
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
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        snapshot.data[listIndex].image,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.width * .02),
                                SizedBox(
                                  width: size.width * .5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        snapshot.data[listIndex].name ??
                                            'İstemiyorum',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[listIndex].price == null
                                            ? 'Ürün Seçiniz'
                                            : snapshot.data[listIndex].price ==
                                                    0
                                                ? 'Ücretsiz'
                                                : snapshot.data[listIndex].price
                                                        .toString() +
                                                    ' ₺',
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: customColors.mainRed,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () => snapshot
                                          .data[listIndex].items.isNotEmpty
                                      ? showOptions(
                                          options:
                                              snapshot.data[listIndex].items,
                                          optionIndex: listIndex,
                                          size: size)
                                      : nextSub(
                                          subItemModel:
                                              snapshot.data[listIndex],
                                        ),
                                  child: Container(
                                    width: size.width * .1,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                      color: customColors.mainYellow,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        snapshot.data[listIndex].items
                                                .isNotEmpty
                                            ? Icons.sort
                                            : widget.selectedKeyIndex !=
                                                    widget.subList.length - 1
                                                ? Icons.add
                                                : Icons.arrow_right,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          );
        });
  }
}
