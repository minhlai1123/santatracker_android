import '../models/advent_chapter.dart';
import 'advent_unlock_rules.dart';

class AdventStorybookData {
  static final List<AdventChapter> allChapters = [
    AdventChapter(
      dayNumber: 1,
      id: 'chapter_1',
      title: 'The First Gift',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(1),
      storyContent:
          'As the first winter breeze whispers through snow-covered pines, the North Pole village awakens to a golden dawn. '
          'Santa Claus smiles warmly as he opens his holiday journal, recording the simplest and sweetest wishes of children all around the world.',
      festiveMessage: 'The holiday season has begun! Wishing you a peaceful and joyful start to December.',
      activityOrRiddle: 'Today’s prompt: Write down three heartfelt wishes you would love to share with your family.',
    ),
    AdventChapter(
      dayNumber: 2,
      id: 'chapter_2',
      title: 'Secrets of the Elf Workshop',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(2),
      storyContent:
          'Inside the warm room fragrant with fresh cedar wood, cheerful elves carefully carve wooden trains and paint them in bright holiday colors. '
          'Every handcrafted toy is not just a gift, but a labor of love and pure creative joy.',
      festiveMessage:
          'Patience and passion in small things create the greatest wonders.',
      activityOrRiddle: 'Fun riddle: What runs around a whole room without ever moving? (Answer: The walls or a clock!)',
    ),
    AdventChapter(
      dayNumber: 3,
      id: 'chapter_3',
      title: 'The Flying Reindeer Sleigh',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(3),
      storyContent:
          'Beneath a sparkling starry sky, Rudolph the red-nosed reindeer shakes his antlers, making silver sleigh bells chime merrily. '
          'The flight team is practicing gentle rooftop landings on snow-capped cottages.',
      festiveMessage: 'Be proud of what makes you unique—it is the very light that illuminates your path.',
      activityOrRiddle: 'Little activity: Look up at tonight’s sky and find the brightest star above.',
    ),
    AdventChapter(
      dayNumber: 4,
      id: 'chapter_4',
      title: 'The Golden Bell Riddle',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(4),
      storyContent:
          'Elder elf Barnaby brings an antique golden bell cast over a century ago to the village plaza. '
          'Each time the bell chimes softly, a star-shaped snowflake gently floats into an open palm.',
      festiveMessage:
          'The echoes of kindness travel farther than any sound in the world.',
      activityOrRiddle: 'Christmas riddle: I am pure white when falling from the sky, but vanish when warmed in your hand. What am I? (Answer: A snowflake!)',
    ),
    AdventChapter(
      dayNumber: 5,
      id: 'chapter_5',
      title: 'First Snow of the Season',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(5),
      storyContent:
          'A quiet snowfall blankets the village in a glistening crystal coat. '
          'Children laugh as they build snow forts and sculpt a friendly snowman with a bright orange carrot nose.',
      festiveMessage: 'Every snowflake is unique, just like your own precious and wonderful self.',
      activityOrRiddle: 'Cozy idea: Treat yourself to a warm cup of cocoa sprinkled with cinnamon.',
    ),
    AdventChapter(
      dayNumber: 6,
      id: 'chapter_6',
      title: 'Playful Gingerbread Cookies',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(6),
      storyContent:
          "Mrs. Claus's kitchen fills the air with the comforting aroma of molasses, butter, and spiced ginger. "
          'Freshly baked gingerbread figures pop out of the oven, showing off colorful candy buttons.',
      festiveMessage: 'The warmest flavor of winter is sharing a home-cooked meal with loved ones.',
      activityOrRiddle: 'Small challenge: Send a sweet holiday message to a friend you haven’t spoken to in a while.',
    ),
    AdventChapter(
      dayNumber: 7,
      id: 'chapter_7',
      title: 'The Guiding Star',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(7),
      storyContent:
          'Atop the giant Christmas tree in the plaza, the golden Polaris star begins to shine with radiant splendor. '
          'Its warm glow acts as a beacon guiding Santa’s sleigh home through dense Arctic fog.',
      festiveMessage: 'Even in the darkest winter night, hope will always guide your way forward.',
      activityOrRiddle: 'Fun riddle: What belongs to you, but others use it much more than you do? (Answer: Your name!)',
    ),
    AdventChapter(
      dayNumber: 8,
      id: 'chapter_8',
      title: 'Letters to the North Pole',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(8),
      storyContent:
          'The North Pole Post Office is stacked with thousands of red-and-white striped envelopes. '
          'Some ask for a teddy bear, while others simply wish for health, joy, and peace for their parents.',
      festiveMessage: 'The greatest gift is not found under the tree, but in a generous and caring heart.',
      activityOrRiddle: 'Meaningful task: Write a sincere thank-you note to your parents or guardians.',
    ),
    AdventChapter(
      dayNumber: 9,
      id: 'chapter_9',
      title: 'Winter Night Harmony',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(9),
      storyContent:
          'A circle of elves gathers around a crackling campfire, humming the gentle melody of Silent Night. '
          'The sweet tune blends with whispering pine needles, creating a soothing winter lullaby.',
      festiveMessage: 'Holiday music has the magical power to ease worries and bring hearts together.',
      activityOrRiddle: 'Idea: Put on your favorite Christmas song and sing along with the chorus.',
    ),
    AdventChapter(
      dayNumber: 10,
      id: 'chapter_10',
      title: 'A Heart of Warm Sharing',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(10),
      storyContent:
          'Little elf Pip shares his only red knitted wool scarf with a shivering winter sparrow. '
          'He discovers that when we give warmth away, our own heart grows twice as warm.',
      festiveMessage:
          'Happiness multiplies the moment you share it with those around you.',
      activityOrRiddle: 'Kind act: Offer a warm smile and thank-you to service staff or cashiers you meet today.',
    ),
    AdventChapter(
      dayNumber: 11,
      id: 'chapter_11',
      title: 'The Tree of Gratitude',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(11),
      storyContent:
          'Every pine branch at the North Pole holds a delicate card celebrating memorable moments from the past year. '
          'There are bright triumphs and valuable lessons that helped everyone grow.',
      festiveMessage: 'Grateful for the past, cherishing the present, and welcoming a bright tomorrow.',
      activityOrRiddle: 'Reflection: Name one achievement or lesson you are most proud of this year.',
    ),
    AdventChapter(
      dayNumber: 12,
      id: 'chapter_12',
      title: 'Frosty the Snowman Riddle',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(12),
      storyContent:
          'Frosty the snowman stands guardian by the crystalline ice lake, wearing an antique black top hat and smiling at everyone who passes by. '
          'He loves nothing more than hearing children tell jokes.',
      festiveMessage: 'Hearty laughter is the finest medicine to melt the winter chill away.',
      activityOrRiddle: 'Fun riddle: What does a snowman love to eat for breakfast? (Answer: Snowflakes or frosted ice flakes!)',
    ),
    AdventChapter(
      dayNumber: 13,
      id: 'chapter_13',
      title: 'Festive Woolen Stockings',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(13),
      storyContent:
          'Hand-knitted striped stockings hang neatly above the warm fireplace hearth. '
          'Mrs. Claus says these stockings will soon overflow with sweet treats and blessings on Christmas Eve.',
      festiveMessage:
          'Simple, humble traditions often hold the deepest family love.',
      activityOrRiddle: 'Idea: Slip on your coziest pair of warm socks to stay comfortable today.',
    ),
    AdventChapter(
      dayNumber: 14,
      id: 'chapter_14',
      title: 'Aurora Borealis Dance',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(14),
      storyContent:
          'The Arctic night sky blazes with emerald ribbons and amethyst waves rippling across the stars. '
          'It is the enchanted Northern Lights, announcing that Christmas is just around the corner.',
      festiveMessage: 'Nature always holds breathtaking wonders for those who take time to look up.',
      activityOrRiddle: 'Challenge: Turn off screens for 15 minutes, enjoy the quiet stillness, and breathe deeply.',
    ),
    AdventChapter(
      dayNumber: 15,
      id: 'chapter_15',
      title: 'The Test Flight',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(15),
      storyContent:
          'Santa straps on his leather aviator goggles, steps into his cedar sleigh, and inspects the gilded reins. '
          'The sleigh leaps into the sky, soaring over snowy peaks to cheers from the entire village.',
      festiveMessage: 'Careful preparation and quiet confidence unlock the door to success.',
      activityOrRiddle: 'Holiday checklist: Make a list of things you want to wrap up before Christmas Eve.',
    ),
    AdventChapter(
      dayNumber: 16,
      id: 'chapter_16',
      title: 'Sweet Candy Canes',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(16),
      storyContent:
          'The North Pole sweet shop is bustling with thousands of red-and-white peppermint candy canes. '
          'Curved like a shepherd’s crook, they symbolize protection, peace, and good cheer.',
      festiveMessage:
          'Be a sweet presence that brings joy to those around you each day.',
      activityOrRiddle: 'Fun riddle: What tree blooms all year round indoors without ever needing water? (Answer: An artificial Christmas tree!)',
    ),
    AdventChapter(
      dayNumber: 17,
      id: 'chapter_17',
      title: 'Moonlit Village',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(17),
      storyContent:
          'A radiant full moon casts soft silver light over snow-blanketed roofs. '
          'Gentle blue smoke curls upwards from stone chimneys, wrapping the village in unmatched cozy warmth.',
      festiveMessage: 'Peace of mind is a priceless treasure that no material wealth can equal.',
      activityOrRiddle: 'Action: Tidy up your desk or living space to welcome a fresh new day.',
    ),
    AdventChapter(
      dayNumber: 18,
      id: 'chapter_18',
      title: 'A Message from the Elves',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(18),
      storyContent:
          'Elf Barnaby tucks a tiny note into the bottom of each gift box: "Never stop dreaming, no matter how deep the snow on the path ahead." '
          'Every hurdle is a chance to build inner strength.',
      festiveMessage: 'You are stronger than you know, and your quiet efforts are always noticed.',
      activityOrRiddle: 'Affirmation: Give yourself credit for persevering through recent challenging days.',
    ),
    AdventChapter(
      dayNumber: 19,
      id: 'chapter_19',
      title: 'The Invisible Gift',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(19),
      storyContent:
          'A blue velvet box sits under the tree containing no object, only a small card reading: "Time Spent Together." '
          'Santa says this is the most precious gift people can give one another in busy times.',
      festiveMessage: 'The most sincere gift you can offer someone is your full presence and attentive listening.',
      activityOrRiddle: 'Loving act: Call an elder family member or loved one just to chat today.',
    ),
    AdventChapter(
      dayNumber: 20,
      id: 'chapter_20',
      title: 'The Candle of Hope',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(20),
      storyContent:
          'On the windowsill of a wooden cottage, a warm beeswax candle is lit. '
          'Its small flame flickers bravely against the winter wind, banishing darkness and warming the quiet room.',
      festiveMessage: 'Even the smallest spark of kindness has the power to dispel the deepest shadow.',
      activityOrRiddle:
          'Idea: Think of one good deed you will do for someone tomorrow.',
    ),
    AdventChapter(
      dayNumber: 21,
      id: 'chapter_21',
      title: 'Winter’s Masterpiece',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(21),
      storyContent:
          'Delicate frost patterns paint fern leaves and crystal palm fronds across windowpanes. '
          'Young elves marvel at winter’s silent, breathtaking gallery of icy art.',
      festiveMessage: 'Art and wonder surround us every day if we simply open our hearts to notice.',
      activityOrRiddle: 'Creative prompt: Draw a quick holiday greeting sketch of a snowman or tree.',
    ),
    AdventChapter(
      dayNumber: 22,
      id: 'chapter_22',
      title: 'Joyful Chiming Bells',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(22),
      storyContent:
          'Only two days until Christmas Eve! Silver sleigh bells chime in rhythmic harmony. '
          'Thousands of gift boxes are wrapped in festive ribbons, ready in the giant velvet sack.',
      festiveMessage: 'Eager anticipation is often as sacred and sweet as the celebration itself.',
      activityOrRiddle: 'Holiday riddle: Which reindeer with a glowing red nose leads Santa’s sleigh? (Answer: Rudolph!)',
    ),
    AdventChapter(
      dayNumber: 23,
      id: 'chapter_23',
      title: 'The Departure Hour',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(23),
      storyContent:
          'The sun sets below the snowy horizon as the entire North Pole gathers to see Santa off. '
          'Santa dons his vibrant red coat, smiles warmly, and waves as the sleigh takes flight into the starry sky.',
      festiveMessage: 'Every journey of love begins with a courageous first step and a sincere heart.',
      activityOrRiddle: 'Idea: Check the Santa Tracker in the app to follow Santa’s flight path around the globe!',
    ),
    AdventChapter(
      dayNumber: 24,
      id: 'chapter_24',
      title: 'A Magical Christmas Night',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(24),
      storyContent:
          'The night of December 24 has arrived! Cathedral bells ring across the peaceful night. '
          'Warm window glows reflect upon the quiet snow. Love, forgiveness, and peace spread to every corner of the earth. '
          'Wishing you and your family a blessed, cozy, and joyful Christmas!',
      festiveMessage: 'Merry Christmas! May your holiday season be filled with wonder, peace, and boundless joy!',
      activityOrRiddle: 'Holiday wish: Give a warm hug to your loved ones and cherish this holy moment together!',
    ),
  ];

  static AdventChapter getChapter(int dayNumber) {
    if (dayNumber < 1 || dayNumber > 24) {
      return allChapters.first;
    }
    return allChapters[dayNumber - 1];
  }
}
