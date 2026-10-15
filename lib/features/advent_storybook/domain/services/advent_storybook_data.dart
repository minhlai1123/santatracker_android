import '../models/advent_chapter.dart';
import 'advent_unlock_rules.dart';

class AdventStorybookData {
  static final List<AdventChapter> allChapters = [
    AdventChapter(
      dayNumber: 1,
      id: 'chapter_1',
      title: 'Món Quà Khởi Đầu',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(1),
      storyContent:
          'Khi cơn gió đông đầu tiên thổi qua những rặng thông tuyết, ngôi làng Bắc Cực thức giấc trong ánh bình minh rạng rỡ. '
          'Ông già Noel mỉm cười mở cuốn nhật ký mùa lễ hội, ghi lại những ước mong bình dị nhất của trẻ em khắp thế giới.',
      festiveMessage: 'Mùa lễ hội đã bắt đầu! Chúc bạn mở đầu tháng 12 với thật nhiều niềm vui và bình an.',
      activityOrRiddle: 'Gợi ý hôm nay: Hãy viết ra 3 điều ước tốt lành bạn muốn gửi tặng người thân yêu nhất.',
    ),
    AdventChapter(
      dayNumber: 2,
      id: 'chapter_2',
      title: 'Bí Mật Xưởng Yêu Tinh',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(2),
      storyContent:
          'Trong căn phòng ấm cúng ngập tràn hương gỗ thông, các chú yêu tinh chăm chỉ gọt đẽo từng chiếc xe lửa gỗ và sơn màu rực rỡ. '
          'Mỗi món đồ chơi không chỉ là món quà, mà còn chứa đựng cả sự tận tâm và niềm vui sáng tạo.',
      festiveMessage: 'Sự kiên nhẫn và đam mê trong từng việc nhỏ sẽ tạo nên những điều kỳ diệu lớn lao.',
      activityOrRiddle: 'Câu đố vui: Cái gì chạy quanh căn phòng nhưng không bao giờ di chuyển? (Đáp án: Bức tường hoặc chiếc đồng hồ treo tường!)',
    ),
    AdventChapter(
      dayNumber: 3,
      id: 'chapter_3',
      title: 'Cỗ Xe Tuần Lộc Bay',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(3),
      storyContent:
          'Dưới bầu trời ngập tràn ánh sao tuyết, chú tuần lộc mũi đỏ Rudolph khẽ lắc bờm, làm vang lên những tiếng chuông bạc lảnh lót. '
          'Đàn tuần lộc đang cùng nhau tập dượt cú hạ cánh êm ái trên những mái nhà phủ đầy tuyết trắng.',
      festiveMessage: 'Hãy tự hào về nét khác biệt của bản thân, vì chính nó sẽ soi sáng con đường bạn đi.',
      activityOrRiddle: 'Hoạt động nhỏ: Hãy ngắm nhìn bầu trời đêm nay và tìm kiếm ngôi sao sáng nhất trên cao.',
    ),
    AdventChapter(
      dayNumber: 4,
      id: 'chapter_4',
      title: 'Câu Đố Chiếc Chuông Vàng',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(4),
      storyContent:
          'Bác yêu tinh lớn tuổi Barnaby mang đến quảng trường chiếc chuông vàng cổ kính được đúc từ thế kỷ trước. '
          'Mỗi khi chiếc chuông ngân vang một nhịp, một bông tuyết hình ngôi sao lại nhẹ nhàng rơi xuống lòng bàn tay.',
      festiveMessage: 'Âm vang của lòng tốt có thể lan tỏa xa hơn bất kỳ âm thanh nào trên thế gian.',
      activityOrRiddle: 'Câu đố Giáng Sinh: Tôi trắng muốt khi rơi từ trời, nhưng tan biến khi bạn sưởi ấm tôi trong tay. Tôi là ai? (Đáp án: Bông tuyết!)',
    ),
    AdventChapter(
      dayNumber: 5,
      id: 'chapter_5',
      title: 'Bông Tuyết Đầu Mùa',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(5),
      storyContent:
          'Cả ngôi làng phủ lên mình một lớp áo choàng pha lê lấp lánh khi trận bão tuyết êm đềm đi qua. '
          'Trẻ nhỏ trong làng cùng nhau xây những bức tường tuyết và nặn chú người tuyết có chiếc mũi bằng củ cà rốt cam rực rỡ.',
      festiveMessage: 'Mỗi bông tuyết là duy nhất, cũng giống như vẻ đẹp độc đáo và trân quý của chính bạn.',
      activityOrRiddle: 'Gợi ý vui: Thưởng thức một cốc nước ấm hoặc sữa nóng có rắc chút quế thơm lừng.',
    ),
    AdventChapter(
      dayNumber: 6,
      id: 'chapter_6',
      title: 'Chiếc Bánh Gừng Tinh Nghịch',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(6),
      storyContent:
          'Căn bếp của bà Claus luôn ngào ngạt mùi mật mía, bơ tươi và bột gừng ấm nồng. '
          'Những chú người bánh gừng vừa ra lò đã ríu rít khoe những chiếc cúc áo bằng kẹo sô-cô-la nhiều màu sắc.',
      festiveMessage: 'Hương vị ấm áp nhất của ngày đông là được quây quần bên mâm cơm gia đình.',
      activityOrRiddle: 'Thử thách nhỏ: Hãy gửi một tin nhắn chúc ngày mới ngọt ngào tới một người bạn thân lâu ngày chưa gặp.',
    ),
    AdventChapter(
      dayNumber: 7,
      id: 'chapter_7',
      title: 'Ngôi Sao Dẫn Đường',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(7),
      storyContent:
          'Trên đỉnh cây thông khổng lồ giữa quảng trường, ngôi sao vàng Polaris bắt đầu tỏa ánh hào quang rực rỡ. '
          'Ánh sáng ấm áp này là ngọn hải đăng soi rọi cho cỗ xe Santa tìm đường trở về qua những đêm sương mù dày đặc.',
      festiveMessage: 'Dù trong đêm tối giá lạnh nhất, luôn có một niềm hy vọng dẫn lối bạn về phía trước.',
      activityOrRiddle: 'Câu đố vui: Cái gì thuộc về bạn nhưng người khác lại dùng nó nhiều hơn bạn? (Đáp án: Tên của bạn!)',
    ),
    AdventChapter(
      dayNumber: 8,
      id: 'chapter_8',
      title: 'Lá Thư Gửi Bắc Cực',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(8),
      storyContent:
          'Bưu điện Bắc Cực ngập tràn trong hàng ngàn phong bì thư viền sọc đỏ trắng. '
          'Có những lá thư xin một chú gấu bông, nhưng cũng có những bức thư chỉ ước mong bố mẹ có thật nhiều sức khỏe và niềm vui.',
      festiveMessage: 'Món quà tuyệt vời nhất không nằm dưới gốc cây thông, mà nằm trong trái tim biết sẻ chia.',
      activityOrRiddle: 'Hoạt động ý nghĩa: Hãy viết lời cảm ơn chân thành gửi đến cha mẹ hoặc người nuôi dưỡng bạn.',
    ),
    AdventChapter(
      dayNumber: 9,
      id: 'chapter_9',
      title: 'Bản Hòa Ca Đêm Đông',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(9),
      storyContent:
          'Dàn hợp xướng yêu tinh đứng thành vòng tròn quanh đống lửa bập bùng, cùng ngân nga giai điệu Silent Night. '
          'Giai điệu du dương hòa cùng tiếng gió xào xạc qua tán lá thông tạo nên khúc nhạc êm dịu làm say lòng người.',
      festiveMessage: 'Âm nhạc mùa lễ hội có sức mạnh kỳ diệu xua tan đi mọi muộn phiền và hàn gắn mọi khoảng cách.',
      activityOrRiddle: 'Gợi ý: Hãy bật một bài nhạc Giáng sinh yêu thích và ngân nga theo điệp khúc rộn ràng.',
    ),
    AdventChapter(
      dayNumber: 10,
      id: 'chapter_10',
      title: 'Trái Tim Ấm Áp Sẻ Chia',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(10),
      storyContent:
          'Chú yêu tinh nhỏ Pip chia sẻ chiếc khăn len quàng cổ màu đỏ duy nhất của mình cho một chú chim sơn ca đang run rẩy vì rét. '
          'Chú nhận ra rằng khi ta trao đi hơi ấm, lòng ta lại càng thêm ấm áp bội phần.',
      festiveMessage: 'Hạnh phúc nhân đôi khi bạn sẵn sàng sẻ chia với những mảnh đời xung quanh.',
      activityOrRiddle: 'Việc làm nhỏ: Dành tặng một nụ cười và lời cảm ơn cho những người phục vụ hoặc nhân viên bạn gặp hôm nay.',
    ),
    AdventChapter(
      dayNumber: 11,
      id: 'chapter_11',
      title: 'Cây Thông Tri Ân',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(11),
      storyContent:
          'Mỗi cành thông tại Bắc Cực đều được treo một tấm thiệp nhỏ ghi lại những điều đáng nhớ trong năm qua. '
          'Có những thành công rực rỡ, nhưng cũng có những bài học quý giá giúp mọi người trưởng thành hơn.',
      festiveMessage: 'Biết ơn quá khứ, trân trọng hiện tại và mỉm cười đón nhận tương lai tươi sáng.',
      activityOrRiddle: 'Tự ngẫm: Kể tên 1 thành tựu hoặc bài học bạn cảm thấy tự hào nhất trong năm vừa qua.',
    ),
    AdventChapter(
      dayNumber: 12,
      id: 'chapter_12',
      title: 'Đố Vui Về Người Tuyết',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(12),
      storyContent:
          'Chú người tuyết Frosty đứng canh bên bờ hồ băng trong vắt. Chú đội một chiếc mũ chóp cao màu đen cổ điển và luôn mỉm cười với bất kỳ ai đi ngang qua. '
          'Frosty thích nhất là được nghe trẻ con kể những câu chuyện hài hước.',
      festiveMessage: 'Tiếng cười sảng khoái chính là liều thuốc kỳ diệu nhất xua tan cái lạnh mùa đông.',
      activityOrRiddle: 'Câu đố vui: Người tuyết thích ăn món gì nhất vào bữa sáng? (Đáp án: Bông tuyết giòn hoặc kem đá bào!)',
    ),
    AdventChapter(
      dayNumber: 13,
      id: 'chapter_13',
      title: 'Đôi Tất Len Lễ Hội',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(13),
      storyContent:
          'Những đôi tất len đan tay kẻ sọc đỏ trắng được treo ngay ngắn phía trên bệ lò sưởi. '
          'Bà Claus bảo rằng những đôi tất này sẽ đựng đầy những viên kẹo ngọt ngào và những lời chúc tốt lành nhất đêm Noel.',
      festiveMessage: 'Những điều giản dị mộc mạc thường chứa đựng tình yêu thương sâu sắc nhất.',
      activityOrRiddle: 'Gợi ý: Tìm một đôi tất ấm áp nhất của bạn để đi giữ ấm cho đôi chân trong mùa lạnh này nhé.',
    ),
    AdventChapter(
      dayNumber: 14,
      id: 'chapter_14',
      title: 'Vũ Điệu Ánh Sáng Cực Quang',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(14),
      storyContent:
          'Màn đêm Bắc Cực bỗng bừng sáng với những dải lụa xanh ngọc lục bảo và tím thạch anh uốn lượn kỳ ảo trên bầu trời. '
          'Đó là ánh cực quang diệu kỳ, báo hiệu ngày lễ hội lớn nhất trong năm đã đến rất gần.',
      festiveMessage: 'Thiên nhiên luôn ẩn chứa những vẻ đẹp diệu kỳ sẵn sàng dành tặng cho những tâm hồn biết ngắm nhìn.',
      activityOrRiddle: 'Thử thách: Tắt màn hình điện thoại trong 15 phút, lắng nghe sự yên tĩnh và hít thở thật sâu.',
    ),
    AdventChapter(
      dayNumber: 15,
      id: 'chapter_15',
      title: 'Chuyến Bay Thử Nghiệm',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(15),
      storyContent:
          'Santa đeo chiếc kính da bảo hộ, bước lên cỗ xe gỗ tuyết tùng và kiểm tra từng đường dây cương mạ vàng. '
          'Cỗ xe vút lên không trung, rẽ mây bay lượn trên dãy núi tuyết trước sự trầm trồ cổ vũ của toàn thể cư dân.',
      festiveMessage: 'Chuẩn bị chu đáo và tự tin là chìa khóa mở cánh cửa dẫn đến thành công.',
      activityOrRiddle: 'Gợi ý chuẩn bị: Lên danh sách những việc bạn muốn hoàn thành trước đêm Giáng Sinh.',
    ),
    AdventChapter(
      dayNumber: 16,
      id: 'chapter_16',
      title: 'Kẹo Gậy Ngọt Ngào',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(16),
      storyContent:
          'Tiệm kẹo ngọt Bắc Cực hôm nay nhộn nhịp hơn bao giờ hết với hàng ngàn chiếc kẹo gậy sọc đỏ trắng thơm mùi bạc hà mát lạnh. '
          'Hình dáng cong như cây gậy chăn cừu tượng trưng cho sự chở che và bình an cho mọi gia đình.',
      festiveMessage: 'Hãy là vị ngọt ngào mang lại niềm vui cho những người xung quanh bạn mỗi ngày.',
      activityOrRiddle: 'Câu đố vui: Cây gì nở hoa quanh năm trong nhà nhưng không cần tưới nước? (Đáp án: Cây thông Noel nhân tạo!)',
    ),
    AdventChapter(
      dayNumber: 17,
      id: 'chapter_17',
      title: 'Ngôi Làng Dưới Ánh Trăng',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(17),
      storyContent:
          'Ánh trăng rằm tròn vành vạnh tỏa ánh bạc dịu dàng xuống mái nhà gỗ phủ đầy tuyết. '
          'Khói bếp từ những lò sưởi bay lên không trung thành những vệt lam êm đềm, mang theo sự ấm cúng khó tả.',
      festiveMessage: 'Sự bình yên trong tâm hồn là món quà vô giá mà không của cải nào sánh bằng.',
      activityOrRiddle: 'Hoạt động: Dọn dẹp lại góc học tập hoặc bàn làm việc cho thật gọn gàng, đón chào ngày mới.',
    ),
    AdventChapter(
      dayNumber: 18,
      id: 'chapter_18',
      title: 'Lời Nhắn Từ Chú Lùn',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(18),
      storyContent:
          'Chú lùn Barnaby gửi gắm một mẩu giấy nhỏ vào đáy mỗi hộp quà: "Đừng bao giờ từ bỏ ước mơ, dù con đường phía trước có tuyết rơi dày đặc đến đâu". '
          'Mỗi thử thách đều là cơ hội để tôi luyện bản lĩnh của bạn.',
      festiveMessage: 'Bạn mạnh mẽ hơn bạn nghĩ, và những nỗ lực thầm lặng của bạn luôn được ghi nhận.',
      activityOrRiddle: 'Gợi ý: Dành cho bản thân một lời khen ngợi vì đã kiên trì vượt qua những ngày khó khăn vừa qua.',
    ),
    AdventChapter(
      dayNumber: 19,
      id: 'chapter_19',
      title: 'Món Quà Vô Hình',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(19),
      storyContent:
          'Có một chiếc hộp quà bằng nhung xanh không chứa đồ vật nào bên trong, chỉ chứa một tấm thiệp ghi chữ: "Thời gian bên nhau". '
          'Ông già Noel bảo đó là món quà quý giá nhất mà con người có thể trao tặng cho nhau trong cuộc sống bận rộn.',
      festiveMessage: 'Món quà chân thành nhất bạn có thể tặng một ai đó chính là sự hiện diện và lắng nghe trọn vẹn.',
      activityOrRiddle: 'Hành động đẹp: Gọi điện thoại thăm hỏi một người thân lớn tuổi trong gia đình bạn hôm nay.',
    ),
    AdventChapter(
      dayNumber: 20,
      id: 'chapter_20',
      title: 'Ngọn Nến Hy Vọng',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(20),
      storyContent:
          'Trên khung cửa sổ ngôi nhà gỗ, một ngọn nến sáp ong vàng ấm áp được thắp lên. '
          'Ngọn lửa nhỏ bé nhảy múa kiên cường trước cơn gió lạnh, xua đi bóng tối và sưởi ấm căn phòng nhỏ.',
      festiveMessage: 'Chỉ một đốm sáng nhỏ của lòng tốt cũng đủ sức đẩy lùi màn đêm tăm tối.',
      activityOrRiddle: 'Gợi ý: Hãy nghĩ về một điều tốt đẹp bạn sẽ làm cho một ai đó vào ngày mai.',
    ),
    AdventChapter(
      dayNumber: 21,
      id: 'chapter_21',
      title: 'Bức Họa Mùa Đông',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(21),
      storyContent:
          'Lớp sương giá trên khung cửa kính tự vẽ nên những bức tranh tuyệt mỹ hình lá cây dương xỉ và cành cọ pha lê. '
          'Các cô bé cậu bé yêu tinh thích thú ngồi ngắm nhìn tuyệt tác nghệ thuật không lời của mùa đông băng giá.',
      festiveMessage: 'Nghệ thuật và sự kỳ diệu luôn hiện hữu quanh ta, chỉ cần ta mở rộng trái tim để cảm nhận.',
      activityOrRiddle: 'Hoạt động sáng tạo: Thử vẽ một tấm thiệp nhỏ hình người tuyết hoặc cây thông Noel.',
    ),
    AdventChapter(
      dayNumber: 22,
      id: 'chapter_22',
      title: 'Tiếng Chuông Ngân Rộn Rã',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(22),
      storyContent:
          'Chỉ còn 2 ngày nữa là đến đêm Giáng Sinh! Tiếng chuông bạc trên xe tuần lộc rung lên nhịp nhàng. '
          'Hàng ngàn chiếc hộp quà đã được buộc nơ đỏ tinh tươm, xếp gọn gàng vào chiếc túi nhung thần kỳ khổng lồ.',
      festiveMessage: 'Sự háo hức đón chờ đôi khi còn thiêng liêng và ngọt ngào hơn chính khoảnh khắc ngày lễ.',
      activityOrRiddle: 'Câu đố vui: Con tuần lộc nào có chiếc mũi đỏ phát sáng dẫn đầu đàn? (Đáp án: Tuần lộc Rudolph!)',
    ),
    AdventChapter(
      dayNumber: 23,
      id: 'chapter_23',
      title: 'Giờ Xuất Hành Kỳ Diệu',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(23),
      storyContent:
          'Mặt trời lặn dần phía chân trời tuyết. Toàn bộ cư dân làng Bắc Cực tập trung đông đủ tiễn đoàn xe của Ông Già Noel. '
          'Bác Santa khoác chiếc áo choàng đỏ rực, tươi cười vẫy tay chào mọi người trước khi cỗ xe cất cánh bay vào không gian bao la.',
      festiveMessage: 'Hành trình trao gửi yêu thương bắt đầu từ những bước chân can đảm và tấm lòng chân thành.',
      activityOrRiddle: 'Gợi ý: Kiểm tra lại Santa Tracker trên ứng dụng để dõi theo hành trình bay của Ông Già Noel nhé!',
    ),
    AdventChapter(
      dayNumber: 24,
      id: 'chapter_24',
      title: 'Đêm Giáng Sinh Diệu Kỳ',
      unlockRuleDescription: AdventUnlockRules.getUnlockDescription(24),
      storyContent:
          'Thời khắc đêm 24 tháng 12 đã điểm! Tiếng chuông giáo đường ngân vang trong đêm thanh tịnh. '
          'Ánh đèn ấm áp từ những khung cửa sổ soi bóng xuống tuyết trắng. Tình yêu thương, sự tha thứ và niềm an lành lan tỏa khắp muôn nơi. '
          'Chúc bạn và gia đình một đêm Giáng Sinh trọn vẹn, ấm áp và hạnh phúc ngập tràn!',
      festiveMessage: 'Merry Christmas! Chúc bạn và những người thân yêu một mùa Giáng Sinh an lành, diệu kỳ và tràn đầy phúc lành!',
      activityOrRiddle: 'Lời chúc trọn vẹn: Hãy dành một cái ôm thật ấm áp cho người thân và cùng nhau tận hưởng khoảnh khắc thiêng liêng này!',
    ),
  ];

  static AdventChapter getChapter(int dayNumber) {
    if (dayNumber < 1 || dayNumber > 24) {
      return allChapters.first;
    }
    return allChapters[dayNumber - 1];
  }
}
