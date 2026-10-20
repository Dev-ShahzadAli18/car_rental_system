import 'package:flutter/material.dart';
import '../../models/car_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../payment/payment_methods_screen.dart';

class BookingDetailsScreen extends StatefulWidget {
  final CarModel car;

  const BookingDetailsScreen({
    super.key,
    required this.car,
  });

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  bool _bookWithDriver = false;
  String _selectedGender = 'Male';
  String _selectedRentalType = 'Day';

  final TextEditingController _nameController = TextEditingController(text: 'Benjamin Jack');
  final TextEditingController _emailController = TextEditingController(text: 'benjaminJack@gmail.com');
  final TextEditingController _phoneController = TextEditingController(text: '+1 (555) 234-5678');
  final TextEditingController _locationController = TextEditingController(text: 'Shore Dr, Chicago 0062 Usa');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        type: AppBarType.inner,
        title: 'Booking Details',
        onOptionsTap: () {},
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Stepper (Booking details -> Payment methods -> confirmation)
                _buildStepper(currentStep: 0),
                const SizedBox(height: 24),

                // Book with driver card
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder, width: 1.2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Book with driver',
                              style: AppTextStyles.titleSmall.copyWith(fontSize: 15),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Don't have a driver? book with driver.",
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _bookWithDriver,
                        onChanged: (val) => setState(() => _bookWithDriver = val),
                        activeThumbColor: Colors.white,
                        activeTrackColor: AppColors.primaryDark,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Full Name Input
                _buildInputField(
                  controller: _nameController,
                  icon: Icons.person_outline_rounded,
                  hint: 'Full Name*',
                ),
                const SizedBox(height: 14),

                // Email Input
                _buildInputField(
                  controller: _emailController,
                  icon: Icons.mail_outline_rounded,
                  hint: 'Email Address*',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 14),

                // Contact Phone Input
                _buildInputField(
                  controller: _phoneController,
                  icon: Icons.phone_outlined,
                  hint: 'Contact*',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 24),

                // Gender Section
                Text(
                  'Gender',
                  style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildGenderPill('Male', Icons.male_rounded),
                    const SizedBox(width: 12),
                    _buildGenderPill('Female', Icons.female_rounded),
                    const SizedBox(width: 12),
                    _buildGenderPill('Others', Icons.transgender_rounded),
                  ],
                ),
                const SizedBox(height: 24),

                // Rental Date & Time Section
                Text(
                  'Rental  Date &Time',
                  style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['Hour', 'Day', 'Weekly', 'Monthly'].map((type) {
                    final isSelected = _selectedRentalType == type;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedRentalType = type),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryDark : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected ? AppColors.primaryDark : AppColors.cardBorder,
                            width: 1.2,
                          ),
                        ),
                        child: Text(
                          type,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 18),

                // Pick up & Return Date Split Card
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder, width: 1.2),
                  ),
                  child: Row(
                    children: [
                      // Pickup Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pick up Date',
                              style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.textSecondary),
                                const SizedBox(width: 6),
                                Text(
                                  '19/ January /2024',
                                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(height: 40, width: 1.2, color: AppColors.divider),
                      const SizedBox(width: 14),
                      // Return Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Return Date',
                              style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.textSecondary),
                                const SizedBox(width: 6),
                                Text(
                                  '22/ January /2024',
                                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Car Location Section
                Text(
                  'Car Location',
                  style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 12),
                _buildInputField(
                  controller: _locationController,
                  icon: Icons.location_on_outlined,
                  hint: 'Location',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Pinned Bottom Button: "$1400  Pay Now"
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PaymentMethodsScreen(
                      totalAmount: 1400,
                      car: widget.car,
                    ),
                  ),
                );
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: AppConstants.buttonShadow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$1400',
                      style: AppTextStyles.button.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'Pay Now',
                      style: AppTextStyles.button.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper({required int currentStep}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStepCircle(0, currentStep >= 0),
            _buildStepLine(currentStep >= 1),
            _buildStepCircle(1, currentStep >= 1),
            _buildStepLine(currentStep >= 2),
            _buildStepCircle(2, currentStep >= 2),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Booking details',
              style: AppTextStyles.caption.copyWith(
                fontWeight: currentStep == 0 ? FontWeight.w700 : FontWeight.w500,
                color: currentStep == 0 ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
            Text(
              'Payment methods',
              style: AppTextStyles.caption.copyWith(
                fontWeight: currentStep == 1 ? FontWeight.w700 : FontWeight.w500,
                color: currentStep == 1 ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
            Text(
              'confirmation',
              style: AppTextStyles.caption.copyWith(
                fontWeight: currentStep == 2 ? FontWeight.w700 : FontWeight.w500,
                color: currentStep == 2 ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepCircle(int step, bool isActive) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryDark : const Color(0xFFD3D6DC),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }

  Widget _buildStepLine(bool isActive) {
    return Container(
      width: 100,
      height: 2.5,
      color: isActive ? AppColors.primaryDark : const Color(0xFFD3D6DC),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
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
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 20),
          const SizedBox(width: 12),
          Expanded(
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
        ],
      ),
    );
  }

  Widget _buildGenderPill(String gender, IconData icon) {
    final isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = gender),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryDark : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppColors.primaryDark : AppColors.cardBorder,
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
            const SizedBox(width: 6),
            Text(
              gender,
              style: AppTextStyles.bodySmall.copyWith(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
