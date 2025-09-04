import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import 'widgets/body/address_view_body.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});
  static const routeName = 'AddressView';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
          title: customAppName(),
        ),
      body: const AddressViewBody(),
    );
  }
}
