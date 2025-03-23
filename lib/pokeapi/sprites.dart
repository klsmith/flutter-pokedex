class Sprites {
  final String? backDefault;
  final String? backFemale;
  final String? backShiny;
  final String? backShinyFemale;
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;

  Sprites(
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  );

  factory Sprites.fromJson(Map json) {
    return Sprites(
      json['back_default'],
      json['back_female'],
      json['back_shiny'],
      json['back_shiny_female'],
      json['front_default'],
      json['front_female'],
      json['front_shiny'],
      json['front_shiny_female'],
    );
  }
}
