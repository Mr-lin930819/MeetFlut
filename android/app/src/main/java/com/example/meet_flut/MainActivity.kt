package com.example.meet_flut

import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.FlutterInjector
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngineGroup
import io.flutter.embedding.engine.dart.DartExecutor

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        val engines = FlutterEngineGroup(applicationContext)
        val dartEntrypoint = DartExecutor.DartEntrypoint(
            FlutterInjector.instance().flutterLoader().findAppBundlePath(), "mixMain"
        )
        val mixEngine = engines.createAndRunEngine(applicationContext, dartEntrypoint)
    }
}