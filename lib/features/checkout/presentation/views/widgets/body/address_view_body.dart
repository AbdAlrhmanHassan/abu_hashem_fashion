import 'dart:async';
import 'dart:developer';

import 'package:abu_hashem_fashion/core/data/models/user_address_model.dart';
import 'package:abu_hashem_fashion/core/helper_function/validators.dart';
import 'package:abu_hashem_fashion/core/widgets/custom_elevated_button.dart';
import 'package:abu_hashem_fashion/features/auth/presintation/admin/cubit/auth_cubit.dart';
import 'package:abu_hashem_fashion/features/checkout/presentation/views/review_order_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/custom_text_field.dart';
import '../checkout_status_row.dart';

class AddressViewBody extends StatefulWidget {
  const AddressViewBody({super.key});

  @override
  State<AddressViewBody> createState() => _AddressViewBodyState();
}

class _AddressViewBodyState extends State<AddressViewBody> {
  UserAddressModel? addressModel;

  @override
  void initState() {
    getUserAddress();

    super.initState();
  }

  Future<void> getUserAddress() async {
    addressModel = await BlocProvider.of<Authcubit>(context).getUserAddress();
    log('is null ? ${addressModel?.apartmentNumber == null}');
    if (addressModel != null) {
      setState(() {
        selectedGovernorate = addressModel!.governorate;
        addressController.text = addressModel!.address;
        cityController.text = addressModel!.city;
        apartmentNumberController.text = addressModel?.apartmentNumber ?? '';
      });
    }
  }

  bool switchV = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController apartmentNumberController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final List<String> jordanGovernorates = [
    'عمان',
    'إربد',
    'الزرقاء',
    'عجلون',
    'العقبة',
    'البلقاء',
    'جرش',
    'الكرك',
    'معان',
    'مادبا',
    'المفرق',
    'الطفيلة'
  ];

  String? selectedGovernorate;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Authcubit, AuthcubitState>(
      builder: (context, state) {
        if (state is AuthcubitLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CheckoutStatusRow(statusNumber: 1),
              const SizedBox(height: 24),

              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: autovalidateMode,
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700]),
                            hintText: "اختر المحافظة",
                          ),
                          value: selectedGovernorate,
                          items:
                              List.generate(jordanGovernorates.length, (index) {
                            return DropdownMenuItem<String>(
                              value: jordanGovernorates[index],
                              child: Text(
                                jordanGovernorates[index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGovernorate = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء اختيار المحافظة';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          textInputAction: TextInputAction.next,

                          controller: cityController,
                          hintText: 'المدينة',
                          validator:
                              validateName, // You might want a custom validator for this
                        ),
                        const SizedBox(height: 8),
                        // Address Field
                        CustomTextField(
                          textInputAction: TextInputAction.next,
                          controller: addressController,
                          hintText: 'العنوان',
                          validator:
                              validateName, // You might want a custom validator for this
                        ),
                        const SizedBox(height: 8),

                        // City Field

                        // Floor and Apartment Number Field
                        CustomTextField(
                          controller: apartmentNumberController,
                          keyboardType: TextInputType.number,
                          hintText: 'رقم الشقه',
                          validator: (value) {
                            return null;
                          },
                          // Custom validator using validateField function
                        ),
                        const SizedBox(height: 16),

                        // Save Address Switch
                        Row(
                          children: [
                            CupertinoSwitch(
                              activeColor: Colors.blue[400],
                              value: switchV,
                              onChanged: (value) {
                                setState(() {
                                  switchV = value;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'حفظ العنوان',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Next Button
              CustomElevatedButton(
                childV: isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      )
                    : const Text('التالي'),
                onPressedF: () async {
                  autovalidateMode = AutovalidateMode.always;
                  setState(() {});
                  if (_formKey.currentState!.validate()) {
                    UserAddressModel userAddressModel = UserAddressModel(
                      governorate: selectedGovernorate!,
                      city: cityController.text,
                      address: addressController.text,
                      apartmentNumber: apartmentNumberController.text.isEmpty
                          ? null
                          : apartmentNumberController.text,
                    );

                    if (switchV) {
                      await BlocProvider.of<Authcubit>(context)
                          .saveUserAddress(userAddressModel: userAddressModel);
                    }

                    Navigator.pushNamed(context, ReviewOrderView.routeName,
                        arguments: userAddressModel);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}



          
                      // const SizedBox(height: 20),
                      // // TextFormField for entering the location
                      // TextFormField(
                      //   controller:
                      //       locationController, // Add a controller for location
                      //   key: const ValueKey('location'),
                      //   keyboardType: TextInputType.streetAddress,
                      //   textInputAction: TextInputAction.next,
                      //   decoration: const InputDecoration(
                      //     border: OutlineInputBorder(),
                      //     focusedBorder: OutlineInputBorder(),
                      //     suffixIcon: Icon(Icons.location_on),
                      //     hintText: "أدخل موقعك",
                      //   ),
                      //   validator: (String? value) {
                      //     if (isSignUp && (value == null || value.isEmpty)) {
                      //       return 'الرجاء إدخال موقعك';
                      //     }
                      //     return null;
                      //   },
                      //   style: const TextStyle(
                      //       fontWeight: FontWeight.w600, color: Colors.black),
                      //   ),