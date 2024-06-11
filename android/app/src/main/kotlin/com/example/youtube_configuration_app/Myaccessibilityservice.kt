package com.example.youtube_configuration_app

import android.accessibilityservice.AccessibilityService
import android.content.Intent
import android.util.Log
import android.view.accessibility.AccessibilityEvent

class MyAccessibilityService : AccessibilityService() {
    private val TAG = "MyAccessibilityService"

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event != null) {
            Log.d(TAG, "Event: ${event.eventType}, Package: ${event.packageName}")
        }

        if (event?.eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {
            val packageName = event.packageName?.toString() ?: ""
            Log.d(TAG, "Current Package: $packageName")
            if (packageName != "com.google.android.youtube") {
                launchApp("com.google.android.youtube")
            }
        }
    }

    override fun onInterrupt() {
        Log.d(TAG, "Accessibility Service Interrupted")
    }

    private fun launchApp(packageName: String) {
        val intent = packageManager.getLaunchIntentForPackage(packageName)
        if (intent != null) {
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            Log.d(TAG, "Launching YouTube")
            startActivity(intent)
        } else {
            Log.d(TAG, "YouTube app not found")
        }
    }
}
