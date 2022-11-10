import "dart:math" as math;

import 'package:awesome_board_v2/components/board/custom_hull_painter.dart';
import 'package:awesome_board_v2/components/board/default_circle_painter.dart';
import 'package:awesome_board_v2/components/shared/size_offset_wrapper.dart';
import 'package:awesome_board_v2/constants/app_colors.dart';
import 'package:awesome_board_v2/models/hold.dart';
import 'package:awesome_board_v2/models/settings.dart';
import 'package:awesome_board_v2/provider/asset_provider.dart';
import 'package:awesome_board_v2/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Board extends HookWidget {
  const Board(
      {Key? key,
      this.holds = const [],
      this.onTapHold,
      this.mirror = false,
      this.smartConnect = false,
      this.holdBuilder})
      : super(key: key);

  final List<Hold> holds;
  final bool mirror;
  final bool smartConnect;
  final void Function(Hold hold, int index)? onTapHold;
  final Widget Function(BuildContext context, Hold? hold, int oneDimIndex)?
      holdBuilder;

  static const _holdsVert = Settings.holdsVertical;
  static const _holdsHori = Settings.holdsHorizontal;

  static const maxWidth = 500.0;

  @override
  Widget build(BuildContext context) {
    final widgetSize = useState(const Size(0, 0));
    final padding = EdgeInsets.only(
      top: (widgetSize.value.height / 16.8),
      left: (widgetSize.value.width / 9.5),
      right: (widgetSize.value.width / 21.5),
      bottom: (widgetSize.value.height / 26),
    );
    return Stack(
      children: [
        SizeOffsetWrapper(
          onSizeChange: (size) {
            widgetSize.value = size;
          },
          child: Container(
            padding: padding,
            constraints: const BoxConstraints(
              maxWidth: maxWidth * 1.2,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetProvider.customBoard,
                fit: BoxFit.cover,
              ),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              clipBehavior: Clip.none,
              itemCount: (_holdsHori * _holdsVert).toInt(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _holdsHori.toInt(),
              ),
              itemBuilder: (context, index) {
                List<Hold> newHolds = mirror ? holds.mirrorHolds() : holds;
                final currentPoint = Utils.convert1DTo2D(index, _holdsHori);
                int hIn =
                    newHolds.indexWhere((e) => e.location == currentPoint);
                Hold? holdFound = hIn != -1 ? newHolds[hIn] : null;
                if (holdBuilder != null) {
                  return holdBuilder!(context, holdFound, index);
                }

                Color outlineColor = Colors.transparent;
                var connectedConfig = const ConnectedToConfig();
                if (holdFound != null) {
                  outlineColor = AppTheme.colorForHoldType(holdFound.holdType);
                  if (smartConnect) {
                    bool top = false;
                    bool bottom = false;
                    bool right = false;
                    bool left = false;
                    for (var hold in holds) {
                      if (top && bottom && left && right) break;
                      if (holdFound.holdType != hold.holdType) continue;
                      if (!top) {
                        top = holdFound.location.abovePoint == hold.location;
                      }
                      if (!bottom) {
                        bottom = holdFound.location.belowPoint == hold.location;
                      }
                      if (!left) {
                        left = holdFound.location.leftPoint == hold.location;
                      }
                      if (!right) {
                        right = holdFound.location.rightPoint == hold.location;
                      }
                    }
                    connectedConfig = ConnectedToConfig(
                      top: top,
                      bottom: bottom,
                      left: left,
                      right: right,
                    );
                  }
                }

                return GestureDetector(
                  onTap: onTapHold == null
                      ? null
                      : () => onTapHold!(
                          holdFound ??
                              Hold(
                                location: currentPoint,
                                holdType: HoldType.unknown,
                              ),
                          index),
                  child: smartConnect
                      ? CustomPaint(
                          painter: CustomHullPainter(
                            outlineColor,
                            config: connectedConfig,
                          ),
                        )
                      : AnimatedCircle(outlineColor),
                );
              },
            ),
          ),
        ),
        if (mirror)
          Positioned(
            top: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Transform(
                alignment: Alignment.topCenter,
                transform: Matrix4.rotationY(math.pi),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: AppTheme.mirrorColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
