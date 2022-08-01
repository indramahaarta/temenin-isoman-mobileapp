// ignore_for_file: non_constant_identifier_names

class Obat {
  late String penyakit;
  late String penjelasan;
  late String daftar_obat;

  Obat({
    required this.penyakit,
    required this.penjelasan,
    required this.daftar_obat,
  });

  factory Obat.fromJson(Map<String, dynamic> json) => Obat(
        penyakit: json["fields"]["penyakit"],
        penjelasan: json["fields"]["penjelasan"],
        daftar_obat: json["fields"]["daftar_obat"],
      );

  Map<String, dynamic> toJson() => {
        "penyakit": penyakit,
        "penjelasan": penjelasan,
        "daftar_obat": daftar_obat,
      };
}
