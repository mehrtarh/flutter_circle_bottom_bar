library animation_circle_bottom_bar;

import 'dart:core';

import 'package:flutter/material.dart';

import 'package:flutter_circle_bottombar/tab_item.dart';
import 'dart:ui' as ui;

import 'package:icon_shadow/icon_shadow.dart';

typedef CircularBottomNavSelectedCallback = Function(int selectedPos);

class CircularBottomNavigation extends StatefulWidget {
  final List<TabItem> tabItems;
  final int selectedPos;
  final double barHeight;
  final Color barBackgroundColor;
  final double circleSize;
  final double circleStrokeWidth;
  final double circleStrokeShadowWidth;
  final double iconsSize;
  final double barShadowSize;
  final double barLineSize;
  final bool barShowLine;
  final Color circleSelectedStrokeColor;
  final Color circleUnSelectedStrokeColor;
  final Color barShadowColor;
  final Color barLineColor;
  final Color circleUnSelectedColor;
  final Color circleSelectedColor;
  final int circlePosition;
  final Duration animationDuration;
  final CircularBottomNavSelectedCallback selectedCallback;
  final CircularBottomNavigationController controller;

  CircularBottomNavigation(this.tabItems,
      {this.selectedPos = 0,
      this.barHeight = 60,
      this.barBackgroundColor = Colors.white,
      this.circleSize = 58,
      this.circleStrokeWidth = 4,
      this.iconsSize = 32,
      this.circleSelectedStrokeColor = Colors.grey,
      this.circleUnSelectedStrokeColor = Colors.grey,
      this.barShadowColor = Colors.grey,
      this.barLineColor = Colors.white,
      this.barShowLine = false,
      this.barLineSize = 2.0,
      this.barShadowSize = 2.0,
      this.circleStrokeShadowWidth = 2.0,
      this.animationDuration = const Duration(milliseconds: 1000),
      this.selectedCallback,
      this.controller,
      this.circleUnSelectedColor,
      this.circleSelectedColor,
      this.circlePosition=0})
      : assert(
            tabItems != null && tabItems.length != 0, "tabItems is required");

  @override
  State<StatefulWidget> createState() => _CircularBottomNavigationState();
}

