

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

  Map<String, dynamic> toJson() => {
    "eventDetails": eventDetails?.toJson(),
    "Ratings": ratings == null ? [] : List<dynamic>.from(ratings!.map((x) => x.toJson())),
    "overAllRatings": overAllRatings,
  };
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
   bool? isBooked;

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
    this.isBooked,
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
    isBooked: json["isBooked"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "name": name,
    "date": date?.toIso8601String(),
    "time": time,
    "ticketLink": ticketLink,
    "coverPhoto": coverPhoto?.toJson(),
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x.toJson())),
    "details": details,
    "address": address,
    "location": location?.toJson(),
    "category": category,
    "filters": filters == null ? [] : List<dynamic>.from(filters!.map((x) => x.toJson())),
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
    "isBooked": isBooked,
  };
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

  Map<String, dynamic> toJson() => {
    "name": name,
    "subfilters": subfilters == null ? [] : List<dynamic>.from(subfilters!.map((x) => x.toJson())),
  };
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
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

class Review {
  final String? id;
  final Message? message;
  final DateTime? createdAt;
  final User? user;
  final List<Rating>? rating;
  final double? avgRating;

  Review({
    this.id,
    this.message,
    this.createdAt,
    this.user,
    this.rating,
    this.avgRating,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["_id"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    rating: json["rating"] == null ? [] : List<Rating>.from(json["rating"]!.map((x) => Rating.fromJson(x))),
    avgRating: json["avgRating"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "message": message?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "user": user?.toJson(),
    "rating": rating == null ? [] : List<dynamic>.from(rating!.map((x) => x.toJson())),
    "avgRating": avgRating,
  };
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

  Map<String, dynamic> toJson() => {
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x.toJson())),
    "comment": comment,
  };
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

  Map<String, dynamic> toJson() => {
    "title": title,
    "value": value,
  };
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

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "name": name,
    "email": email,
  };
}
