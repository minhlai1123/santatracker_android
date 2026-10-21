package com.example.chrimastsatastracker

import android.Manifest
import android.content.pm.PackageManager
import android.content.res.AssetFileDescriptor
import android.media.AudioAttributes
import android.media.MediaPlayer
import android.media.SoundPool
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat
import io.flutter.FlutterInjector
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val AUDIO_CHANNEL = "com.chrimastsatastracker/audio"
    private val NOTIFICATION_CHANNEL = "com.chrimastsatastracker/notifications"
    private val WIDGET_CHANNEL = "com.chrimastsatastracker/widget"
    private var soundPool: SoundPool? = null
    private val soundMap = HashMap<String, Int>()
    private var bgmPlayer: MediaPlayer? = null
    private var isBgmPlaying = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        initSoundPool()
        initBgmPlayer()
        ChristmasNotificationHelper.createNotificationChannel(this)
        ChristmasAppWidgetProvider.updateAllWidgets(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, AUDIO_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "playSound" -> {
                    val sound = call.argument<String>("sound") ?: "jingle_click"
                    val soundId = soundMap[sound]
                    if (soundId != null && soundId != 0) {
                        soundPool?.play(soundId, 1.0f, 1.0f, 1, 0, 1.0f)
                        result.success(true)
                    } else {
                        result.success(false)
                    }
                }
                "startBgm" -> {
                    startBgm()
                    result.success(true)
                }
                "pauseBgm" -> {
                    pauseBgm()
                    result.success(true)
                }
                "stopBgm" -> {
                    stopBgm()
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, NOTIFICATION_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "showNotification" -> {
                    val title = call.argument<String>("title") ?: "Christmas Cheer"
                    val body = call.argument<String>("body") ?: "Merry Christmas!"
                    val isEven = call.argument<Boolean>("isEvenDaySpecial") ?: false
                    val payload = call.argument<String>("payload")
                    ChristmasNotificationHelper.showNotification(
                        context = this,
                        title = title,
                        body = body,
                        isEvenDaySpecial = isEven,
                        payload = payload
                    )
                    result.success(true)
                }
                "scheduleDaily" -> {
                    val hour = call.argument<Int>("hour") ?: 9
                    val minute = call.argument<Int>("minute") ?: 0
                    ChristmasNotificationHelper.scheduleDailyAlarm(this, hour, minute)
                    result.success(true)
                }
                "cancelDaily" -> {
                    ChristmasNotificationHelper.cancelDailyAlarm(this)
                    result.success(true)
                }
                "checkPermission" -> {
                    val areEnabled = NotificationManagerCompat.from(this).areNotificationsEnabled()
                    result.success(areEnabled)
                }
                "requestPermission" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                        if (ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) {
                            ActivityCompat.requestPermissions(
                                this,
                                arrayOf(Manifest.permission.POST_NOTIFICATIONS),
                                1002
                            )
                        }
                    }
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, WIDGET_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "updateWidget" -> {
                    ChristmasAppWidgetProvider.updateAllWidgets(this)
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun initSoundPool() {
        try {
            val audioAttributes = AudioAttributes.Builder()
                .setUsage(AudioAttributes.USAGE_GAME)
                .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                .build()

            val pool = SoundPool.Builder()
                .setMaxStreams(8)
                .setAudioAttributes(audioAttributes)
                .build()

            soundPool = pool

            loadSound(pool, "jingle_click", "assets/audio/jingle_click.wav")
            loadSound(pool, "sparkle_magic", "assets/audio/sparkle_magic.wav")
            loadSound(pool, "gift_pop", "assets/audio/gift_pop.wav")
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun loadSound(pool: SoundPool, key: String, flutterAssetPath: String) {
        try {
            val lookupKey = FlutterInjector.instance().flutterLoader().getLookupKeyForAsset(flutterAssetPath)
            val afd: AssetFileDescriptor = assets.openFd(lookupKey)
            val soundId = pool.load(afd, 1)
            soundMap[key] = soundId
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun initBgmPlayer() {
        try {
            val lookupKey = FlutterInjector.instance().flutterLoader().getLookupKeyForAsset("assets/audio/christmas_bgm.wav")
            val afd: AssetFileDescriptor = assets.openFd(lookupKey)
            val player = MediaPlayer()
            player.setDataSource(afd.fileDescriptor, afd.startOffset, afd.length)
            player.setAudioAttributes(
                AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_MEDIA)
                    .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                    .build()
            )
            player.isLooping = true
            player.setVolume(0.20f, 0.20f)
            player.prepare()
            bgmPlayer = player
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun startBgm() {
        try {
            bgmPlayer?.let { player ->
                if (!player.isPlaying) {
                    player.start()
                    isBgmPlaying = true
                }
            } ?: run {
                initBgmPlayer()
                bgmPlayer?.start()
                isBgmPlaying = true
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun pauseBgm() {
        try {
            bgmPlayer?.let { player ->
                if (player.isPlaying) {
                    player.pause()
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun stopBgm() {
        try {
            bgmPlayer?.let { player ->
                if (player.isPlaying) {
                    player.stop()
                }
                player.release()
            }
            bgmPlayer = null
            isBgmPlaying = false
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    override fun onResume() {
        super.onResume()
        if (isBgmPlaying) {
            startBgm()
        }
        ChristmasAppWidgetProvider.updateAllWidgets(this)
    }

    override fun onPause() {
        pauseBgm()
        super.onPause()
    }

    override fun onDestroy() {
        stopBgm()
        try {
            soundPool?.release()
            soundPool = null
            soundMap.clear()
        } catch (e: Exception) {
            e.printStackTrace()
        }
        super.onDestroy()
    }
}
