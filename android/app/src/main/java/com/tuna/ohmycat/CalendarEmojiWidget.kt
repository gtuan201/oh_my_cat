package com.tuna.ohmycat

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.SharedPreferences
import android.graphics.BitmapFactory
import android.graphics.Color
import android.widget.RemoteViews

/**
 * Implementation of App Widget functionality.
 */
class CalendarEmojiWidget : AppWidgetProvider() {
    override fun onUpdate(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetIds: IntArray
    ) {
        val widgetData = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)
        val imagePath = widgetData.getString("imagePath", null)

        val widgetColor = widgetData.getString("widgetColor", null)

        val dateTime = widgetData.getString("dateTime", null)

        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.calendar_emoji_widget).apply {
                setInt(R.id.widget_layout, "setBackgroundColor", Color.parseColor(widgetColor))
                setTextViewText(R.id.widget_text,dateTime)
                if (!imagePath.isNullOrEmpty()) {
                    val bitmap = BitmapFactory.decodeFile(imagePath)
                    if (bitmap != null) {
                        setImageViewBitmap(R.id.widget_image, bitmap)
                    } else {
                        // Sử dụng một hình ảnh mặc định nếu decodeFile trả về null
                    }
                }
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}


