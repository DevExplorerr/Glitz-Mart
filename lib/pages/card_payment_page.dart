import 'package:e_commerce_app/global/toast.dart';
import 'package:e_commerce_app/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_fonts/google_fonts.dart';

class CardPaymentScreen extends StatefulWidget {
  final String? initialCardNumber;
  final String? initialExpiryDate;
  final String? initialCardHolderName;
  final String? initialCvvCode;
  const CardPaymentScreen({
    super.key,
    this.initialCardNumber,
    this.initialExpiryDate,
    this.initialCardHolderName,
    this.initialCvvCode,
  });

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cardNumber = widget.initialCardNumber ?? '';
    expiryDate = widget.initialExpiryDate ?? '';
    cardHolderName = widget.initialCardHolderName ?? '';
    cvvCode = widget.initialCvvCode ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: blackColor),
        ),
        backgroundColor: bgColor,
        centerTitle: true,
        title: const Text(
          "Card Details",
          style: TextStyle(color: blackColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                cardBgColor: Colors.black,
                glassmorphismConfig: Glassmorphism(
                  blurX: 12,
                  blurY: 12,
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.3),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (value) {},
              ),
              SizedBox(height: screenHeight * 0.02),
              CreditCardForm(
                formKey: formKey,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                onCreditCardModelChange: (CreditCardModel data) {
                  setState(() {
                    cardNumber = data.cardNumber;
                    expiryDate = data.expiryDate;
                    cardHolderName = data.cardHolderName;
                    cvvCode = data.cvvCode;
                    isCvvFocused = data.isCvvFocused;
                  });
                },
                obscureCvv: true,
                obscureNumber: true,
              ),
              SizedBox(height: screenHeight * 0.04),
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: blueColor,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context, {
                        'cardNumber': cardNumber,
                        'expiryDate': expiryDate,
                        'cardHolderName': cardHolderName,
                      });

                      showToast(message: "Card saved successfully");
                    }
                  },
                  child: Text(
                    "Validate",
                    style: GoogleFonts.rubik(
                      fontSize: screenWidth * 0.045,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
