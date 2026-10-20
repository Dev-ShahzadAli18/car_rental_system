import 'package:flutter/material.dart';
import '../utils/app_text_styles.dart';

class CreditCardWidget extends StatelessWidget {
  final String cardholderName;
  final String expiryDate;
  final String cardNumber;

  const CreditCardWidget({
    super.key,
    this.cardholderName = 'BANJAMIN JACK',
    this.expiryDate = '10-5-2030',
    this.cardNumber = '9655   9655   9655   9655',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E2224), Color(0xFF2C3236)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mastercard circles & VISA logo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 44,
                child: Stack(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEB001B),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned(
                      left: 16,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF79E1B).withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'VISA',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Chip icon
          Container(
            width: 32,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFFE5A93C),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const Spacer(),

          // Cardholder & Expiry
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardholderName,
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              Text(
                'Expire: $expiryDate',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Card Number
          Text(
            cardNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
