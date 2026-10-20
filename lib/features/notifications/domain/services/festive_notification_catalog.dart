import '../models/festive_notification_item.dart';

class FestiveNotificationCatalog {
  const FestiveNotificationCatalog._();

  static bool isEvenDay(DateTime date) => date.day % 2 == 0;

  static int daysUntilChristmas(DateTime date) {
    var targetYear = date.year;
    var target = DateTime(targetYear, 12, 25);
    if (date.isAfter(target)) {
      target = DateTime(targetYear + 1, 12, 25);
    }
    return target.difference(DateTime(date.year, date.month, date.day)).inDays;
  }

  static FestiveNotificationItem getNotificationForDate(DateTime date) {
    final day = date.day;
    final isEven = isEvenDay(date);
    final daysLeft = daysUntilChristmas(date);

    // If December, use specific Advent & Christmas Day curated messages
    if (date.month == 12) {
      if (isEven && _evenDayDecemberMessages.containsKey(day)) {
        final data = _evenDayDecemberMessages[day]!;
        return FestiveNotificationItem(
          id: 'dec_even_$day',
          title: data.title,
          body: data.body,
          isEvenDaySpecial: true,
          day: day,
          payload: data.payload,
          scheduledDate: date,
        );
      } else if (!isEven && _oddDayDecemberMessages.containsKey(day)) {
        final data = _oddDayDecemberMessages[day]!;
        return FestiveNotificationItem(
          id: 'dec_odd_$day',
          title: data.title,
          body: data.body,
          isEvenDaySpecial: false,
          day: day,
          payload: data.payload,
          scheduledDate: date,
        );
      }
    }

    // Dynamic seasonal catalog for all other months (Jan - Nov)
    if (isEven) {
      final surprise = _evenDaySurprises[day % _evenDaySurprises.length];
      return FestiveNotificationItem(
        id: 'notif_even_$day',
        title: '✨ [Even-Day Special] Day $day: ${surprise.headline}',
        body: '${surprise.detail} $daysLeft days until Christmas!',
        isEvenDaySpecial: true,
        day: day,
        payload: surprise.payload,
        scheduledDate: date,
      );
    } else {
      final cheer = _oddDayCheers[day % _oddDayCheers.length];
      return FestiveNotificationItem(
        id: 'notif_odd_$day',
        title: '🎄 Christmas Countdown (Day $day)',
        body: '$daysLeft days until Christmas! ${cheer.message}',
        isEvenDaySpecial: false,
        day: day,
        payload: cheer.payload,
        scheduledDate: date,
      );
    }
  }

