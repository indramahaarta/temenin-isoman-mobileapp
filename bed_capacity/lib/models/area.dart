class Area {
  late int pk;
  late String name;

  Area({
    required this.pk,
    required this.name,

  });

  factory Area.fromJson(Map<String,dynamic> json) {
    return Area(
      pk: json['pk'],
      name: json['fields']['nama'],
    );
  }
}