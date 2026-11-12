import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/app_text_styles.dart';

/// Controls which visual layout the [CarCard] uses.
enum CarCardStyle {
  /// Vertical card — image on top, details below. Used in horizontal
  /// lists (Home "Best Cars") and grids (Search "Recommend For You").
  vertical,

  /// Wide horizontal banner — text on the left, image on the right.
  /// Used in the Home "Nearby" section.
  banner,

  /// Compact horizontal row — image on the left, text on the right.
  /// Used in the Search "Our Popular Cars" section.
  compact,
}

class CarCard extends StatelessWidget {
  final CarModel car;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onBookNow;
  final bool showBookNowButton;
  final double? width;
  final double? height;
  final CarCardStyle style;

  const CarCard({
    super.key,
    required this.car,
    required this.onTap,
    this.onFavoriteToggle,
    this.onBookNow,
    this.showBookNowButton = false,
    this.width,
    this.height,
    this.style = CarCardStyle.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: switch (style) {
        CarCardStyle.vertical => _buildVertical(),
        CarCardStyle.banner => _buildBanner(),
        CarCardStyle.compact => _buildCompact(),
      },
    );
  }

  // ---------------------------------------------------------------------------
  // VERTICAL (original CarCard)
  // ---------------------------------------------------------------------------
  Widget _buildVertical() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isHeightConstrained =
            height != null || constraints.hasBoundedHeight;
        final double maxHeight =
            height ??
            (constraints.hasBoundedHeight ? constraints.maxHeight : 240.0);
        final double imgHeight = isHeightConstrained
            ? (maxHeight * 0.44).clamp(75.0, 120.0)
            : 120.0;

        Widget detailsContent = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: isHeightConstrained
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  car.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleSmall.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 3),
                _ratingRow(),
                const SizedBox(height: 4),
                _locationRow(),
              ],
            ),
            if (!isHeightConstrained) const SizedBox(height: 8),
            if (!showBookNowButton) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: _seatsChip()),
                  const SizedBox(width: 4),
                  _priceTag(fontSize: 13),
                ],
              ),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _priceTag(fontSize: 12),
                  if (onBookNow != null)
                    GestureDetector(
                      onTap: onBookNow,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Book',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ],
        );

        return Container(
          width: width ?? 190,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
            border: Border.all(color: AppColors.cardBorder, width: 1.2),
            boxShadow: AppConstants.cardShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── image + favourite ──
              Stack(
                children: [
                  Container(
                    height: imgHeight,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppConstants.radiusLarge),
                        topRight: Radius.circular(AppConstants.radiusLarge),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _carImage(fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  if (onFavoriteToggle != null) _buildFavouriteButton(),
                ],
              ),

              // ── details ──
              if (isHeightConstrained)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: detailsContent,
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: detailsContent,
                ),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // BANNER (original CarBannerCard)
  // ---------------------------------------------------------------------------
  Widget _buildBanner() {
    return Container(
      height: height ?? 125,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEBECEF),
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  car.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 4),
                _ratingRow(),
                const SizedBox(height: 8),
                _priceTag(),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(flex: 5, child: _carImage(fit: BoxFit.contain)),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // COMPACT (was inline in SearchScreen "Our Popular Cars")
  // ---------------------------------------------------------------------------
  Widget _buildCompact() {
    return Container(
      width: width ?? 260,
      height: height,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder, width: 1.2),
      ),
      child: Row(
        children: [
          Expanded(child: _carImage(fit: BoxFit.contain)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  car.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                _ratingRow(fontSize: 11),
                const SizedBox(height: 6),
                _priceTag(fontSize: 13),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Shared helpers
  // ---------------------------------------------------------------------------

  Widget _carImage({BoxFit fit = BoxFit.contain}) {
    return Image.network(
      car.imageUrl,
      fit: fit,
      errorBuilder: (_, _, _) => const Icon(
        Icons.directions_car,
        size: 60,
        color: AppColors.textMuted,
      ),
    );
  }

  Widget _buildFavouriteButton() {
    return Positioned(
      top: 8,
      right: 8,
      child: GestureDetector(
        onTap: onFavoriteToggle,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 6,
              ),
            ],
          ),
          child: Icon(
            car.isFavorite
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            size: 18,
            color: car.isFavorite ? AppColors.red : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _ratingRow({double fontSize = 12}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          car.rating.toStringAsFixed(1),
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            fontSize: fontSize,
          ),
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.star_rounded,
          size: fontSize + 4,
          color: AppColors.starOrange,
        ),
      ],
    );
  }

  Widget _locationRow() {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 14,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            car.location,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _seatsChip() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.airline_seat_recline_normal_rounded,
          size: 15,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            '${car.seats} Seats',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _priceTag({double? fontSize}) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        '\$${car.pricePerDay.toInt()}/Day',
        style: AppTextStyles.priceTag.copyWith(fontSize: fontSize),
      ),
    );
  }
}
