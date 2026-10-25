import 'package:e_commerce_app/pages/card_payment_page.dart';
import 'package:e_commerce_app/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodSection extends StatelessWidget {
  final Map<String, String>? selectedCardDetails;
  final Function(Map<String, String>) onCardSelected;

  const PaymentMethodSection({
    super.key,
    required this.selectedCardDetails,
    required this.onCardSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method",
          style: GoogleFonts.rubik(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w500,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 45,
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () async {
              final result = await Get.to(() => const CardPaymentScreen());
              if (result != null) {
                onCardSelected(Map<String, String>.from(result));
              }
            },
            icon: const Icon(Icons.credit_card, color: Colors.white),
            label: Text(
              "Enter Card Details",
              style: GoogleFonts.rubik(
                color: Colors.white,
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w400,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: blueColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (selectedCardDetails != null)
          _buildCardPreview(selectedCardDetails!, screenWidth),
      ],
    );
  }

  Widget _buildCardPreview(Map<String, String> card, double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow(
              Icons.credit_card, "Card: ${card['cardNumber']}", screenWidth),
          _infoRow(Icons.calendar_today, "Expiry: ${card['expiryDate']}",
              screenWidth),
          _infoRow(
              Icons.person, "Name: ${card['cardHolderName']}", screenWidth),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: blueColor, size: 18),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.rubik(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