class _CircularBottomNavigationState extends State<CircularBottomNavigation>
    with TickerProviderStateMixin {
  Curve _animationsCurve = Cubic(0.27, 1.21, .77, 1.09);

  AnimationController itemsController;
  Animation<double> selectedPosAnimation;
  Animation<double> itemsAnimation;

  List<double> _itemsSelectedState;

  int selectedPos;
  int previousSelectedPos;

  CircularBottomNavigationController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller;
      previousSelectedPos = selectedPos = _controller.value;
    } else {
      previousSelectedPos = selectedPos = widget.selectedPos;
      _controller = CircularBottomNavigationController(selectedPos);
    }

    _controller.addListener(_newSelectedPosNotify);

    _itemsSelectedState = List.generate(widget.tabItems.length, (index) {
      return selectedPos == index ? 1.0 : 0.0;
    });

    itemsController = new AnimationController(
        vsync: this, duration: widget.animationDuration);
    itemsController.addListener(() {
      setState(() {
        _itemsSelectedState.asMap().forEach((i, value) {
          if (i == previousSelectedPos) {
            _itemsSelectedState[previousSelectedPos] =
                1.0 - itemsAnimation.value;
          } else if (i == selectedPos) {
            _itemsSelectedState[selectedPos] = itemsAnimation.value;
          } else {
            _itemsSelectedState[i] = 0.0;
          }
        });
      });
    });

    selectedPosAnimation = makeSelectedPosAnimation(
        selectedPos.toDouble(), selectedPos.toDouble());

    itemsAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: itemsController, curve: _animationsCurve));
  }

  Animation<double> makeSelectedPosAnimation(double begin, double end) {
    return Tween(begin: begin, end: end).animate(
        CurvedAnimation(parent: itemsController, curve: _animationsCurve));
  }

  void onSelectedPosAnimate() {
    setState(() {});
  }

  void _newSelectedPosNotify() {
    _setSelectedPos(widget.controller.value);
  }

  @override
  Widget build(BuildContext context) {
    double barLineSize = widget.barLineSize;
    if (!widget.barShowLine) barLineSize = 0;
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = widget
        .barHeight; // + (widget.circleSize / 1) + widget.circleStrokeWidth;
    double sectionsWidth = fullWidth / widget.tabItems.length;

    //Create the boxes Rect
    List<Rect> boxes = List();
    widget.tabItems.asMap().forEach((i, tabItem) {
      double left = i * sectionsWidth;
      double top = barLineSize * 2;
      double right = left + sectionsWidth;
      double bottom = fullHeight;
      boxes.add(Rect.fromLTRB(left, top, right, bottom));
    });

    List<Widget> children = List();

    // This is the full view transparent background (have free space for circle)
    children.add(Container(
      width: fullWidth,
      height: fullHeight + barLineSize,
    ));

    // This is the bar background (bottom section of our view)
    children.add(Positioned(
      child: Container(
        width: fullWidth,
        height: widget.barHeight,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: widget.barBackgroundColor,
            boxShadow: [
              new BoxShadow(
                  color: widget.barShadowColor,
                  blurRadius: widget.barShadowSize)
            ]),
      ),
      top: barLineSize,
      left: 0,
    ));

    double baseLine = fullHeight - widget.circleSize;
    if (baseLine < 0) baseLine = 0;

    // This is the circle handle
    Color circleColor = widget.circlePosition == selectedPos
        ? widget.circleSelectedStrokeColor
        : widget.circleUnSelectedStrokeColor;

    children.add(new Positioned(
      child: Container(
          width: widget.circleSize,
          height: widget.circleSize,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: widget.circleStrokeShadowWidth),
            ],
            shape: BoxShape.circle,
            color: circleColor ,
          )),
      left: (widget.circlePosition * sectionsWidth) +
          (sectionsWidth / 2) -
          (widget.circleSize / 2),
      top: baseLine / 2 + barLineSize,
    ));


    // This is the circle  stroke handle
    Color strokeColor = widget.circlePosition == selectedPos
        ? widget.circleSelectedColor
        : widget.circleUnSelectedColor;

    children.add(new Positioned(
      child: Container(
          width: widget.circleSize - widget.circleStrokeWidth * 2,
          height: widget.circleSize - widget.circleStrokeWidth * 2,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: widget.circleStrokeShadowWidth),
            ],
            shape: BoxShape.circle,
            color: strokeColor,
          )),
      left: (widget.circlePosition * sectionsWidth) +
          (sectionsWidth / 2) -
          (widget.circleSize / 2) +
          widget.circleStrokeWidth,
      top: baseLine / 2 + barLineSize + widget.circleStrokeWidth,
    ));

    if (widget.barShowLine) {
      // This is the line handle
      children.add(new Positioned(
        child: Container(
            width: fullWidth,
            height: barLineSize,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle, color: widget.barLineColor)),
        left: 0,
        top: 0,
      ));
    }

    //Here are the Icons and texts of items
    boxes.asMap().forEach((int pos, Rect r) {
      Color iconColor = pos == selectedPos
          ? widget.tabItems[pos].selectedColor
          : widget.tabItems[pos].normalColor;
      Color color = iconColor;

      bool showShadow;

      if (widget.tabItems[pos].showShadow) {
        if (pos == selectedPos)
          showShadow = true;
        else
          showShadow = false;
      } else
        showShadow = false;

      children.add(Positioned(
        child: IconShadowWidget(
          Icon(widget.tabItems[pos].icon, color: color, size: widget.iconsSize),
          shadowColor: widget.tabItems[pos].shadowColor,
          showShadow: showShadow,
        ),
        left: r.center.dx - (widget.iconsSize / 2),
        top: r.center.dy - (widget.iconsSize / 2),
      ));

      if (pos != selectedPos) {
        children.add(Positioned.fromRect(
          child: GestureDetector(
            onTap: () {
              _controller.value = pos;
            },
          ),
          rect: r,
        ));
      }
    });

    return Stack(
      children: children,
    );
  }

  void _setSelectedPos(int pos) {
    previousSelectedPos = selectedPos;
    selectedPos = pos;

    itemsController.forward(from: 0.0);

    selectedPosAnimation = makeSelectedPosAnimation(
        previousSelectedPos.toDouble(), selectedPos.toDouble());
    selectedPosAnimation.addListener(onSelectedPosAnimate);

    if (widget.selectedCallback != null) {
      widget.selectedCallback(selectedPos);
    }
  }

  @override
  void dispose() {
    super.dispose();
    itemsController.dispose();
    _controller.removeListener(_newSelectedPosNotify);
  }
}

class CircularBottomNavigationController extends ValueNotifier<int> {
  CircularBottomNavigationController(int value) : super(value);
}
