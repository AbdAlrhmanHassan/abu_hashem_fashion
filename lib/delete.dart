//  final List<String> jordanGovernorates = [
//     'عمان',
//     'إربد',
//     'الزرقاء',
//     'عجلون',
//     'العقبة',
//     'البلقاء',
//     'جرش',
//     'الكرك',
//     'معان',
//     'مادبا',
//     'المفرق',
//     'الطفيلة'
//];
// 
//                DropdownButtonFormField<String>(
//                         decoration: InputDecoration(
//                           border: const OutlineInputBorder(),
//                           hintStyle: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: Colors.grey[700]),
//                           hintText: "اختر المحافظة",
//                         ),
//                         value: selectedGovernorate,
//                         items: jordanGovernorates
//                             .map((governorate) => DropdownMenuItem<String>(
//                                   value: governorate,
//                                   child: Text(governorate),
//                                 ))
//                             .toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             selectedGovernorate = newValue;
//                           });
//                         },
//                         validator: (value) {
//                           if (!isSignUp) {
//                             return null;
//                           } else if (value == null || value.isEmpty) {
//                             return 'الرجاء اختيار المحافظة';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       // TextFormField for entering the location
//                       TextFormField(
//                         controller:
//                             locationController, // Add a controller for location
//                         key: const ValueKey('location'),
//                         keyboardType: TextInputType.streetAddress,
//                         textInputAction: TextInputAction.next,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           focusedBorder: OutlineInputBorder(),
//                           suffixIcon: Icon(Icons.location_on),
//                           hintText: "أدخل موقعك",
//                         ),
//                         validator: (String? value) {
//                           if (isSignUp && (value == null || value.isEmpty)) {
//                             return 'الرجاء إدخال موقعك';
//                           }
//                           return null;
//                         },
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w600, color: Colors.black),
//                         ),