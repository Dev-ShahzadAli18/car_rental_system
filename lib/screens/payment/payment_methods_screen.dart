import 'package:flutter/material.dart';
import '../../models/car_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';

class PaymentMethodsScreen extends StatefulWidget {
  final double totalAmount;
  final CarModel car;

  const PaymentMethodsScreen({
    super.key,
    required this.totalAmount,
    required this.car,
  });

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  bool _agreeTerms = true;
  final String _selectedCountry = 'United States';

  final TextEditingController _nameController = TextEditingController(text: 'Benjamin Jack');
  final TextEditingController _emailController = TextEditingController(text: 'benjaminJack@gmail.com');
  final TextEditingController _cardNumberController = TextEditingController(text: '9655 9655 9655 9655');
  final TextEditingController _expiryController = TextEditingController(text: '10/30');
  final TextEditingController _cvcController = TextEditingController(text: '884');
  final TextEditingController _zipController = TextEditingController(text: '60007');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _showCongratulationsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Celebration emoji or icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4DE),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.celebration_rounded,
                    color: Color(0xFFFFB800),
                    size: 44,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'Congratulations',
                style: AppTextStyles.headingMedium.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 10),
              Text(
                'Your car is ready for booking. Your booking has been successfully confirmed. Get ready to start your journey.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Container(
                  height: 54,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark,
                    borderRadius: BorderRadius.circular(27),
                    boxShadow: AppConstants.buttonShadow,
                  ),
                  child: Center(
                    child: Text(
                      'Back to Home',
                      style: AppTextStyles.button.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        type: AppBarType.inner,
        title: 'Payment methods',
        onOptionsTap: () {},
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Stepper (Booking checked -> Payment methods active -> confirmation)
                _buildStepper(),
                const SizedBox(height: 20),

                // Dark Visual Credit Card
                _buildCreditCard(),
                const SizedBox(height: 24),

                // Select Payment Receive Method
                Text(
                  'select payment method',
                  style: AppTextStyles.titleSmall.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder, width: 1.2),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.money_rounded, color: AppColors.textSecondary, size: 22),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Cash payment',
                          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F2F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'DEFAULT',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Card Information Header
                Text(
                  'Card information',
                  style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 12),

                // Full Name
                _buildCardField(controller: _nameController, hint: 'Full Name'),
                const SizedBox(height: 12),

                // Email Address
                _buildCardField(
                  controller: _emailController,
                  hint: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),

                // Card Number with card brand logos
                Container(
                  height: 54,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder, width: 1.2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _cardNumberController,
                          keyboardType: TextInputType.number,
                          style: AppTextStyles.body,
                          decoration: InputDecoration(
                            hintText: 'Card Number',
                            hintStyle: AppTextStyles.subtitle.copyWith(color: AppColors.textMuted),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          _buildBrandBadge('VISA', Colors.blue.shade900),
                          const SizedBox(width: 4),
                          _buildBrandBadge('MC', Colors.red.shade700),
                          const SizedBox(width: 4),
                          _buildBrandBadge('AMEX', Colors.teal.shade800),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Split Expiry & CVC
                Row(
                  children: [
                    Expanded(
                      child: _buildCardField(
                        controller: _expiryController,
                        hint: 'MM / YY',
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 54,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.cardBorder, width: 1.2),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _cvcController,
                                keyboardType: TextInputType.number,
                                obscureText: true,
                                style: AppTextStyles.body,
                                decoration: InputDecoration(
                                  hintText: 'CVC',
                                  hintStyle: AppTextStyles.subtitle.copyWith(color: AppColors.textMuted),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const Icon(Icons.credit_card_rounded, color: AppColors.textSecondary, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Country / Region
                Text(
                  'Country or region',
                  style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 54,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder, width: 1.2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedCountry,
                        style: AppTextStyles.body,
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // ZIP
                _buildCardField(
                  controller: _zipController,
                  hint: 'ZIP',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

                // Terms Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _agreeTerms,
                      activeColor: AppColors.primaryDark,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      onChanged: (val) => setState(() => _agreeTerms = val ?? true),
                    ),
                    Text(
                      'Terms & continue',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Divider Or
                Row(
                  children: [
                    Expanded(child: Container(height: 1, color: AppColors.cardBorder)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        'Pay with card Or',
                        style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                    Expanded(child: Container(height: 1, color: AppColors.cardBorder)),
                  ],
                ),
                const SizedBox(height: 16),

                // Apple Pay Button
                _buildDigitalWalletButton(
                  icon: Icons.apple_rounded,
                  label: 'Apple pay',
                ),
                const SizedBox(height: 12),

                // Google Pay Button
                _buildDigitalWalletButton(
                  icon: Icons.g_mobiledata_rounded,
                  label: 'Google Pay',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Pinned Bottom Button: "Continue"
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: GestureDetector(
              onTap: _showCongratulationsModal,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: AppConstants.buttonShadow,
                ),
                child: Center(
                  child: Text(
                    'Continue',
                    style: AppTextStyles.button.copyWith(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditCard() {
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
                'BANJAMIN JACK',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              Text(
                'Expire: 10-5-2030',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Card Number
          const Text(
            '9655   9655   9655   9655',
            style: TextStyle(
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

  Widget _buildStepper() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Checked step 0
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: AppColors.primaryDark,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 14, color: Colors.white),
            ),
            Container(width: 90, height: 2.5, color: AppColors.primaryDark),
            // Active step 1
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
            Container(width: 90, height: 2.5, color: const Color(0xFFD3D6DC)),
            // Inactive step 2
            Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Color(0xFFD3D6DC),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Booking details',
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
            ),
            Text(
              'Payment methods',
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'confirmation',
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder, width: 1.2),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.subtitle.copyWith(color: AppColors.textMuted),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildBrandBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildDigitalWalletButton({
    required IconData icon,
    required String label,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFEEF0F3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.textPrimary, size: 24),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