  // Curated Even-Day Special messages for December
  static const Map<int, _NotificationContent> _evenDayDecemberMessages = {
    2: _NotificationContent(
      title: "✨ [Even-Day Special] Santa's Secret Cookie Recipe!",
      body: "Day 2 surprise: Fresh cinnamon star cookies are baking in the North Pole bakery! Tap to explore the village.",
      payload: 'village',
    ),
    4: _NotificationContent(
      title: "🎁 [Even-Day Special] Rudolph's Glowing Riddle!",
      body: 'Day 4 mystery: "I guide the sleigh through the thickest winter fog." Can you guess? Open today\'s chapter!',
      payload: 'advent',
    ),
    6: _NotificationContent(
      title: "🌟 [Even-Day Special] Northern Lights Wonder!",
      body: "Day 6 magic: Aurora borealis lights up the sky over Santa's workshop! Test your memory in Holiday Match!",
      payload: 'mini_games',
    ),
    8: _NotificationContent(
      title: "🛷 [Even-Day Special] Santa's Supersonic Test Flight!",
      body: "Day 8 radar: Santa took the sleigh out for high-altitude trials over Greenland! Check the Santa Tracker.",
      payload: 'santa_tracker',
    ),
    10: _NotificationContent(
      title: "🎀 [Even-Day Special] Elf Toymakers' Speed Record!",
      body: "Day 10 milestone: 10,000 wooden rocking horses assembled today! Can you beat the Catch the Gifts high score?",
      payload: 'mini_games',
    ),
    12: _NotificationContent(
      title: "🎶 [Even-Day Special] The 12th Day Holiday Chime!",
      body: "Day 12 carol: The village bell tower is chiming festive melodies! Turn on the holiday music and celebrate.",
      payload: 'home',
    ),
    14: _NotificationContent(
      title: "❄️ [Even-Day Special] The Golden Snowflake Mystery!",
      body: "Day 14 discovery: A rare golden snowflake was found at the reindeer stables. Discover its festive secrets!",
      payload: 'village',
    ),
    16: _NotificationContent(
      title: "⭐ [Even-Day Special] Midnight Sleigh Polish!",
      body: "Day 16 alert: The elves applied magic stardust wax to the runners. Sleigh speed boosted! View Tracker.",
      payload: 'santa_tracker',
    ),
    18: _NotificationContent(
      title: "📜 [Even-Day Special] Santa's Time-Stopping Pocket Watch!",
      body: "Day 18 legend: How does Santa deliver presents to the whole world in one night? Read the storybook to find out!",
      payload: 'advent',
    ),
    20: _NotificationContent(
      title: "🎄 [Even-Day Special] 5-Day Countdown Sparkle!",
      body: "Day 20 countdown: Only 5 days until Christmas! The entire North Pole is glowing with candlelight and warmth.",
      payload: 'countdown',
    ),
    22: _NotificationContent(
      title: "🔔 [Even-Day Special] Final Flight Route Approved!",
      body: "Day 22 alert: Reindeer navigation maps are locked in for 12 world stops! Are your holiday wishes ready?",
      payload: 'santa_tracker',
    ),
    24: _NotificationContent(
      title: "🌟 [Christmas Eve Special] Santa Has Taken Off!",
      body: "Day 24 grand flight: Rudolph's nose is shining bright and Santa's sleigh is in the air! Track his journey live!",
      payload: 'santa_tracker',
    ),
    26: _NotificationContent(
      title: "🎁 [Even-Day Special] Boxing Day Warmth!",
      body: "Day 26 cheer: May the holiday joy, cozy warmth, and peaceful moments linger with your family today!",
      payload: 'home',
    ),
    28: _NotificationContent(
      title: "✨ [Even-Day Special] Starlight Over the Winter Pines!",
      body: "Day 28 serenity: Peaceful winter nights and sweet memories of Christmas cheer. Play a relaxing mini-game!",
      payload: 'mini_games',
    ),
    30: _NotificationContent(
      title: "🎆 [Even-Day Special] Holiday Magic Continues!",
      body: "Day 30 celebration: As the holiday season glows bright, keep the festive spirit in your heart all year round!",
      payload: 'countdown',
    ),
  };

  // Curated Odd-Day Cheer messages for December
  static const Map<int, _NotificationContent> _oddDayDecemberMessages = {
    1: _NotificationContent(
      title: '🎄 Welcome to December!',
      body: 'The 24-day countdown to Christmas begins today. Open Chapter 1 in the Advent Storybook!',
      payload: 'advent',
    ),
    3: _NotificationContent(
      title: '❄️ Gentle Winter Snowfall',
      body: 'Soft winter snow is falling at the North Pole. Explore the village landmarks today!',
      payload: 'village',
    ),
    5: _NotificationContent(
      title: '🦌 Reindeer Runway Practice',
      body: 'Dasher and Dancer are practicing takeoffs! Catch falling gifts in the workshop mini-game.',
      payload: 'mini_games',
    ),
    7: _NotificationContent(
      title: '🔔 Ring the Holiday Bells',
      body: 'Holiday bells are ringing across the snowy hills. Another week closer to Christmas Eve!',
      payload: 'home',
    ),
    9: _NotificationContent(
      title: '🧤 Cozy Winter Moments',
      body: 'Warm mittens and hot cocoa await. Take a cozy moment with today\'s Christmas countdown.',
      payload: 'countdown',
    ),
    11: _NotificationContent(
      title: '🕯️ Light the Festive Candles',
      body: 'Santa\'s elves are packing the gift bags with care and love. Check today\'s story!',
      payload: 'advent',
    ),
    13: _NotificationContent(
      title: '⭐ Holiday Memory Challenge',
      body: 'Follow the Christmas star! Can you find all matching pairs in the Memory Match game?',
      payload: 'mini_games',
    ),
    15: _NotificationContent(
      title: '🎅 Checking the List Twice',
      body: 'Santa checked his list twice today! Exactly 10 days until Christmas morning.',
      payload: 'santa_tracker',
    ),
    17: _NotificationContent(
      title: '🌲 Scent of Fresh Pine',
      body: 'The winter breeze carries the scent of fresh pine. Unlock Chapter 17 in the Storybook!',
      payload: 'advent',
    ),
    19: _NotificationContent(
      title: '🎁 Workshop Gift Rush',
      body: 'Gift boxes are stacked high to the ceiling! Test your reflexes in Catch the Gifts.',
      payload: 'mini_games',
    ),
    21: _NotificationContent(
      title: '❄️ Winter Solstice Wonder',
      body: 'Winter wonderland is here! Only 4 days left until Christmas celebration.',
      payload: 'countdown',
    ),
    23: _NotificationContent(
      title: '✨ The Eve of Christmas Eve',
      body: 'Santa\'s sleigh is fully packed and waiting on the runway. Sleigh departs tomorrow!',
      payload: 'santa_tracker',
    ),
    25: _NotificationContent(
      title: '🎅 Merry Christmas to All!',
      body: 'Wishing you and your family a season filled with love, wonder, peace, and holiday magic!',
      payload: 'home',
    ),
    27: _NotificationContent(
      title: '🕊️ Peaceful Holiday Cheer',
      body: 'Relax, cherish the gifts, and enjoy warm memories with your loved ones today.',
      payload: 'home',
    ),
    29: _NotificationContent(
      title: '🌟 Holiday Glow Continues',
      body: 'The warm fireplace and festive lights continue to shine. Enjoy a cheerful holiday puzzle!',
      payload: 'mini_games',
    ),
    31: _NotificationContent(
      title: '🎉 Happy New Year\'s Eve!',
      body: 'Carry the warmth, joy, and kindness of the Christmas season into the wonderful new year!',
      payload: 'countdown',
    ),
  };

