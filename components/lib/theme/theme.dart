import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart' hide ThemeExtension;
import 'package:google_fonts/google_fonts.dart';

enum AppFont {
  nunito('Nunito'),
  barlow('Barlow'),
  dosis('Dosis'),
  adventPro('Advent Pro'),
  gruppo('Gruppo'),
  jura('Jura'),
  istokWeb('Istok Web'),
  georama('Georama'),
  economica('Economica'),
  daysOne('Days One'),
  basic('Basic'),
  caudex('Caudex'),
  overlockSc('Overlock SC');

  const AppFont(this.label);

  final String label;
}

@immutable
class ThemeExtension extends material.ThemeExtension<ThemeExtension> {
  const ThemeExtension({
    required this.border,
    required this.surfaceMuted,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.danger,
    required this.onDanger,
  });

  final Color border;
  final Color surfaceMuted;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color danger;
  final Color onDanger;

  @override
  ThemeExtension copyWith({
    Color? border,
    Color? surfaceMuted,
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? danger,
    Color? onDanger,
  }) {
    return ThemeExtension(
      border: border ?? this.border,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      danger: danger ?? this.danger,
      onDanger: onDanger ?? this.onDanger,
    );
  }

  @override
  ThemeExtension lerp(material.ThemeExtension<ThemeExtension>? other, double t) {
    if (other is! ThemeExtension) return this;
    return ThemeExtension(
      border: Color.lerp(border, other.border, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      onDanger: Color.lerp(onDanger, other.onDanger, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  static const seedColor = Color(0xFF0B7285);
  static const lightBackground = Color(0xFFF8FAFC);
  static const darkBackground = Color(0xFF101719);

  static ThemeData lightTheme({AppFont font = AppFont.overlockSc}) => _buildTheme(Brightness.light, font);
  static ThemeData darkTheme({AppFont font = AppFont.overlockSc}) => _buildTheme(Brightness.dark, font);

  static ThemeData _buildTheme(Brightness brightness, AppFont font) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
      surface: isDark ? darkBackground : lightBackground,
    );
    final textTheme = _fontTextTheme(font, scheme);
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
    final buttonStyle = _buttonStyle();

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      canvasColor: scheme.surface,
      cardColor: scheme.surfaceContainerLow,
      dividerColor: scheme.outlineVariant,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      fontFamily: font.label,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      iconTheme: IconThemeData(color: scheme.onSurfaceVariant, size: 24),
      primaryIconTheme: IconThemeData(color: scheme.onPrimary, size: 24),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        surfaceTintColor: scheme.surfaceTint,
        titleTextStyle: textTheme.titleLarge,
        toolbarHeight: 64,
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLow,
        surfaceTintColor: scheme.surfaceTint,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: shape,
        clipBehavior: Clip.antiAlias,
      ),
      inputDecorationTheme: _inputDecorationTheme(scheme),
      elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
      filledButtonTheme: FilledButtonThemeData(style: buttonStyle),
      outlinedButtonTheme: _outlinedButtonTheme(scheme),
      textButtonTheme: _textButtonTheme(scheme),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: scheme.onSurfaceVariant,
          minimumSize: const Size(44, 44),
          shape: const CircleBorder(),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        elevation: 2,
        shape: shape,
      ),
      chipTheme: _chipTheme(scheme, textTheme),
      checkboxTheme: _checkboxTheme(scheme),
      radioTheme: _radioTheme(scheme),
      switchTheme: _switchTheme(scheme),
      sliderTheme: SliderThemeData(
        activeTrackColor: scheme.primary,
        inactiveTrackColor: scheme.surfaceContainerHighest,
        thumbColor: scheme.primary,
        overlayColor: scheme.primary.withValues(alpha: 0.12),
        valueIndicatorColor: scheme.inverseSurface,
        valueIndicatorTextStyle: TextStyle(color: scheme.onInverseSurface),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.surfaceContainerHighest,
        circularTrackColor: scheme.surfaceContainerHighest,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: shape,
        iconColor: scheme.onSurfaceVariant,
        textColor: scheme.onSurface,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        surfaceTintColor: scheme.surfaceTint,
        elevation: 6,
        shape: shape,
        titleTextStyle: textTheme.headlineSmall,
        contentTextStyle: textTheme.bodyMedium,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        showDragHandle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: TextStyle(color: scheme.onInverseSurface),
        actionTextColor: scheme.inversePrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(color: scheme.inverseSurface, borderRadius: BorderRadius.circular(6)),
        textStyle: TextStyle(color: scheme.onInverseSurface),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: scheme.surfaceContainer,
        surfaceTintColor: scheme.surfaceTint,
        shape: shape,
        elevation: 3,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.secondaryContainer,
        elevation: 2,
        labelTextStyle: WidgetStatePropertyAll(textTheme.labelMedium),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.secondaryContainer,
        selectedIconTheme: IconThemeData(color: scheme.onSecondaryContainer),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: scheme.primary,
        unselectedLabelColor: scheme.onSurfaceVariant,
        indicatorColor: scheme.primary,
        dividerColor: scheme.outlineVariant,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: scheme.onSurfaceVariant,
        collapsedIconColor: scheme.onSurfaceVariant,
        textColor: scheme.onSurface,
        collapsedTextColor: scheme.onSurface,
        shape: shape,
        collapsedShape: shape,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(scheme.outline),
        radius: const Radius.circular(8),
        thickness: const WidgetStatePropertyAll(6),
      ),
      extensions: <material.ThemeExtension<dynamic>>[
        ThemeExtension(
          border: scheme.outline,
          surfaceMuted: scheme.surfaceContainer,
          success: isDark ? const Color(0xFF72D5A5) : const Color(0xFF087F5B),
          onSuccess: isDark ? const Color(0xFF003B2A) : Colors.white,
          warning: isDark ? const Color(0xFFFFD166) : const Color(0xFFB45309),
          onWarning: isDark ? const Color(0xFF452A00) : Colors.white,
          danger: scheme.error,
          onDanger: scheme.onError,
        ),
      ],
    );
  }

  static TextTheme _fontTextTheme(AppFont font, ColorScheme scheme) {
    final base = _textTheme(scheme);
    return switch (font) {
      AppFont.nunito => GoogleFonts.nunitoTextTheme(base),
      AppFont.barlow => GoogleFonts.barlowTextTheme(base),
      AppFont.dosis => GoogleFonts.dosisTextTheme(base),
      AppFont.adventPro => GoogleFonts.adventProTextTheme(base),
      AppFont.gruppo => GoogleFonts.gruppoTextTheme(base),
      AppFont.jura => GoogleFonts.juraTextTheme(base),
      AppFont.istokWeb => GoogleFonts.istokWebTextTheme(base),
      AppFont.georama => GoogleFonts.georamaTextTheme(base),
      AppFont.economica => GoogleFonts.economicaTextTheme(base),
      AppFont.daysOne => GoogleFonts.daysOneTextTheme(base),
      AppFont.basic => GoogleFonts.basicTextTheme(base),
      AppFont.caudex => GoogleFonts.caudexTextTheme(base),
      AppFont.overlockSc => GoogleFonts.overlockScTextTheme(base),
    };
  }

  static TextTheme _textTheme(ColorScheme scheme) {
    return TextTheme(
      displayLarge: const TextStyle(fontSize: 57, fontWeight: FontWeight.w700),
      displayMedium: const TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
      displaySmall: const TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
      headlineLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
      headlineMedium: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
      headlineSmall: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      titleLarge: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      titleSmall: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, color: scheme.onSurface),
      bodyMedium: TextStyle(fontSize: 14, color: scheme.onSurface),
      bodySmall: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
      labelLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      labelMedium: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      labelSmall: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(ColorScheme scheme) {
    OutlineInputBorder border(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceContainerLowest,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: border(scheme.outline),
      enabledBorder: border(scheme.outline),
      focusedBorder: border(scheme.primary, 2),
      errorBorder: border(scheme.error),
      focusedErrorBorder: border(scheme.error, 2),
      labelStyle: TextStyle(color: scheme.onSurfaceVariant),
      hintStyle: TextStyle(color: scheme.onSurfaceVariant),
      floatingLabelStyle: TextStyle(color: scheme.primary),
      errorStyle: TextStyle(color: scheme.error),
    );
  }

  static ButtonStyle _buttonStyle() {
    return ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme(ColorScheme scheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: scheme.primary,
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        side: BorderSide(color: scheme.outline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(ColorScheme scheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: scheme.primary,
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static ChipThemeData _chipTheme(ColorScheme scheme, TextTheme textTheme) {
    return ChipThemeData(
      backgroundColor: scheme.surfaceContainerHighest,
      selectedColor: scheme.secondaryContainer,
      disabledColor: scheme.surfaceContainerLow,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      labelStyle: textTheme.labelLarge!,
      side: BorderSide(color: scheme.outlineVariant),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  static CheckboxThemeData _checkboxTheme(ColorScheme scheme) {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected) ? scheme.primary : null;
      }),
      checkColor: WidgetStatePropertyAll(scheme.onPrimary),
      side: BorderSide(color: scheme.outline, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }

  static RadioThemeData _radioTheme(ColorScheme scheme) {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected) ? scheme.primary : scheme.outline;
      }),
    );
  }

  static SwitchThemeData _switchTheme(ColorScheme scheme) {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected) ? scheme.onPrimary : scheme.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected) ? scheme.primary : scheme.surfaceContainerHighest;
      }),
      trackOutlineColor: WidgetStatePropertyAll(scheme.outline),
    );
  }
}
