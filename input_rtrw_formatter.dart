bool isRtRwFormatter(String value) {
  // Regex pattern for 3 digits followed by a forward slash (/) and then another 3 digits
  const String regexPattern = r'^\d{3}/\d{3}$'; 
  RegExp regex = RegExp(regexPattern);
  return (!regex.hasMatch(value)) ? false : true;
}


class SlashInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String formattedValue = newValue.text;

    // Add a forward slash after the user types 3 digits
    if (newValue.text.length == 3 && oldValue.text.length < newValue.text.length) {
      formattedValue += '/';
    }

    // Remove the slash and digits after it when the user deletes the slash
    if (oldValue.text.endsWith('/') && newValue.text.length < oldValue.text.length) {
      formattedValue = formattedValue.substring(0, formattedValue.length - 1);
    }

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}