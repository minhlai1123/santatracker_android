package com.example.chrimastsatastracker

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import java.util.Calendar

class ChristmasNotificationReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent?) {
        val action = intent?.action

        if (action == Intent.ACTION_BOOT_COMPLETED) {
            ChristmasNotificationHelper.rescheduleIfEnabled(context)
            return
        }

        val calendar = Calendar.getInstance()
        val day = calendar.get(Calendar.DAY_OF_MONTH)
        val isEven = (day % 2 == 0)

        val title: String
        val body: String
        val payload: String

        if (isEven) {
            title = "✨ [Even-Day Special] Day $day Holiday Surprise!"
            body = getEvenDayMessage(day)
            payload = "village"
        } else {
            title = "🎄 Christmas Daily Cheer (Day $day)"
            body = getOddDayMessage(day)
            payload = "countdown"
        }

        ChristmasNotificationHelper.showNotification(
            context = context,
            title = title,
            body = body,
            isEvenDaySpecial = isEven,
            payload = payload
        )

        // Reschedule next daily reminder for 24 hours later
        ChristmasNotificationHelper.rescheduleIfEnabled(context)
    }

    private fun getEvenDayMessage(day: Int): String {
        return when (day) {
            2 -> "Fresh cinnamon star cookies are baking in the North Pole bakery! Tap to explore the village."
            4 -> "Riddle: \"I guide the sleigh through the thickest fog.\" Can you guess? Open today's chapter!"
            6 -> "Aurora borealis lights up the sky over Santa's workshop! Test your memory in Holiday Match!"
            8 -> "Radar ping: Santa took the sleigh out for high-altitude trials over Greenland! Check the Tracker."
            10 -> "Milestone: 10,000 wooden rocking horses assembled! Can you beat the Catch Gifts high score?"
            12 -> "The village bell tower is chiming festive melodies! Turn on the holiday music and celebrate."
            14 -> "A rare golden snowflake was found at the reindeer stables. Discover its secrets in the Village!"
            16 -> "Magic stardust wax applied to runners. Sleigh speed boosted! Check Santa's route."
            18 -> "How does Santa deliver presents to the whole world in one night? Read the storybook to find out!"
            20 -> "Only 5 days until Christmas! The entire North Pole is glowing with candlelight and warmth."
            22 -> "Reindeer navigation maps locked in for 12 world stops! Are your holiday wishes ready?"
            24 -> "Rudolph's nose is shining bright and Santa's sleigh is in the air! Track his journey live!"
            26 -> "Boxing Day warmth: May peace, joy, and wonderful moments linger with your family today."
            28 -> "Peaceful winter nights and sweet memories of Christmas cheer. Play a relaxing holiday mini-game!"
            30 -> "Holiday Magic Continues: Keep the festive kindness and cheer glowing in your heart!"
            else -> "Today is an even-numbered day! Santa's elves have hidden a secret holiday sparkle inside the app."
        }
    }

    private fun getOddDayMessage(day: Int): String {
        return when (day) {
            1 -> "The 24-day countdown to Christmas begins today! Open Chapter 1 in the Advent Storybook."
            3 -> "Soft winter snow is falling at the North Pole. Explore the village landmarks today!"
            5 -> "Dasher and Dancer are practicing takeoffs! Catch falling gifts in the workshop mini-game."
            7 -> "Holiday bells are ringing across the snowy hills. Another week closer to Christmas Eve!"
            9 -> "Warm mittens and hot cocoa await. Take a cozy moment with today's Christmas countdown."
            11 -> "Santa's elves are packing the gift bags with care. Check today's holiday story!"
            13 -> "Follow the Christmas star! Can you find all matching pairs in the Memory Match game?"
            15 -> "Santa checked his list twice today! Exactly 10 days until Christmas morning."
            17 -> "The winter breeze carries the scent of fresh pine. Unlock Chapter 17 in the Storybook!"
            19 -> "Gift boxes are stacked high to the ceiling! Test your reflexes in Catch the Gifts."
            21 -> "Winter wonderland is here! Only 4 days left until Christmas celebration."
            23 -> "Santa's sleigh is fully packed and waiting on the runway. Sleigh departs tomorrow!"
            25 -> "Merry Christmas! Wishing you and your family a season filled with love, wonder, and joy!"
            27 -> "Relax, cherish the gifts, and enjoy warm memories with your loved ones today."
            29 -> "The warm fireplace and festive lights continue to shine. Enjoy a cheerful holiday puzzle!"
            31 -> "Happy New Year's Eve! Carry the warmth, joy, and kindness of Christmas into the new year!"
            else -> "Every day brings us closer to the holiday season! Tap to view the Christmas countdown."
        }
    }
}
