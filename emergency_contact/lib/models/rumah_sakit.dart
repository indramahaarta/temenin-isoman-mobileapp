class RumahSakit {
  late String nama;
  late String alamat;
  late int telepon;
  late int daerah;

  RumahSakit({
    required this.nama,
    required this.alamat,
    required this.telepon,
    required this.daerah,
  });

  // factory method is used to initialize the class with the parameter values of a JSON file
  factory RumahSakit.fromJson(Map<String, dynamic> json) => RumahSakit(
        nama: json["fields"]["nama"],
        alamat: json["fields"]["alamat"],
        telepon: json["fields"]["telepon"],
        daerah: json["fields"]["daerah"],
      );

  Map<String, dynamic> toJson() =>
      {"nama": nama, "alamat": alamat, "telepon": telepon, "daerah": daerah};
}
