import '../../domain/entities/category.dart';
import '../../domain/entities/word.dart';

// All the words are stored in the app for now.
// Sounds paths start from assets/ because AssetSource adds it.
class LessonLocalDataSource {
  static const _numbers = [
    Word(
      romaji: 'ichi',
      kana: '一 いち',
      english: 'one',
      sound: 'sounds/numbers/number_one_sound.mp3',
      image: 'assets/images/numbers/number_one.png',
    ),
    Word(
      romaji: 'ni',
      kana: '二 に',
      english: 'two',
      sound: 'sounds/numbers/number_two_sound.mp3',
      image: 'assets/images/numbers/number_two.png',
    ),
    Word(
      romaji: 'san',
      kana: '三 さん',
      english: 'three',
      sound: 'sounds/numbers/number_three_sound.mp3',
      image: 'assets/images/numbers/number_three.png',
    ),
    Word(
      romaji: 'shi',
      kana: '四 し',
      english: 'four',
      sound: 'sounds/numbers/number_four_sound.mp3',
      image: 'assets/images/numbers/number_four.png',
    ),
    Word(
      romaji: 'go',
      kana: '五 ご',
      english: 'five',
      sound: 'sounds/numbers/number_five_sound.mp3',
      image: 'assets/images/numbers/number_five.png',
    ),
    Word(
      romaji: 'roku',
      kana: '六 ろく',
      english: 'six',
      sound: 'sounds/numbers/number_six_sound.mp3',
      image: 'assets/images/numbers/number_six.png',
    ),
    Word(
      romaji: 'shichi',
      kana: '七 しち',
      english: 'seven',
      sound: 'sounds/numbers/number_seven_sound.mp3',
      image: 'assets/images/numbers/number_seven.png',
    ),
    Word(
      romaji: 'hachi',
      kana: '八 はち',
      english: 'eight',
      sound: 'sounds/numbers/number_eight_sound.mp3',
      image: 'assets/images/numbers/number_eight.png',
    ),
    Word(
      romaji: 'kyū',
      kana: '九 きゅう',
      english: 'nine',
      sound: 'sounds/numbers/number_nine_sound.mp3',
      image: 'assets/images/numbers/number_nine.png',
    ),
    Word(
      romaji: 'jū',
      kana: '十 じゅう',
      english: 'ten',
      sound: 'sounds/numbers/number_ten_sound.mp3',
      image: 'assets/images/numbers/number_ten.png',
    ),
  ];

  static const _familyMembers = [
    Word(
      romaji: 'chichi',
      kana: '父 ちち',
      english: 'father',
      sound: 'sounds/family_members/father.wav',
      image: 'assets/images/family_members/family_father.png',
    ),
    Word(
      romaji: 'haha',
      kana: '母 はは',
      english: 'mother',
      sound: 'sounds/family_members/mother.wav',
      image: 'assets/images/family_members/family_mother.png',
    ),
    Word(
      romaji: 'sofu',
      kana: '祖父 そふ',
      english: 'grandfather',
      sound: 'sounds/family_members/grandfather.wav',
      image: 'assets/images/family_members/family_grandfather.png',
    ),
    Word(
      romaji: 'sobo',
      kana: '祖母 そぼ',
      english: 'grandmother',
      sound: 'sounds/family_members/grandmother.wav',
      image: 'assets/images/family_members/family_grandmother.png',
    ),
    Word(
      romaji: 'ani',
      kana: '兄 あに',
      english: 'older brother',
      sound: 'sounds/family_members/older_brother.wav',
      image: 'assets/images/family_members/family_older_brother.png',
    ),
    Word(
      romaji: 'ane',
      kana: '姉 あね',
      english: 'older sister',
      sound: 'sounds/family_members/older_sister.wav',
      image: 'assets/images/family_members/family_older_sister.png',
    ),
    Word(
      romaji: 'otōto',
      kana: '弟 おとうと',
      english: 'younger brother',
      sound: 'sounds/family_members/younger_brother.wav',
      image: 'assets/images/family_members/family_younger_brother.png',
    ),
    Word(
      romaji: 'imōto',
      kana: '妹 いもうと',
      english: 'younger sister',
      sound: 'sounds/family_members/younger_sister.wav',
      image: 'assets/images/family_members/family_younger_sister.png',
    ),
    Word(
      romaji: 'musuko',
      kana: '息子 むすこ',
      english: 'son',
      sound: 'sounds/family_members/son.wav',
      image: 'assets/images/family_members/family_son.png',
    ),
    Word(
      romaji: 'musume',
      kana: '娘 むすめ',
      english: 'daughter',
      sound: 'sounds/family_members/daughter.wav',
      image: 'assets/images/family_members/family_daughter.png',
    ),
  ];

