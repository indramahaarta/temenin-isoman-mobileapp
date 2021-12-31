class Daerah {
  late String daerah;
  late int pk;

  Daerah({
    required this.daerah,
    required this.pk,
  });

  // factory method is used to initialize the class with the parameter values of a JSON file
  factory Daerah.fromJson(Map<String, dynamic> json) => Daerah(
        daerah: json["fields"]["daerah"],
        pk: json["pk"],
      );

  Map<String, dynamic> toJson() => {"daerah": daerah, "pk": pk};
}
