package com.example.chrimastsatastracker

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import java.util.Calendar

class ChristmasAppWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {
        super.onEnabled(context)
        updateAllWidgets(context)
    }

    companion object {
        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            val now = Calendar.getInstance()
            val currentYear = now.get(Calendar.YEAR)

            val targetChristmas = Calendar.getInstance().apply {
                set(Calendar.YEAR, currentYear)
                set(Calendar.MONTH, Calendar.DECEMBER)
                set(Calendar.DAY_OF_MONTH, 25)
                set(Calendar.HOUR_OF_DAY, 0)
                set(Calendar.MINUTE, 0)
                set(Calendar.SECOND, 0)
                set(Calendar.MILLISECOND, 0)
                if (now.after(this)) {
                    set(Calendar.YEAR, currentYear + 1)
                }
            }

            val diffMillis = targetChristmas.timeInMillis - now.timeInMillis
            val daysLeft = if (diffMillis <= 0) 0 else (diffMillis / (1000 * 60 * 60 * 24)).toInt()

            val dayOfMonth = now.get(Calendar.DAY_OF_MONTH)
            val isEvenDay = (dayOfMonth % 2 == 0)

            val views = RemoteViews(context.packageName, R.layout.christmas_app_widget)

            // Update countdown text
            views.setTextViewText(R.id.widget_days_number, daysLeft.toString())

            val daysLabel = when (daysLeft) {
                0 -> "TODAY IS CHRISTMAS!"
                1 -> "DAY UNTIL CHRISTMAS"
                else -> "DAYS UNTIL CHRISTMAS"
            }
            views.setTextViewText(R.id.widget_days_label, daysLabel)

            // Update status badge
            val statusBadge = if (isEvenDay) {
                "✨ Even-Day Special Active"
            } else {
                "🎄 Daily Christmas Cheer"
            }
            views.setTextViewText(R.id.widget_status_badge, statusBadge)

            // Click action: launch MainActivity
            val launchIntent = Intent(context, MainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                putExtra("from_widget", true)
                putExtra("payload", "countdown")
            }
            val pendingIntent = PendingIntent.getActivity(
                context,
                2026,
                launchIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widget_container, pendingIntent)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }

        fun updateAllWidgets(context: Context) {
            try {
                val appWidgetManager = AppWidgetManager.getInstance(context)
                val componentName = ComponentName(context, ChristmasAppWidgetProvider::class.java)
                val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)
                if (appWidgetIds != null && appWidgetIds.isNotEmpty()) {
                    for (appWidgetId in appWidgetIds) {
                        updateAppWidget(context, appWidgetManager, appWidgetId)
                    }
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }
}