  // Rotating surprises for even days in other months
  static const List<_EvenSurpriseData> _evenDaySurprises = [
    _EvenSurpriseData(
      headline: 'Secret North Pole Workshop Alert!',
      detail: 'Santa\'s elves have crafted a special holiday surprise for you today.',
      payload: 'village',
    ),
    _EvenSurpriseData(
      headline: 'Reindeer Stables Discovery!',
      detail:
          'Comet and Cupid spotted a golden snowflake during morning training.',
      payload: 'village',
    ),
    _EvenSurpriseData(
      headline: 'Holiday Memory Challenge!',
      detail: 'Can you match all festive cards in record moves today? Special elf bonus awaits!',
      payload: 'mini_games',
    ),
    _EvenSurpriseData(
      headline: 'Santa Radar Test Flight!',
      detail: 'Radar ping detected over the Arctic! Santa is calibrating global GPS routes.',
      payload: 'santa_tracker',
    ),
    _EvenSurpriseData(
      headline: 'Magical Toyroom Mystery Box!',
      detail: 'A wrapped mystery gift box was delivered to the village post office.',
      payload: 'advent',
    ),
  ];

  // Rotating cheer for odd days in other months
  static const List<_OddCheerData> _oddDayCheers = [
    _OddCheerData(
      message: 'Santa\'s workshop is humming with holiday spirit. Tap to view the countdown!',
      payload: 'countdown',
    ),
    _OddCheerData(
      message: 'Take a cozy pause and enjoy the magical holiday atmosphere.',
      payload: 'home',
    ),
    _OddCheerData(
      message: 'Explore the North Pole Village and discover hidden winter landmarks!',
      payload: 'village',
    ),
    _OddCheerData(
      message: 'Sharpen your reflexes with a quick game of Catch the Gifts!',
      payload: 'mini_games',
    ),
    _OddCheerData(
      message:
          'Read a heartwarming holiday chapter in the 24-Day Advent Storybook.',
      payload: 'advent',
    ),
  ];
}

class _NotificationContent {
  final String title;
  final String body;
  final String payload;

  const _NotificationContent({
    required this.title,
    required this.body,
    required this.payload,
  });
}

class _EvenSurpriseData {
  final String headline;
  final String detail;
  final String payload;

  const _EvenSurpriseData({
    required this.headline,
    required this.detail,
    required this.payload,
  });
}

class _OddCheerData {
  final String message;
  final String payload;

  const _OddCheerData({required this.message, required this.payload});
}
