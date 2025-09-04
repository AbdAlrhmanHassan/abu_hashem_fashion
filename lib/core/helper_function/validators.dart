String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'الرجاء إدخال البريد الإلكتروني';
  }
  // Add any additional email validation logic here
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'الرجاء إدخال الاسم';
  } else if (value.length < 3) {
    return 'يجب أن يكون الاسم 3 أحرف على الأقل';
  }
  return null;
}

String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'الرجاء إدخال رقم الهاتف';
  } else if (value.length < 10) {
    return 'يجب أن يكون رقم الهاتف 10 أرقام على الأقل';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'الرجاء إدخال كلمة المرور';
  }
  return null;
}

String? validatePasswordConfirmation(String? password, String? confirmPassword) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return 'الرجاء إدخال تأكيد كلمة المرور';
  } else if (password != confirmPassword) {
    return 'كلمة المرور غير متطابقة';
  }
  return null;
}
