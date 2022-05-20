import 'package:curioso_app/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final GlobalKey<FormFieldState>? fieldKey;
  final bool? enabled;
  final bool? hideErrors;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? maskFormatter;
  final int? maxLenght;
  final bool? obscureText;
  final void Function(String)? onChangedField;
  final String? placeholderText;
  final Widget? prefix;
  final bool? tooglePassword;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  const CustomInput({
    Key? key,
    required this.controller,
    required this.label,
    this.focusNode,
    this.fieldKey,
    this.enabled,
    this.hideErrors,
    this.keyboardType,
    this.maskFormatter,
    this.maxLenght,
    this.obscureText,
    this.onChangedField,
    this.placeholderText,
    this.prefix,
    this.tooglePassword,
    this.validator,
  }) : super(key: key);

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool isObscure = false;
  bool toogleObscure = true;

  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    isObscure = (widget.tooglePassword != null && widget.tooglePassword!)
        ? true
        : widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final List<TextInputFormatter>? inputformatters =
        (widget.maskFormatter != null) ? widget.maskFormatter! : [];
    inputformatters!.add(LengthLimitingTextInputFormatter(widget.maxLenght));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: CuriosityColors.gray),
            textAlign: TextAlign.start),
        const SizedBox(
          height: 4,
        ),
        Focus(
          child: Listener(
            onPointerDown: (_) {
              FocusScope.of(context).requestFocus(_focusNode);
            },
            child: TextFormField(
              key: _fieldKey,
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              focusNode: widget.focusNode,
              textCapitalization: TextCapitalization.none,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: (isObscure) ? toogleObscure : isObscure,
              onChanged: widget.onChangedField,
              inputFormatters: inputformatters,
              decoration: InputDecoration(
                hintText: widget.placeholderText,
                prefixIcon: widget.prefix,
                suffixIcon: (isObscure)
                    ? IconButton(
                        icon: (toogleObscure)
                            ? const Icon(Icons.lock)
                            : const Icon(Icons.lock_open),
                        iconSize: 16.0,
                        color: CuriosityColors.mountainMist,
                        onPressed: () =>
                            setState(() => toogleObscure = !toogleObscure),
                      )
                    : null,
                errorStyle: (widget.hideErrors ?? false)
                    ? const TextStyle(height: 0)
                    : null,
              ),
              enabled: widget.enabled,
              validator: widget.validator,
            ),
          ),
          focusNode: _focusNode,
          onFocusChange: (hasFocus) {
            if (!hasFocus) {
              if(widget.fieldKey?.currentState != null) {
                widget.fieldKey?.currentState!.validate();
              }
            }
          },
        ),
      ],
    );
  }
}
