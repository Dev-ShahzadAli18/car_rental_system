import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import '../../models/car_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/booking_stepper.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/selection_pill.dart';
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

  void _openPayment() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PaymentMethodsScreen(
          totalAmount: 1400,
          car: widget.car,
        ),
      ),
    );
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
          ResponsiveContentWrapper(
            maxWidth: 700,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BookingStepper(currentStep: 0),
                  const SizedBox(height: 24),
                  _buildDriverSwitch(),
                  const SizedBox(height: 18),
                  _buildContactFields(),
                  const SizedBox(height: 24),
                  _buildGenderSection(),
                  const SizedBox(height: 24),
                  _buildRentalSection(),
                  const SizedBox(height: 24),
                  _buildLocationSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          _buildPayButton(),
        ],
      ),
    );
  }

  Widget _buildDriverSwitch() {
    return Container(
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
    );
  }

  Widget _buildContactFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppInputField(
          controller: _nameController,
          prefixIcon: Icons.person_outline_rounded,
          hint: 'Full Name*',
        ),
        const SizedBox(height: 14),
        AppInputField(
          controller: _emailController,
          prefixIcon: Icons.mail_outline_rounded,
          hint: 'Email Address*',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 14),
        AppInputField(
          controller: _phoneController,
          prefixIcon: Icons.phone_outlined,
          hint: 'Contact*',
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildGenderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            SelectionPill(
              label: 'Male',
              icon: Icons.male_rounded,
              isSelected: _selectedGender == 'Male',
              onTap: () => setState(() => _selectedGender = 'Male'),
            ),
            SelectionPill(
              label: 'Female',
              icon: Icons.female_rounded,
              isSelected: _selectedGender == 'Female',
              onTap: () => setState(() => _selectedGender = 'Female'),
            ),
            SelectionPill(
              label: 'Others',
              icon: Icons.transgender_rounded,
              isSelected: _selectedGender == 'Others',
              onTap: () => setState(() => _selectedGender = 'Others'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRentalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rental  Date &Time',
          style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Hour', 'Day', 'Weekly', 'Monthly'].map((type) {
            return SelectionPill(
              label: type,
              isSelected: _selectedRentalType == type,
              onTap: () => setState(() => _selectedRentalType = type),
            );
          }).toList(),
        ),
        const SizedBox(height: 18),
        _buildDateCard(),
      ],
    );
  }

  Widget _buildDateCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder, width: 1.2),
      ),
      child: Row(
        children: [
          Expanded(child: _buildDateColumn('Pick up Date', '19/ January /2024')),
          Container(height: 40, width: 1.2, color: AppColors.divider),
          const SizedBox(width: 14),
          Expanded(child: _buildDateColumn('Return Date', '22/ January /2024')),
        ],
      ),
    );
  }

  Widget _buildDateColumn(String title, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.textSecondary),
            const SizedBox(width: 6),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  date,
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Car Location',
          style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 12),
        AppInputField(
          controller: _locationController,
          prefixIcon: Icons.location_on_outlined,
          hint: 'Location',
        ),
      ],
    );
  }

  Widget _buildPayButton() {
    return ResponsiveBottomBar(
      child: GestureDetector(
        onTap: _openPayment,
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
    );
  }
}
