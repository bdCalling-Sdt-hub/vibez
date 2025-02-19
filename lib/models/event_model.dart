

class EventModel {
  final String? id;
  final String? userId;
  final String? name;
  final DateTime? date;
  final String? time;
  final String? ticketLink;
  final Photo? coverPhoto;
  final List<Photo>? photos;
  final String? details;
  final Location? location;
  final String? category;
  final List<Filter>? filters;

  EventModel({
    this.id,
    this.userId,
    this.name,
    this.date,
    this.time,
    this.ticketLink,
    this.coverPhoto,
    this.photos,
    this.details,
    this.location,
    this.category,
    this.filters,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"],
    ticketLink: json["ticketLink"],
    coverPhoto: json["coverPhoto"] == null ? null : Photo.fromJson(json["coverPhoto"]),
    photos: json["photos"] == null ? [] : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
    details: json["details"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    category: json["category"],
    filters: json["filters"] == null ? [] : List<Filter>.from(json["filters"]!.map((x) => Filter.fromJson(x))),
  );
}

class Photo {
  final String? publicFileUrl;
  final String? path;
  final String? id;

  Photo({
    this.publicFileUrl,
    this.path,
    this.id,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    publicFileUrl: json["publicFileURL"],
    path: json["path"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileURL": publicFileUrl,
    "path": path,
    "_id": id,
  };
}

class Filter {
  final List<dynamic>? subfilters;

  Filter({
    this.subfilters,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    subfilters: json["subfilters"] == null ? [] : List<dynamic>.from(json["subfilters"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "subfilters": subfilters == null ? [] : List<dynamic>.from(subfilters!.map((x) => x)),
  };
}

class Location {
  final String? type;
  final List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}
