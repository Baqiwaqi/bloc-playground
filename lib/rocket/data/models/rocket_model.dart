class RocketModel {
  Diameter height;
  Diameter diameter;
  Mass mass;

  List<String> flickrImages;
  String name;
  String type;
  bool active;
  int stages;
  int boosters;
  int costPerLaunch;
  int successRatePct;
  String firstFlight;
  String country;
  String company;
  String wikipedia;
  String description;
  String id;

  RocketModel(
      {this.height,
      this.diameter,
      this.mass,
      this.flickrImages,
      this.name,
      this.type,
      this.active,
      this.stages,
      this.boosters,
      this.costPerLaunch,
      this.successRatePct,
      this.firstFlight,
      this.country,
      this.company,
      this.wikipedia,
      this.description,
      this.id});

  RocketModel.fromJson(Map<String, dynamic> json) {
    height =
        json['height'] != null ? new Diameter.fromJson(json['height']) : null;
    diameter = json['diameter'] != null
        ? new Diameter.fromJson(json['diameter'])
        : null;
        //as double
    mass = json['mass'] != null ? new Mass.fromJson(json['mass']) : null;
   
    
  
    flickrImages = json['flickr_images'].cast<String>();
    name = json['name'];
    type = json['type'];
    active = json['active'];
    stages = json['stages'];
    boosters = json['boosters'];
    costPerLaunch = json['cost_per_launch'];
    successRatePct = json['success_rate_pct'];
    firstFlight = json['first_flight'];
    country = json['country'];
    company = json['company'];
    wikipedia = json['wikipedia'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.height != null) {
      data['height'] = this.height.toJson();
    }
    if (this.diameter != null) {
      data['diameter'] = this.diameter.toJson();
    }
    if (this.mass != null) {
      data['mass'] = this.mass.toJson();
    }
    
    data['flickr_images'] = this.flickrImages;
    data['name'] = this.name;
    data['type'] = this.type;
    data['active'] = this.active;
    data['stages'] = this.stages;
    data['boosters'] = this.boosters;
    data['cost_per_launch'] = this.costPerLaunch;
    data['success_rate_pct'] = this.successRatePct;
    data['first_flight'] = this.firstFlight;
    data['country'] = this.country;
    data['company'] = this.company;
    data['wikipedia'] = this.wikipedia;
    data['description'] = this.description;
    data['id'] = this.id;
    return data;
  }
}

class Height {
  double meters;
  int feet;

  Height({this.meters, this.feet});

  Height.fromJson(Map<String, dynamic> json) {
    meters = json['meters'];
    feet = json['feet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meters'] = this.meters;
    data['feet'] = this.feet;
    return data;
  }
}

class Diameter {
  double meters;
  double feet;

  Diameter({this.meters, this.feet});

  Diameter.fromJson(Map<String, dynamic> json) {
    meters = (json['meters']as num).toDouble();
    feet = (json['feet']as num).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meters'] = this.meters;
    data['feet'] = this.feet;
    return data;
  }
}

class Mass {
  int kg;
  int lb;

  Mass({this.kg, this.lb});

  Mass.fromJson(Map<String, dynamic> json) {
    kg = json['kg'];
    lb = json['lb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kg'] = this.kg;
    data['lb'] = this.lb;
    return data;
  }
}

class PayloadWeights {
  String id;
  String name;
  int kg;
  int lb;

  PayloadWeights({this.id, this.name, this.kg, this.lb});

  PayloadWeights.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    kg = json['kg'];
    lb = json['lb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['kg'] = this.kg;
    data['lb'] = this.lb;
    return data;
  }
}