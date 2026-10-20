class CarModel {
  final String id;
  final String name;
  final String brand;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final String location;
  final int seats;
  final double pricePerDay;
  final String? engineOutput;
  final String? maxSpeed;
  final String? singleChargeOrFuel;
  final String? autopilotType;
  final String? description;
  final String ownerName;
  final String ownerAvatar;
  final bool isOwnerVerified;
  bool isFavorite;

  CarModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.location,
    required this.seats,
    required this.pricePerDay,
    this.engineOutput,
    this.maxSpeed,
    this.singleChargeOrFuel,
    this.autopilotType,
    this.description,
    this.ownerName = 'Hela Quintin',
    this.ownerAvatar = 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
    this.isOwnerVerified = true,
    this.isFavorite = false,
  });

  CarModel copyWith({
    String? id,
    String? name,
    String? brand,
    String? imageUrl,
    double? rating,
    int? reviewsCount,
    String? location,
    int? seats,
    double? pricePerDay,
    String? engineOutput,
    String? maxSpeed,
    String? singleChargeOrFuel,
    String? autopilotType,
    String? description,
    String? ownerName,
    String? ownerAvatar,
    bool? isOwnerVerified,
    bool? isFavorite,
  }) {
    return CarModel(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      location: location ?? this.location,
      seats: seats ?? this.seats,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      engineOutput: engineOutput ?? this.engineOutput,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      singleChargeOrFuel: singleChargeOrFuel ?? this.singleChargeOrFuel,
      autopilotType: autopilotType ?? this.autopilotType,
      description: description ?? this.description,
      ownerName: ownerName ?? this.ownerName,
      ownerAvatar: ownerAvatar ?? this.ownerAvatar,
      isOwnerVerified: isOwnerVerified ?? this.isOwnerVerified,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

// Curated mock data matching the exact cars shown in the Figma screens
final List<CarModel> mockBestCars = [
  CarModel(
    id: 'c1',
    name: 'Ferrari-FF',
    brand: 'Ferrari',
    imageUrl: 'https://purepng.com/public/uploads/large/purepng.com-white-ferrari-carcarferrarivehicletransport-961524653637e1uha.png',
    rating: 5.0,
    reviewsCount: 142,
    location: 'Washington DC',
    seats: 4,
    pricePerDay: 200,
    engineOutput: '650 HP',
    maxSpeed: '335 km/h',
    singleChargeOrFuel: 'V12 Petrol',
    autopilotType: 'Sport Drive',
    description: 'A car with exceptional supercar performance and high luxury comfort rented at an affordable price.',
    isFavorite: false,
  ),
  CarModel(
    id: 'c2',
    name: 'Tesla Model S',
    brand: 'Tesla',
    imageUrl: 'https://pngimg.com/d/tesla_car_PNG23.png',
    rating: 5.0,
    reviewsCount: 108,
    location: 'Chicago, USA',
    seats: 5,
    pricePerDay: 100,
    engineOutput: '670 HP',
    maxSpeed: '250 km/h',
    singleChargeOrFuel: '405 Miles',
    autopilotType: 'Autopilot',
    description: 'A car with high specs that are rented at an affordable price. Full electric range and ultra-smooth torque.',
    isFavorite: true,
  ),
  CarModel(
    id: 'c3',
    name: 'Lamborghini Aventador',
    brand: 'Lamborghini',
    imageUrl: 'https://pngimg.com/d/lamborghini_PNG102905.png',
    rating: 4.9,
    reviewsCount: 89,
    location: 'Washington DC',
    seats: 2,
    pricePerDay: 350,
    engineOutput: '770 HP',
    maxSpeed: '350 km/h',
    singleChargeOrFuel: 'V12 Petrol',
    autopilotType: 'Corsa Track',
    description: 'Unmistakable silhouette, naturally aspirated V12 beast with race-bred dynamics.',
    isFavorite: false,
  ),
  CarModel(
    id: 'c4',
    name: 'BMW GTS3 M2',
    brand: 'BMW',
    imageUrl: 'https://pngimg.com/d/bmw_PNG1707.png',
    rating: 5.0,
    reviewsCount: 76,
    location: 'New York, USA',
    seats: 4,
    pricePerDay: 120,
    engineOutput: '453 HP',
    maxSpeed: '280 km/h',
    singleChargeOrFuel: 'TwinTurbo 3.0L',
    autopilotType: 'Driving Assistant',
    description: 'Compact sports coupe powerhouse built for nimble city driving and thrilling highway acceleration.',
    isFavorite: false,
  ),
];

final List<CarModel> mockNearbyCars = [
  CarModel(
    id: 'c5',
    name: 'BMW M8 Competition',
    brand: 'BMW',
    imageUrl: 'https://pngimg.com/d/bmw_PNG1707.png',
    rating: 4.8,
    reviewsCount: 65,
    location: 'Los Angeles, USA',
    seats: 4,
    pricePerDay: 180,
    engineOutput: '617 HP',
    maxSpeed: '305 km/h',
    singleChargeOrFuel: 'V8 Bi-Turbo',
    autopilotType: 'Active Drive',
    description: 'Executive grand tourer blending track performance with peerless comfort.',
  ),
  CarModel(
    id: 'c6',
    name: 'Ferrari LaFerrari',
    brand: 'Ferrari',
    imageUrl: 'https://purepng.com/public/uploads/large/purepng.com-red-ferrari-carcarferrarivehicletransport-961524653698l6wua.png',
    rating: 5.0,
    reviewsCount: 210,
    location: 'Miami, USA',
    seats: 2,
    pricePerDay: 500,
    engineOutput: '950 HP',
    maxSpeed: '352 km/h',
    singleChargeOrFuel: 'HY-KERS Hybrid',
    autopilotType: 'F1 Dynamics',
    description: 'The pinnacle of Maranello engineering with extreme hybrid hypercar capability.',
  ),
];
