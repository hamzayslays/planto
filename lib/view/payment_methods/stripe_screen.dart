import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planto/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../view_model/payment_methods/stripe_view_model.dart';
import '../../widgets/pay_fields.dart';

class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen({Key? key}) : super(key: key);

  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<StripePaymentViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Stripe Payment",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: vm.formKey,
          child: Column(
            children: [
              CustomTextField(
                label: "Cardholder Name",
                onSaved: vm.saveCardName,
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                label: "Card Number",
                onSaved: vm.saveCardNumber,
                keyboardType: TextInputType.number,
                hint: "XXXX XXXX XXXX XXXX",
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: "Expiry MM",
                      onSaved: vm.saveExpiryMonth,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: CustomTextField(
                      label: "Expiry YY",
                      onSaved: vm.saveExpiryYear,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: CustomTextField(
                      label: "CVC",
                      onSaved: vm.saveCVC,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                label: "Billing Email",
                onSaved: vm.saveEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.h),
              CustomButtons(
                name: "Save info",
                onPressed: (){
                   vm.processPayment(context);
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
