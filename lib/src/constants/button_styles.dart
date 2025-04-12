import 'package:flutter/material.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';

final ButtonStyle kEasyButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppTheme.correctColor,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
);

final ButtonStyle kMediumButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppTheme.accentColor,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
);

final ButtonStyle kHardButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppTheme.wrongColor,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
);

// Button styles
final ButtonStyle kPrimaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppTheme.primaryColor,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
);

final ButtonStyle kSecondaryButtonStyle = OutlinedButton.styleFrom(
  foregroundColor: AppTheme.primaryColor,
  side: const BorderSide(color: AppTheme.primaryColor),
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
);

sealed class AllowedButtonStyles extends ButtonStyle {
  const AllowedButtonStyles();
  ButtonStyle get style;
}

class EasyStyle extends AllowedButtonStyles {
  const EasyStyle();
  @override
  ButtonStyle get style => kEasyButtonStyle;
}

class MediumStyle extends AllowedButtonStyles {
  const MediumStyle();
  @override
  ButtonStyle get style => kMediumButtonStyle;
}

class HardStyle extends AllowedButtonStyles {
  const HardStyle();
  @override
  ButtonStyle get style => kHardButtonStyle;
}

class MainStyle extends AllowedButtonStyles {
  const MainStyle();
  @override
  ButtonStyle get style => kPrimaryButtonStyle;
}
