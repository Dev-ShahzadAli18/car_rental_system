import 'package:flutter/material.dart';

class BrandModel {
  final String id;
  final String name;
  final IconData? fallbackIcon;
  final String? logoUrl;
  final bool isSelected;

  const BrandModel({
    required this.id,
    required this.name,
    this.fallbackIcon,
    this.logoUrl,
    this.isSelected = false,
  });

  BrandModel copyWith({
    String? id,
    String? name,
    IconData? fallbackIcon,
    String? logoUrl,
    bool? isSelected,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      fallbackIcon: fallbackIcon ?? this.fallbackIcon,
      logoUrl: logoUrl ?? this.logoUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

// Curated brands list from Figma screens
const List<BrandModel> mockBrands = [
  BrandModel(
    id: 'all',
    name: 'ALL',
    fallbackIcon: Icons.all_inclusive,
    isSelected: true,
  ),
  BrandModel(
    id: 'tesla',
    name: 'Tesla',
    fallbackIcon: Icons.electric_car,
  ),
  BrandModel(
    id: 'lamborghini',
    name: 'Lamborghini',
    fallbackIcon: Icons.speed,
  ),
  BrandModel(
    id: 'bmw',
    name: 'BMW',
    fallbackIcon: Icons.directions_car_filled,
  ),
  BrandModel(
    id: 'ferrari',
    name: 'Ferrari',
    fallbackIcon: Icons.sports_motorsports,
  ),
];
