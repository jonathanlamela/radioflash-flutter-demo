package com.realeventsrl.radioflash

import android.content.Intent
import android.os.Build
import androidx.core.content.ContextCompat
import io.flutter.Log
import io.flutter.app.FlutterApplication

class Application: FlutterApplication() {
    val CHANNEL = "com.realeventsrl.radioflash";

    override fun onCreate() {
        super.onCreate()


    }

    override fun onTerminate() {
        super.onTerminate()
        stopService(Intent("com.ryanheise.audioservice.AudioService"))
    }




}