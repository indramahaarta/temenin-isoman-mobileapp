class Hospital {
  late int pk;
  late int loc;
  late String nama;
  late String alamat;
  late String telp;
  late int kapasitas;
  late int isi;

  Hospital({
    required this.pk,
    required this.loc,
    required this.nama,
    required this.alamat,
    required this.telp,
    required this.kapasitas,
    required this.isi,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      pk: json['pk'],
      loc: json['fields']['kode_lokasi'],
      nama: json['fields']['nama'],
      alamat: json['fields']['alamat'],
      telp: json['fields']['telp'],
      kapasitas: json['fields']['kapasitas'],
      isi: json['fields']['isi']
    );
  }
}