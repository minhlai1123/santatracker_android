import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/theme/christmas_typography.dart';
import 'package:chrimastsatastracker/core/theme/app_colors.dart';

void main() {
  group('Christmas Typography & Vietnamese Character Tests', () {
    test(
      'Typography groups are correctly defined with font families and styles',
      () {
        expect(ChristmasTypography.fontFamilyDisplay, equals('Lobster'));
        expect(ChristmasTypography.fontFamilyUI, equals('Fredoka'));
        expect(ChristmasTypography.fontFamilyBody, equals('Nunito'));

        expect(ChristmasTypography.displayLarge.fontFamily, equals('Lobster'));
        expect(ChristmasTypography.titleLarge.fontFamily, equals('Fredoka'));
        expect(ChristmasTypography.bodyLarge.fontFamily, equals('Nunito'));
        expect(ChristmasTypography.countdownDigit.fontFamily, equals('Nunito'));
      },
    );

    test('Vietnamese festive text strings with full diacritics render properly', () {
      const vietnameseAlphabet = 'ăâđêôơưĂÂĐÊÔƠƯ';
      const sampleFestive =
          'Đêm Giáng Sinh ấm áp bên cây thông Noel, xưởng đồ chơi và chiếc khăn quàng.';

      expect(vietnameseAlphabet, contains('ă'));
      expect(vietnameseAlphabet, contains('â'));
      expect(vietnameseAlphabet, contains('đ'));
      expect(vietnameseAlphabet, contains('ê'));
      expect(vietnameseAlphabet, contains('ô'));
      expect(vietnameseAlphabet, contains('ơ'));
      expect(vietnameseAlphabet, contains('ư'));
      expect(sampleFestive, isNotEmpty);

      final textTheme = ChristmasTypography.buildTextTheme();
      expect(textTheme.displayLarge?.fontFamily, equals('Lobster'));
      expect(textTheme.titleLarge?.fontFamily, equals('Fredoka'));
      expect(textTheme.bodyLarge?.fontFamily, equals('Nunito'));
    });

    test('AppColors contains winter sky, ice blue and warm glowing colors', () {
      expect(AppColors.christmasRed.toARGB32(), equals(0xFFC41E3A));
      expect(AppColors.pineGreen.toARGB32(), equals(0xFF1B4D3E));
      expect(AppColors.warmGold.toARGB32(), equals(0xFFD4AF37));
      expect(AppColors.snowWhite.toARGB32(), equals(0xFFFFFFFF));
      expect(AppColors.iceBlue.toARGB32(), equals(0xFFE0F2FE));
      expect(AppColors.midnightBlue.toARGB32(), equals(0xFF0F172A));
      expect(AppColors.warmGlow.toARGB32(), equals(0xFFFFD166));
    });
  });
}
