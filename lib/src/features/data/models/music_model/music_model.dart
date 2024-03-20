class MusicModel {
  final String musicName;
  final String author;
  final String cover;
  final String path;
  MusicModel(
      {required this.musicName, required this.author, required this.cover, required this.path});

  @override
  String toString() {
    return 'MusicModel{musicName: $musicName, author: $author, cover: $cover, path: $path}';
  }
}

List<MusicModel> musicList = [
  MusicModel(
      musicName: "Круговорот",
      author: "Мияги",
      cover:
          "https://cdn.promodj.com/afs/d61bbf33c41e8889eb85649e5cc405bf12%3Aresize%3A2000x2000%3Asame%3A2ca899",
      path: "music/Круговорот.mp3")
];
