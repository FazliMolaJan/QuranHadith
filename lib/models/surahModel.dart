class SurahsList {
  final List<Surah> surahs;

  SurahsList({this.surahs});

  factory SurahsList.fromJSON(Map<String, dynamic> json) {
    Iterable surahlist = json['data']['surahs'];
    List<Surah> surahsList = surahlist.map((i) => Surah.fromJSON(i)).toList();

    return SurahsList(surahs: surahsList);
  }
}

class Surah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final List<Ayah> ayahs;

  Surah(
      {this.number,
      this.revelationType,
      this.name,
      this.ayahs,
      this.englishName,
      this.englishNameTranslation});

  factory Surah.fromJSON(Map<String, dynamic> json) {
    Iterable ayahs = json['ayahs'];
    List<Ayah> ayahsList = ayahs.map((e) => Ayah.fromJSON((e))).toList();

    return Surah(
        name: json['name'],
        number: json['number'],
        englishName: json['englishName'],
        revelationType: json['revelationType'],
        englishNameTranslation: json['englishNameTranslation'],
        ayahs: ayahsList);
  }
}

class Ayah {
  final String text;
  final int number;

  // final List<Ayah> ayahs;

  Ayah({this.text, this.number});

  factory Ayah.fromJSON(Map<String, dynamic> json) {
    // Iterable audio = json['audio'];
    // List<Ayah> audioList = audio.map((e) => Ayah.fromJSON((e))).toList();

    return Ayah(text: json['text'], number: json['numberInSurah']);
  }
}

class Audio {}