  static const _colors = [
    Word(
      romaji: 'aka',
      kana: '赤 あか',
      english: 'red',
      sound: 'sounds/colors/red.wav',
      image: 'assets/images/colors/color_red.png',
    ),
    Word(
      romaji: 'midori',
      kana: '緑 みどり',
      english: 'green',
      sound: 'sounds/colors/green.wav',
      image: 'assets/images/colors/color_green.png',
    ),
    Word(
      romaji: 'chairo',
      kana: '茶色 ちゃいろ',
      english: 'brown',
      sound: 'sounds/colors/brown.wav',
      image: 'assets/images/colors/color_brown.png',
    ),
    Word(
      romaji: 'haiiro',
      kana: '灰色 はいいろ',
      english: 'gray',
      sound: 'sounds/colors/gray.wav',
      image: 'assets/images/colors/color_gray.png',
    ),
    Word(
      romaji: 'kuro',
      kana: '黒 くろ',
      english: 'black',
      sound: 'sounds/colors/black.wav',
      image: 'assets/images/colors/color_black.png',
    ),
    Word(
      romaji: 'shiro',
      kana: '白 しろ',
      english: 'white',
      sound: 'sounds/colors/white.wav',
      image: 'assets/images/colors/color_white.png',
    ),
    Word(
      romaji: 'kiiro',
      kana: '黄色 きいろ',
      english: 'yellow',
      sound: 'sounds/colors/yellow.wav',
      image: 'assets/images/colors/color_yellow.png',
    ),
    Word(
      romaji: 'kusunda kiiro',
      kana: 'くすんだ黄色',
      english: 'dusty yellow',
      sound: 'sounds/colors/dusty_yellow.wav',
      image: 'assets/images/colors/color_dusty_yellow.png',
    ),
  ];

  // phrases don't have pictures
  static const _phrases = [
    Word(
      romaji: 'Anata no namae wa nan desu ka?',
      kana: 'あなたの名前は何ですか？',
      english: 'What is your name?',
      sound: 'sounds/phrases/what_is_your_name.wav',
    ),
    Word(
      romaji: 'Doko ni ikimasu ka?',
      kana: 'どこに行きますか？',
      english: 'Where are you going?',
      sound: 'sounds/phrases/where_are_you_going.wav',
    ),
    Word(
      romaji: 'Kibun wa dō desu ka?',
      kana: '気分はどうですか？',
      english: 'How are you feeling?',
      sound: 'sounds/phrases/how_are_you_feeling.wav',
    ),
    Word(
      romaji: 'Kimasu ka?',
      kana: '来ますか？',
      english: 'Are you coming?',
      sound: 'sounds/phrases/are_you_coming.wav',
    ),
    Word(
      romaji: 'Hai, ikimasu.',
      kana: 'はい、行きます。',
      english: 'Yes, I\'m coming.',
      sound: 'sounds/phrases/yes_im_coming.wav',
    ),
    Word(
      romaji: 'Puroguramingu ga daisuki desu.',
      kana: 'プログラミングが大好きです。',
      english: 'I love programming.',
      sound: 'sounds/phrases/i_love_programming.wav',
    ),
    Word(
      romaji: 'Puroguramingu wa kantan desu.',
      kana: 'プログラミングは簡単です。',
      english: 'Programming is easy.',
      sound: 'sounds/phrases/programming_is_easy.wav',
    ),
    Word(
      romaji: 'Anime ga daisuki desu.',
      kana: 'アニメが大好きです。',
      english: 'I love anime.',
      sound: 'sounds/phrases/i_love_anime.wav',
    ),
    Word(
      romaji: 'Channeru tōroku o wasurenaide ne.',
      kana: 'チャンネル登録を忘れないでね。',
      english: 'Don\'t forget to subscribe.',
      sound: 'sounds/phrases/dont_forget_to_subscribe.wav',
    ),
  ];

  static const _words = {
    'numbers': _numbers,
    'family_members': _familyMembers,
    'colors': _colors,
    'phrases': _phrases,
  };

  List<Category> getCategories() {
    return [
      Category(
        id: 'numbers',
        title: 'Numbers',
        japaneseTitle: '数字 · すうじ',
        stamp: '数',
        color: 0xFFF59E0B,
        wordCount: _numbers.length,
        level: 'Basic',
      ),
      Category(
        id: 'family_members',
        title: 'Family Members',
        japaneseTitle: '家族 · かぞく',
        stamp: '家',
        color: 0xFF22A06B,
        wordCount: _familyMembers.length,
        level: 'Basic',
      ),
      Category(
        id: 'colors',
        title: 'Colors',
        japaneseTitle: '色 · いろ',
        stamp: '色',
        color: 0xFFEC4899,
        wordCount: _colors.length,
        level: 'Basic',
      ),
      Category(
        id: 'phrases',
        title: 'Phrases',
        japaneseTitle: '会話 · かいわ',
        stamp: '話',
        color: 0xFF3B82F6,
        wordCount: _phrases.length,
        level: 'Intermediate',
      ),
    ];
  }

  List<Word> getWords(String categoryId) {
    final words = _words[categoryId];
    if (words == null) {
      throw Exception('No category with id $categoryId');
    }
    return words;
  }
}
