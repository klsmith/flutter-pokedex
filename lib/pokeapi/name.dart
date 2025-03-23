import 'language.dart';

class Name {
  final String name;
  final Language language;

  Name(this.name, this.language);

  factory Name.fromJson(Map json) {
    return Name(json['name'], Language.fromJson(json['language']));
  }
}
