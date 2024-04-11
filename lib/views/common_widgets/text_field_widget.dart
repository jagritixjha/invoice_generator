import 'package:flutter/material.dart';
import 'package:invoice_generator/global_variables/ui_components.dart';
import 'package:invoice_generator/views/common_widgets/text_widget.dart';

class TextFieldWidget extends StatelessWidget {
  IconData? icon;
  String? hint, labelText, validatorVariable;
  String? Function(String?)? validatorFunc;
  void Function(String?)? saveData;
  int? maxline;

  TextFieldWidget({
    super.key,
    this.icon,
    required this.hint,
    required this.labelText,
    required this.validatorVariable,
    required this.validatorFunc,
    required this.saveData,
    this.maxline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            title: labelText!,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            onSaved: saveData,
            validator: validatorFunc,
            initialValue: validatorVariable,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: primaryColor),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.4),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.indigo.shade100,
                  width: 1.4,
                ),
              ),
              // errorText: 'required field',
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Colors.black45,
                fontWeight: FontWeight.w500,
              ),
              // label: TextWidget(
              //   fontSize: 18,
              //   title: labelText!,
              //   color: Colors.black38,
              //   fontWeight: FontWeight.w700,
              // ),
              // contentPadding: const EdgeInsets.only(bottom: 6),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            ),
            maxLines: maxline,
          ),
        ],
      ),
    );
  }
}
