import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/services/christmas_audio_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ChristmasAudioService Tests', () {
    setUp(() {
      ChristmasAudioService.soundEnabled = true;
      ChristmasAudioService.bgmEnabled = true;
    });

    test('initial soundEnabled is true and can be toggled', () {
      expect(ChristmasAudioService.soundEnabled, isTrue);
      ChristmasAudioService.soundEnabled = false;
      expect(ChristmasAudioService.soundEnabled, isFalse);
      ChristmasAudioService.soundEnabled = true;
      expect(ChristmasAudioService.soundEnabled, isTrue);
    });

    test('initial bgmEnabled is true and can be toggled', () async {
      expect(ChristmasAudioService.bgmEnabled, isTrue);
      final newState = await ChristmasAudioService.toggleBgm();
      expect(newState, isFalse);
      expect(ChristmasAudioService.bgmEnabled, isFalse);
      final restoredState = await ChristmasAudioService.toggleBgm();
      expect(restoredState, isTrue);
      expect(ChristmasAudioService.bgmEnabled, isTrue);
    });

    test('playButtonClick completes without throwing', () async {
      await expectLater(ChristmasAudioService.playButtonClick(), completes);
    });

    test('playSuccessChime completes without throwing', () async {
      await expectLater(ChristmasAudioService.playSuccessChime(), completes);
    });

    test('playGiftPop completes without throwing', () async {
      await expectLater(ChristmasAudioService.playGiftPop(), completes);
    });

    test('BGM methods complete without throwing in test environment', () async {
      await expectLater(ChristmasAudioService.startBgm(), completes);
      await expectLater(ChristmasAudioService.pauseBgm(), completes);
      await expectLater(ChristmasAudioService.stopBgm(), completes);
    });

    test(
      'audio methods complete without throwing when sound is disabled',
      () async {
        ChristmasAudioService.soundEnabled = false;
        ChristmasAudioService.bgmEnabled = false;
        await expectLater(ChristmasAudioService.playButtonClick(), completes);
        await expectLater(ChristmasAudioService.playSuccessChime(), completes);
        await expectLater(ChristmasAudioService.playGiftPop(), completes);
        await expectLater(ChristmasAudioService.startBgm(), completes);
        await expectLater(ChristmasAudioService.pauseBgm(), completes);
        await expectLater(ChristmasAudioService.stopBgm(), completes);
      },
    );
  });
}
