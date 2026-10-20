import 'package:flutter/material.dart';
import '../../models/car_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/booking_stepper.dart';
import '../../widgets/congratulations_modal.dart';
import '../../widgets/credit_card_widget.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/digital_wallet_button.dart';

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
                
                const BookingStepper(currentStep: 1),
                const SizedBox(height: 20),

                const CreditCardWidget(),
                const SizedBox(height: 24),

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

                Text(
                  'Card information',
                  style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 12),

                AppInputField(
                  controller: _nameController,
                  hint: 'Full Name',
                ),
                const SizedBox(height: 12),

                AppInputField(
                  controller: _emailController,
                  hint: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),

                AppInputField(
                  controller: _cardNumberController,
                  hint: 'Card Number',
                  keyboardType: TextInputType.number,
                  suffixWidget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildBrandBadge('VISA', Colors.blue.shade900),
                      const SizedBox(width: 4),
                      _buildBrandBadge('MC', Colors.red.shade700),
                      const SizedBox(width: 4),
                      _buildBrandBadge('AMEX', Colors.teal.shade800),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: AppInputField(
                        controller: _expiryController,
                        hint: 'MM / YY',
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppInputField(
                        controller: _cvcController,
                        hint: 'CVC',
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        suffixWidget: const Icon(Icons.credit_card_rounded, color: AppColors.textSecondary, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

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

                AppInputField(
                  controller: _zipController,
                  hint: 'ZIP',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

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

                const DigitalWalletButton(
                  icon: Icons.apple_rounded,
                  label: 'Apple pay',
                ),
                const SizedBox(height: 12),
                const DigitalWalletButton(
                  icon: Icons.g_mobiledata_rounded,
                  label: 'Google Pay',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: GestureDetector(
              onTap: () => CongratulationsModal.show(context),
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
}
