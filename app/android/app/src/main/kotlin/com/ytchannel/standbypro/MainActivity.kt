package com.ytchannel.standbypro

import android.content.Context
import android.media.AudioManager
import android.view.KeyEvent
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "standby_pro/system"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName).setMethodCallHandler { call, result ->
            when (call.method) {
                "setKeepAwake" -> {
                    val enabled = getArgument<Boolean>(call.arguments, "enabled")
                    if (enabled == null) {
                        result.error("INVALID_ARGUMENT", "setKeepAwake requires an enabled boolean.", null)
                    } else {
                        setKeepAwake(enabled)
                        result.success(true)
                    }
                }
                "setBrightness" -> {
                    val value = getArgument<Number>(call.arguments, "value")
                    if (value == null) {
                        result.error("INVALID_ARGUMENT", "setBrightness requires a numeric value.", null)
                    } else {
                        setBrightness(value.toDouble())
                        result.success(true)
                    }
                }
                "mediaCommand" -> {
                    val command = getArgument<String>(call.arguments, "command")
                    val handled = command?.let(::dispatchMediaCommand) ?: false
                    if (handled) {
                        result.success(true)
                    } else {
                        result.error("INVALID_ARGUMENT", "Unsupported media command: $command", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    @Suppress("UNCHECKED_CAST")
    private fun <T> getArgument(arguments: Any?, key: String): T? {
        return when (arguments) {
            is Map<*, *> -> arguments[key] as? T
            else -> arguments as? T
        }
    }

    private fun setKeepAwake(enabled: Boolean) {
        if (enabled) {
            window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        } else {
            window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        }
    }

    private fun setBrightness(value: Double) {
        val attributes = window.attributes
        attributes.screenBrightness = value.coerceIn(0.0, 1.0).toFloat()
        window.attributes = attributes
    }

    private fun dispatchMediaCommand(command: String): Boolean {
        val keyCode = when (command) {
            "playPause" -> KeyEvent.KEYCODE_MEDIA_PLAY_PAUSE
            "next" -> KeyEvent.KEYCODE_MEDIA_NEXT
            "previous" -> KeyEvent.KEYCODE_MEDIA_PREVIOUS
            else -> return false
        }

        val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
        audioManager.dispatchMediaKeyEvent(KeyEvent(KeyEvent.ACTION_DOWN, keyCode))
        audioManager.dispatchMediaKeyEvent(KeyEvent(KeyEvent.ACTION_UP, keyCode))
        return true
    }
}
