import 'name.dart';

class Species {
  final int id;
  final String name;
  final List<Name> names;

  Species(this.id, this.name, this.names);

  factory Species.fromJson(Map json) {
    var names = json['names'] as List;
    return Species(
      json['id'],
      json['name'],
      names.map((n) => Name.fromJson(n)).toList(),
    );
  }

  String getEnglishName() {
    return names.firstWhere((n) => n.language.name == 'en').name;
  }
}
