import Flutter
import UIKit
import AVFoundation
import UserNotifications
import WidgetKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var audioPlayers: [String: AVAudioPlayer] = [:]
  private var bgmPlayer: AVAudioPlayer?
  private var isBgmPlaying = false

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    UNUserNotificationCenter.current().delegate = self
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "ChristmasAudioPlugin")
    if let messenger = registrar?.messenger() {
      let channel = FlutterMethodChannel(name: "com.chrimastsatastracker/audio", binaryMessenger: messenger)
      channel.setMethodCallHandler { [weak self] (call, result) in
        switch call.method {
        case "playSound":
          let args = call.arguments as? [String: Any]
          let sound = args?["sound"] as? String ?? "jingle_click"
          self?.playSound(named: sound)
          result(true)
        case "startBgm":
          self?.startBgm()
          result(true)
        case "pauseBgm":
          self?.pauseBgm()
          result(true)
        case "stopBgm":
          self?.stopBgm()
          result(true)
        default:
          result(FlutterMethodNotImplemented)
        }
      }

      let notifChannel = FlutterMethodChannel(name: "com.chrimastsatastracker/notifications", binaryMessenger: messenger)
      notifChannel.setMethodCallHandler { [weak self] (call, result) in
        switch call.method {
        case "checkPermission":
          UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
              result(settings.authorizationStatus == .authorized)
            }
          }
        case "requestPermission":
          UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            DispatchQueue.main.async {
              result(granted)
            }
          }
        case "showNotification":
          let args = call.arguments as? [String: Any]
          let title = args?["title"] as? String ?? "Christmas Cheer"
          let body = args?["body"] as? String ?? "Merry Christmas!"
          let content = UNMutableNotificationContent()
          content.title = title
          content.body = body
          content.sound = .default
          let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
          UNUserNotificationCenter.current().add(request) { _ in
            DispatchQueue.main.async {
              result(true)
            }
          }
        case "scheduleDaily":
          let args = call.arguments as? [String: Any]
          let hour = args?["hour"] as? Int ?? 9
          let minute = args?["minute"] as? Int ?? 0
          var dateComponents = DateComponents()
          dateComponents.hour = hour
          dateComponents.minute = minute
          let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
          let content = UNMutableNotificationContent()
          content.title = "🎄 Christmas Daily Reminders"
          content.body = "Tap to open today's holiday countdown and festive surprise!"
          content.sound = .default
          let request = UNNotificationRequest(identifier: "daily_christmas_reminder", content: content, trigger: trigger)
          UNUserNotificationCenter.current().add(request) { _ in
            DispatchQueue.main.async {
              result(true)
            }
          }
        case "cancelDaily":
          UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["daily_christmas_reminder"])
          result(true)
        default:
          result(FlutterMethodNotImplemented)
        }
      }

      let widgetChannel = FlutterMethodChannel(name: "com.chrimastsatastracker/widget", binaryMessenger: messenger)
      widgetChannel.setMethodCallHandler { (call, result) in
        switch call.method {
        case "updateWidget":
          if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
          }
          result(true)
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    }
  }

  private func playSound(named name: String) {
    let key = FlutterDartProject.lookupKey(forAsset: "assets/audio/\(name).wav")
    guard let path = Bundle.main.path(forResource: key, ofType: nil) else { return }
    let url = URL(fileURLWithPath: path)
    do {
      let player = try AVAudioPlayer(contentsOf: url)
      player.prepareToPlay()
      player.play()
      audioPlayers[name] = player
    } catch {
      print("ChristmasAudioService iOS Error: \(error)")
    }
  }

  private func startBgm() {
    if let player = bgmPlayer {
      if !player.isPlaying {
        player.play()
      }
      isBgmPlaying = true
      return
    }
    let key = FlutterDartProject.lookupKey(forAsset: "assets/audio/christmas_bgm.wav")
    guard let path = Bundle.main.path(forResource: key, ofType: nil) else { return }
    let url = URL(fileURLWithPath: path)
    do {
      let player = try AVAudioPlayer(contentsOf: url)
      player.numberOfLoops = -1 // Infinite loop
      player.volume = 0.35
      player.prepareToPlay()
      player.play()
      bgmPlayer = player
      isBgmPlaying = true
    } catch {
      print("BGM Error: \(error)")
    }
  }

  private func pauseBgm() {
    bgmPlayer?.pause()
  }

  private func stopBgm() {
    bgmPlayer?.stop()
    bgmPlayer = nil
    isBgmPlaying = false
  }

  override func applicationDidEnterBackground(_ application: UIApplication) {
    pauseBgm()
    super.applicationDidEnterBackground(application)
  }

  override func applicationWillEnterForeground(_ application: UIApplication) {
    super.applicationWillEnterForeground(application)
    if isBgmPlaying {
      startBgm()
    }
  }
}
