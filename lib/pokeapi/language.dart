class Language {
  final String name;
  final String url;

  Language(this.name, this.url);

  factory Language.fromJson(Map json) {
    return Language(json['name'], json['url']);
  }
}
