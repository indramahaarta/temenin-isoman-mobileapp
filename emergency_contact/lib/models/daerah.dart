class Daerah {
  late String nama;
  late int pk;

  Daerah({
    required this.nama,
    required this.pk,
  });

  // factory method is used to initialize the class with the parameter values of a JSON file
  factory Daerah.fromJson(Map<String, dynamic> json) => Daerah(
        nama: json["fields"]["daerah"],
        pk: json["pk"],
      );

  Map<String, dynamic> toJson() => {"nama": nama, "pk": pk};
}
