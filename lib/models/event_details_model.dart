

class EventDetailsModel {
  final EventDetails? eventDetails;
  final List<Rating>? ratings;
  final double? overAllRatings;

  EventDetailsModel({
    this.eventDetails,
    this.ratings,
    this.overAllRatings,
  });

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) => EventDetailsModel(
    eventDetails: json["eventDetails"] == null ? null : EventDetails.fromJson(json["eventDetails"]),
    ratings: json["Ratings"] == null ? [] : List<Rating>.from(json["Ratings"]!.map((x) => Rating.fromJson(x))),
    overAllRatings: json["overAllRatings"]?.toDouble(),
  );
}

class EventDetails {
  final String? id;
  final String? userId;
  final String? name;
  final DateTime? date;
  final String? time;
  final String? ticketLink;
  final Photo? coverPhoto;
  final List<Photo>? photos;
  final String? details;
  final String? address;
  final Location? location;
  final String? category;
  final List<Filter>? filters;
  final List<Review>? reviews;

  EventDetails({
    this.id,
    this.userId,
    this.name,
    this.date,
    this.time,
    this.ticketLink,
    this.coverPhoto,
    this.photos,
    this.details,
    this.address,
    this.location,
    this.category,
    this.filters,
    this.reviews,
  });

  factory EventDetails.fromJson(Map<String, dynamic> json) => EventDetails(
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"],
    ticketLink: json["ticketLink"],
    coverPhoto: json["coverPhoto"] == null ? null : Photo.fromJson(json["coverPhoto"]),
    photos: json["photos"] == null ? [] : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
    details: json["details"],
    address: json["address"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    category: json["category"],
    filters: json["filters"] == null ? [] : List<Filter>.from(json["filters"]!.map((x) => Filter.fromJson(x))),
    reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
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
}

class Filter {
  final String? name;
  final List<Subfilter>? subfilters;

  Filter({
    this.name,
    this.subfilters,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    name: json["name"],
    subfilters: json["subfilters"] == null ? [] : List<Subfilter>.from(json["subfilters"]!.map((x) => Subfilter.fromJson(x))),
  );
}

class Subfilter {
  final String? id;
  final String? value;

  Subfilter({
    this.id,
    this.value,
  });

  factory Subfilter.fromJson(Map<String, dynamic> json) => Subfilter(
    id: json["id"],
    value: json["value"],
  );
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
}

class Review {
  final String? id;
  final Message? message;
  final List<RatingElement>? rating;
  final DateTime? createdAt;
  final User? user;
  final double? avgRating;

  Review({
    this.id,
    this.message,
    this.rating,
    this.createdAt,
    this.user,
    this.avgRating,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["_id"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    rating: json["rating"] == null ? [] : List<RatingElement>.from(json["rating"]!.map((x) => RatingElement.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    avgRating: json["avgRating"]?.toDouble(),
  );
}

class Message {
  final List<Photo>? photos;
  final String? comment;

  Message({
    this.photos,
    this.comment,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    photos: json["photos"] == null ? [] : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
    comment: json["comment"],
  );
}

class RatingElement {
  final double? music;
  final int? service;
  final int? crowd;

  RatingElement({
    this.music,
    this.service,
    this.crowd,
  });

  factory RatingElement.fromJson(Map<String, dynamic> json) => RatingElement(
    music: json["music"]?.toDouble(),
    service: json["service"],
    crowd: json["crowd"],
  );
}

class User {
  final String? id;
  final String? image;
  final String? name;
  final String? email;

  User({
    this.id,
    this.image,
    this.name,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    image: json["image"],
    name: json["name"],
    email: json["email"],
  );
}

class Rating {
  final String? title;
  final double? value;

  Rating({
    this.title,
    this.value,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    title: json["title"],
    value: json["value"]?.toDouble(),
  );
}
