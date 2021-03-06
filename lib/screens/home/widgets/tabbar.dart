import 'package:badges/badges.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBarItem {
  IconData iconData;
  String text;
  bool badge = false;
  int value;
  CustomBottomAppBarItem({this.iconData, this.text, this.badge, this.value});
}

class CustomBottomAppBar extends StatefulWidget {
  CustomBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  });
  // {
  //   // assert(this.items.length == 2 || this.items.length == 5);
  // }
  final List<CustomBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;

  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => CustomBottomAppBarState();
}

class CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    // items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  // Widget _buildMiddleTabItem() {
  //   return Expanded(
  //     child: SizedBox(
  //       height: widget.height,
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           SizedBox(height: widget.iconSize),
  //           Text(
  //             widget.centerItemText ?? '',
  //             style: TextStyle(color: widget.color),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildTabItem({
    CustomBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                item.badge
                    ?
                    // ? Stack(children: <Widget>[
                    Badge(
                        elevation: 0,
                        padding: EdgeInsets.all(3.0),
                        shape: BadgeShape.square,
                        borderRadius: BorderRadius.circular(8),
                        badgeContent: SizedBox(
                          height: 12,
                          child: Text(
                            item.value.toString(),
                            style: TextStyle(color: textwhite, fontSize: 10.0),
                          ),
                        ),
                        child: Icon(item.iconData,
                            color: color, size: widget.iconSize))
                    :
                    // new Positioned(
                    //   // draw a red marble
                    //   top: 0.0,
                    //   right: 0.0,
                    //   child: new CircleAvatar(
                    //     radius: 6.5,
                    //     backgroundColor: Colors.red,
                    //     child: Text(
                    //       item.value.toString(),
                    //       style:
                    //           TextStyle(color: textwhite, fontSize: 12.0),
                    //     ),
                    //   ),
                    // ),
                    // ])
                    Icon(item.iconData, color: color, size: widget.iconSize),
                Text(
                  item.text,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
