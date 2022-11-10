// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_board_v2/components/board/board.dart';
import 'package:awesome_board_v2/components/shared/dimmed_button.dart';
import 'package:awesome_board_v2/components/shared/flexible_row.dart';
import 'package:awesome_board_v2/components/shared/size_offset_wrapper.dart';
import 'package:awesome_board_v2/constants/app_colors.dart';
import 'package:awesome_board_v2/models/hold.dart';
import 'package:awesome_board_v2/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';

class CreateScreen extends HookConsumerWidget {
  const CreateScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedHoldType = useState(HoldType.normal);
    final markedHolds = useState(<Hold>[]);
    final settings = ref.watch(allSettingsProvider);

    final screenWidth = MediaQuery.of(context).size.width;

    final board = Board(
      smartConnect: settings.smartModeInCreateMode,
      holds: markedHolds.value,
      onTapHold: (hold, index) {
        //not yet marked
        if (hold.holdType == HoldType.unknown) {
          markedHolds.value = [
            ...markedHolds.value,
            hold.copyWith(holdType: selectedHoldType.value),
          ];
        } else if (hold.holdType == selectedHoldType.value) {
          markedHolds.value =
              markedHolds.value.where((e) => e != hold).toList();
        } else {
          markedHolds.value = markedHolds.value
              .map((e) =>
                  e == hold ? e.copyWith(holdType: selectedHoldType.value) : e)
              .toList();
        }
      },
    );

    final actions = [
      HoldTypeSelect(
        onChange: (holdType) => selectedHoldType.value = holdType,
        selected: selectedHoldType.value,
      ),
      const SizedBox(height: 8),
      FlexibleRow(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          DimmedButton(
            onPressed: () {},
            icon: const Icon(Ionicons.save_outline),
            child: const Text("Save"),
          ),
          DimmedButton(
            onPressed: () {},
            icon: const Icon(Ionicons.shuffle),
            child: const Text("Random"),
          ),
          DimmedButton(
            onPressed: () {
              markedHolds.value = [];
            },
            icon: const Icon(Icons.clear),
            child: const Text("Clear"),
          ),
        ],
      ),
      ListTile(
        title: const Text("Smart Connect"),
        onTap: () => ref
            .read(allSettingsProvider.notifier)
            .updateSmartModeInCreate(!settings.smartModeInCreateMode),
        trailing: Card(
          color: settings.smartModeInCreateMode ? Colors.greenAccent : null,
          child: AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: settings.smartModeInCreateMode
                  ? const Text(
                      "active",
                      style: TextStyle(color: AppTheme.background),
                    )
                  : const Text("off"),
            ),
          ),
        ),
      )
    ];

    if (screenWidth > Board.maxWidth * 1.5) {
      return FlexibleRow(
        children: [
          SingleChildScrollView(
            child: Center(child: board),
          ),
          Center(
            child: ListView(
              children: actions,
            ),
          ),
        ],
      );
    }

    return ListView(
      children: [
        Align(alignment: Alignment.center, child: board),
        const SizedBox(height: 10),
        ...actions,
        const SizedBox(height: 100),
      ],
    );
  }
}

class HoldTypeSelect extends HookConsumerWidget {
  const HoldTypeSelect({
    super.key,
    required this.onChange,
    required this.selected,
  });
  final void Function(HoldType holdType) onChange;
  final HoldType selected;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetSize = useState(const Size(0, 0));

    final iconStart = Icon(
      selected == HoldType.start ? Ionicons.play : Ionicons.play_outline,
    );
    final iconNormal = Icon(
      selected == HoldType.normal
          ? Ionicons.hand_right
          : Ionicons.hand_right_outline,
    );
    final iconFinish = Icon(
      selected == HoldType.finish ? Ionicons.flag : Ionicons.flag_outline,
    );
    final iconFoot = Icon(
      selected == HoldType.foot
          ? Ionicons.footsteps
          : Ionicons.footsteps_outline,
    );

    final hideText = widgetSize.value.width < 500;

    return SizeOffsetWrapper(
      onSizeChange: (size) {
        widgetSize.value = size;
      },
      child: FlexibleRow(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          DimmedButton(
            color: selected == HoldType.start
                ? AppTheme.startHold
                : AppTheme.startHold.withAlpha(128),
            onPressed: () => onChange(HoldType.start),
            icon: hideText ? null : iconStart,
            child: hideText ? iconStart : const Text("Start"),
          ),
          DimmedButton(
            color: selected == HoldType.normal
                ? AppTheme.normalHold
                : AppTheme.normalHold.withAlpha(128),
            onPressed: () => onChange(HoldType.normal),
            icon: hideText ? null : iconNormal,
            child: hideText ? iconNormal : const Text("Normal"),
          ),
          DimmedButton(
            color: selected == HoldType.finish
                ? AppTheme.finishHold
                : AppTheme.finishHold.withAlpha(128),
            onPressed: () => onChange(HoldType.finish),
            icon: hideText ? null : iconFinish,
            child: hideText ? iconFinish : const Text("Top"),
          ),
          DimmedButton(
            color: selected == HoldType.foot
                ? AppTheme.footHold
                : AppTheme.footHold.withAlpha(128),
            onPressed: () => onChange(HoldType.foot),
            icon: hideText ? null : iconFoot,
            child: hideText ? iconFoot : const Text("Foot"),
          ),
        ],
      ),
    );
  }
}
