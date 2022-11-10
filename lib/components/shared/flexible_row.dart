import 'package:flutter/material.dart';

class FlexibleRow extends StatelessWidget {
  const FlexibleRow({
    Key? key,
    required this.children,
    this.flexValues,
    this.spacing = 10,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);
  final List<Widget> children;
  final List<int>? flexValues;
  final double spacing;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    var moddedChildren = <Widget>[];
    if (flexValues != null) {
      assert(flexValues!.length == children.length);
      for (var i = 0; i < children.length; i++) {
        moddedChildren.add(Expanded(flex: flexValues![i], child: children[i]));
        if (i < children.length - 1) {
          moddedChildren.add(SizedBox(
            width: spacing,
          ));
        }
      }
    } else {
      for (var i = 0; i < children.length; i++) {
        moddedChildren.add(Expanded(flex: 1, child: children[i]));
        if (i < children.length - 1) {
          moddedChildren.add(SizedBox(
            width: spacing,
          ));
        }
      }
    }
    return Padding(
      padding: padding,
      child: Row(
        children: moddedChildren,
      ),
    );
  }
}
