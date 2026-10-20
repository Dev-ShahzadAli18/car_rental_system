  import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class PriceBreakdownTile extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const PriceBreakdownTile({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: labelStyle ??
                (isTotal
                    ? AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)
                    : AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
          ),
          Text(
            value,
            style: valueStyle ??
                (isTotal
                    ? AppTextStyles.priceTag.copyWith(fontSize: 18)
                    : AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
