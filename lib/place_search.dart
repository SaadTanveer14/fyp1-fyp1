class Place_Search {
  final String description;
  final String placeId;

  Place_Search({required this.description, required this.placeId});

  factory Place_Search.fromJson(Map<String, dynamic> json) {
    return Place_Search(
        description: json['description'], placeId: json['place_id']);
  }
}
