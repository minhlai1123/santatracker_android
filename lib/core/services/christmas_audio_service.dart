import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Christmas Audio Service
///
/// Provides cheerful festive sound effects for buttons, discovery events, and mini-games,
/// as well as looping ambient background Christmas music.
/// Integrates native low-latency SoundPool & MediaPlayer (Android) and AVAudioPlayer (iOS).
class ChristmasAudioService {
  ChristmasAudioService._();

  static const MethodChannel _channel = MethodChannel(
    'com.chrimastsatastracker/audio',
  );

  /// Whether button audio effects are enabled.
  static bool soundEnabled = true;

  /// Whether background music is enabled.
  static bool bgmEnabled = true;

  /// Whether current environment is a widget/unit test.
  static bool get _isTestEnvironment {
    return kDebugMode &&
        WidgetsBinding.instance.runtimeType.toString().contains('Test');
  }

  /// Starts or resumes background Christmas music.
  static Future<void> startBgm() async {
    if (!bgmEnabled) return;
    if (_isTestEnvironment) return;

    try {
      await _channel.invokeMethod('startBgm');
    } catch (_) {}
  }

  /// Pauses background music (e.g. when app goes into background).
  static Future<void> pauseBgm() async {
    if (_isTestEnvironment) return;

    try {
      await _channel.invokeMethod('pauseBgm');
    } catch (_) {}
  }

  /// Stops background music completely.
  static Future<void> stopBgm() async {
    if (_isTestEnvironment) return;

    try {
      await _channel.invokeMethod('stopBgm');
    } catch (_) {}
  }

  /// Toggles background music on or off and returns the new state.
  static Future<bool> toggleBgm() async {
    bgmEnabled = !bgmEnabled;
    if (bgmEnabled) {
      await startBgm();
    } else {
      await pauseBgm();
    }
    return bgmEnabled;
  }

  /// Plays a crisp, festive jingle click for buttons and cards.
  static Future<void> playButtonClick() async {
    if (!soundEnabled) return;

    // Tactile haptic feedback
    try {
      await HapticFeedback.lightImpact();
    } catch (_) {}

    if (_isTestEnvironment) return;

    try {
      await _channel.invokeMethod('playSound', {'sound': 'jingle_click'});
    } catch (_) {
      // Fallback to platform system sound
      try {
        await SystemSound.play(SystemSoundType.click);
      } catch (_) {}
    }
  }

  /// Plays a magical, sparkling Christmas chime for unlocking chapters,
  /// discovering locations, or winning minigames.
  static Future<void> playSuccessChime() async {
    if (!soundEnabled) return;

    try {
      await HapticFeedback.mediumImpact();
    } catch (_) {}

    if (_isTestEnvironment) return;

    try {
      await _channel.invokeMethod('playSound', {'sound': 'sparkle_magic'});
    } catch (_) {
      try {
        await SystemSound.play(SystemSoundType.click);
      } catch (_) {}
    }
  }

  /// Plays a cheerful bouncy pop for catching gifts or flipping cards.
  static Future<void> playGiftPop() async {
    if (!soundEnabled) return;

    try {
      await HapticFeedback.selectionClick();
    } catch (_) {}

    if (_isTestEnvironment) return;

    try {
      await _channel.invokeMethod('playSound', {'sound': 'gift_pop'});
    } catch (_) {
      try {
        await SystemSound.play(SystemSoundType.click);
      } catch (_) {}
    }
  }

  /// Plays a resonant, loud golden Christmas bell chime sequence.
  static Future<void> playChristmasBell() async {
    if (!soundEnabled) return;

    try {
      await HapticFeedback.heavyImpact();
    } catch (_) {}

    if (_isTestEnvironment) return;

    try {
      await _channel.invokeMethod('playSound', {'sound': 'christmas_bell'});
    } catch (_) {
      try {
        await SystemSound.play(SystemSoundType.click);
      } catch (_) {}
    }
  }
}
