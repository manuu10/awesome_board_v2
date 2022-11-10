// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_board_v2/models/hold.dart';
import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  static const holdsVertical = 18;
  static const holdsHorizontal = 11;

  static const defaultSettings = Settings(
    smartModeInCreateMode: false,
    mustBeDoableInMyLayout: false,
    mustBeDoableInMyLayoutMirrored: false,
    mustIncludeCustomDefinedHolds: false,
    onlyFavorites: false,
    myLayout: [],
    customDefinedHolds: [],
  );

  final bool smartModeInCreateMode;
  final bool mustBeDoableInMyLayout;
  final bool mustBeDoableInMyLayoutMirrored;
  final bool mustIncludeCustomDefinedHolds;

  final bool onlyFavorites;

  final List<Hold> myLayout;
  final List<Hold> customDefinedHolds;
  const Settings({
    required this.smartModeInCreateMode,
    required this.mustBeDoableInMyLayout,
    required this.mustBeDoableInMyLayoutMirrored,
    required this.mustIncludeCustomDefinedHolds,
    required this.onlyFavorites,
    required this.myLayout,
    required this.customDefinedHolds,
  });

  Settings copyWith({
    bool? smartModeInCreateMode,
    bool? mustBeDoableInMyLayout,
    bool? mustBeDoableInMyLayoutMirrored,
    bool? mustIncludeCustomDefinedHolds,
    bool? onlyFavorites,
    List<Hold>? myLayout,
    List<Hold>? customDefinedHolds,
  }) {
    return Settings(
      smartModeInCreateMode:
          smartModeInCreateMode ?? this.smartModeInCreateMode,
      mustBeDoableInMyLayout:
          mustBeDoableInMyLayout ?? this.mustBeDoableInMyLayout,
      mustBeDoableInMyLayoutMirrored:
          mustBeDoableInMyLayoutMirrored ?? this.mustBeDoableInMyLayoutMirrored,
      mustIncludeCustomDefinedHolds:
          mustIncludeCustomDefinedHolds ?? this.mustIncludeCustomDefinedHolds,
      onlyFavorites: onlyFavorites ?? this.onlyFavorites,
      myLayout: myLayout ?? this.myLayout,
      customDefinedHolds: customDefinedHolds ?? this.customDefinedHolds,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      smartModeInCreateMode,
      mustBeDoableInMyLayout,
      mustBeDoableInMyLayoutMirrored,
      mustIncludeCustomDefinedHolds,
      onlyFavorites,
      myLayout,
      customDefinedHolds,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'smartModeInCreateMode': smartModeInCreateMode,
      'mustBeDoableInMyLayout': mustBeDoableInMyLayout,
      'mustBeDoableInMyLayoutMirrored': mustBeDoableInMyLayoutMirrored,
      'mustIncludeCustomDefinedHolds': mustIncludeCustomDefinedHolds,
      'onlyFavorites': onlyFavorites,
      'myLayout': myLayout.map((x) => x.toMap()).toList(),
      'customDefinedHolds': customDefinedHolds.map((x) => x.toMap()).toList(),
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      smartModeInCreateMode: (map['smartModeInCreateMode'] ?? false) as bool,
      mustBeDoableInMyLayout: (map['mustBeDoableInMyLayout'] ?? false) as bool,
      mustBeDoableInMyLayoutMirrored:
          (map['mustBeDoableInMyLayoutMirrored'] ?? false) as bool,
      mustIncludeCustomDefinedHolds:
          (map['mustIncludeCustomDefinedHolds'] ?? false) as bool,
      onlyFavorites: (map['onlyFavorites'] ?? false) as bool,
      myLayout: List<Hold>.from(
        (map['myLayout'] as List<int>).map<Hold>(
          (x) => Hold.fromMap(x as Map<String, dynamic>),
        ),
      ),
      customDefinedHolds: List<Hold>.from(
        (map['customDefinedHolds'] as List<int>).map<Hold>(
          (x) => Hold.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
