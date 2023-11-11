import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:voice_maker/utils/Colors.dart';
import 'Constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Elevated button .....................................>>>
// ignore: must_be_immutable
class elevatedButton extends StatelessWidget {
  VoidCallback? onPress;
  var isStroked = false;
  double? elevation;
  Widget? widget;
  ValueChanged? onFocusChanged;
  Color backgroundColor;
  Color bodersideColor;
  var height;
  var width;
  var borderRadius;
  var looding;

  elevatedButton(
    BuildContext context, {
    Key? key,
    this.looding = false,
    var this.isStroked = false,
    this.onFocusChanged,
    required var this.onPress,
    this.elevation,
    var this.widget,
    var this.backgroundColor = colorPrimary,
    var this.bodersideColor = colorPrimary,
    var this.borderRadius = 10.0,
    var this.height = 55.0,
    var this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ElevatedButton(
          onFocusChange: onFocusChanged,
          onPressed: onPress,
          style: isStroked
              ? ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder())
              : ElevatedButton.styleFrom(
                  elevation: elevation,
                  side: BorderSide(color: bodersideColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)),
                  backgroundColor: backgroundColor,
                ),
          child: looding
              ? const CircularProgressIndicator(
                  color: color_white,
                  strokeWidth: 2,
                )
              : widget),
    );
  }
}

// Elevated button .....................................>>>Finished
// ignore: must_be_immutable
class GradientButton extends StatelessWidget {
  bool? loading;

  Widget? child;
  Gradient? gradientColors;
  Color? buttonbgColor;
  var borderRadius;
  var height, width;
  VoidCallback? onPressed;

  GradientButton(
      {required this.child,
      this.loading,
      this.width = double.infinity,
      required this.onPressed,
      this.height = 60.0,
      this.buttonbgColor = Colors.transparent,
      this.borderRadius = 10.0,
      this.gradientColors =
          const LinearGradient(colors: [Color(0xff9B22C5), Color(0xff6929D1)]),
      super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: gradientColors,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          backgroundColor:
              buttonbgColor, // Make the button background transparent
          elevation: 0, // No elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: loading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: color_white,
                  strokeWidth: 2,
                ),
              )
            : child,
      ),
    );
  }
}

// Text widget .....................................>>>Start
Widget text(String? text,
    {var fontSize = textSizeMedium,
    Color? textColor,
    TextStyle? googleFonts,
    var fontFamily = 'Poppins',
    var isCentered = false,
    var maxLine = 1,
    TextOverflow? overflow,
    var latterSpacing = 0.5,
    bool textAllCaps = false,
    var isLongText = false,
    bool lineThrough = false,
    var fontWeight = FontWeight.w400}
    ) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: overflow,
    style: googleFonts ??
        TextStyle(
          fontFamily: fontFamily,
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: textColor ?? textColorPrimary,
          height: 1.5,
          letterSpacing: latterSpacing,
          decoration:
              lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
        ),
  );
}

class utils {
  // toastMethod .....................
  void toastMethod(message,
      {backgroundColor = Colors.black, textColor = Colors.white}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 16.0);
  }

  // FlushBar Method.....................
  void flushBar(BuildContext context, String message,
      {backgroundColor = Colors.black, textColor = Colors.white}) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeInOut,
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(20),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        messageColor: textColor,
        backgroundColor: backgroundColor,
        messageSize: 15,
      )..show(context),
    );
  }

  // FormFocusChange.....................
  void formFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

// customCircularProgress.....................
class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SpinKitWave(
      color: colorPrimary,
      size: 40,
    );
  }
}

// BlogDescriptionWidget.....................
class HtmlToFlutter extends StatelessWidget {
  final String data;

  HtmlToFlutter({required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Html(
        data: data,
        style: {
          "p": Style(
            fontWeight: FontWeight.w400,
            color: textGreyColor,
            fontSize: FontSize(14.0),
          ),
        },
      ),
    );
  }
}

// Text TextFromFeild...........................................>>>
// ignore: must_be_immutable
class textformfield extends StatelessWidget {
  VoidCallback? onPressed;
  FormFieldValidator<String>? validator;
  FormFieldValidator<String>? onSaved;
  ValueChanged? onChanged;
  TextEditingController? controller;
  ValueChanged<String>? onFieldSubmitted;
  var hight;
  var hinttext;
  var filledColor;
  var suffixIcons;
  var prefixIcons;
  var borderSide;
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var suffixWidth;
  var maxLine;
  bool obscureText;
  TextInputType? keyboardType;
  FocusNode? focusNode;
  textformfield({
    Key? key,
    this.focusNode,
    this.onFieldSubmitted,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.onChanged,
    var this.hight = 50.0,
    this.onPressed,
    var this.suffixWidth = 50.0,
    var this.hinttext,
    var this.filledColor = Colors.white,
    var this.prefixIcons,
    var this.suffixIcons,
    var this.borderSide,
    var this.fontFamily,
    var this.fontSize = textSizeMedium,
    var this.isPassword = false,
    var this.isSecure = false,
    var this.keyboardType,
    var this.maxLine = 1,
    var this.text,
    var this.textColor = textSecondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  blurRadius: 24,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                  color: const Color(0xff000000).withOpacity(.1))
            ]),
        height: hight,
        child: TextFormField(
          maxLines: maxLine,
          focusNode: focusNode,
          keyboardType: keyboardType,
          onFieldSubmitted: onFieldSubmitted,
          controller: controller,
          obscureText: obscureText,
          onTap: onPressed,
          onSaved: onSaved,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
              prefixIcon: prefixIcons,
              suffixIcon: suffixIcons,
              suffixIconConstraints:
                  BoxConstraints(maxHeight: 50, maxWidth: suffixWidth),
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintText: hinttext,
              hintStyle: const TextStyle(fontSize: 12.0)),
        ));
  }
}
// Text TextFromFeild end...........................................>>>

// PinEntryTextField................................................>>
// ignore: must_be_immutable
class PinEntryTextField extends StatefulWidget {
  String? lastPin;
  int fields;
  var onSubmit;
  var fieldWidth;
  var fontSize;
  var isTextObscure;
  var showFieldAsBox;

  PinEntryTextField(
      {this.lastPin,
      this.fields = 4,
      this.onSubmit,
      this.fieldWidth = 40.0,
      this.fontSize = 16.0,
      this.isTextObscure = false,
      this.showFieldAsBox = false})
      : assert(fields > 0);

  @override
  State createState() {
    return PinEntryTextFieldState();
  }
}

class PinEntryTextFieldState extends State<PinEntryTextField> {
  late List<String?> _pin;
  late List<FocusNode?> _focusNodes;
  late List<TextEditingController?> _textControllers;

  Widget textfields = Container();

  @override
  void initState() {
    super.initState();
    _pin = List<String?>.filled(widget.fields, null, growable: false);
    _focusNodes = List<FocusNode?>.filled(widget.fields, null, growable: false);
    _textControllers = List<TextEditingController?>.filled(widget.fields, null,
        growable: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin!.length; i++) {
            _pin[i] = widget.lastPin![i];
          }
        }
        textfields = generateTextFields(context);
      });
    });
  }

  @override
  void dispose() {
    _textControllers.forEach((TextEditingController? t) => t!.dispose());
    super.dispose();
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context);
    });

    if (_pin.first != null) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: textFields);
  }

  void clearTextFields() {
    _textControllers.forEach(
        (TextEditingController? tEditController) => tEditController!.clear());
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context) {
    if (_focusNodes[i] == null) {
      _focusNodes[i] = FocusNode();
    }
    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers[i]!.text = widget.lastPin![i];
      }
    }

    _focusNodes[i]!.addListener(() {
      if (_focusNodes[i]!.hasFocus) {}
    });

    return Container(
      width: widget.fieldWidth,
      margin: EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(),
      child: TextField(
        controller: _textControllers[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: boldTextStyle(
          size: 18,
        ),
        focusNode: _focusNodes[i],
        obscureText: widget.isTextObscure,
        decoration: InputDecoration(
            counterText: "",
            border: widget.showFieldAsBox
                ? const OutlineInputBorder(
                    borderSide: BorderSide(
                    color: redColor,
                  ))
                : null),
        onChanged: (String str) {
          setState(() {
            _pin[i] = str;
          });
          if (i + 1 != widget.fields) {
            _focusNodes[i]!.unfocus();
            if (_pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            } else {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            }
          } else {
            _focusNodes[i]!.unfocus();
            if (_pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            }
          }
          if (_pin.every((String? digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
        onSubmitted: (String str) {
          if (_pin.every((String? digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
      ).paddingOnly(left: spacing_control, right: spacing_control),
    );
  }

  @override
  Widget build(BuildContext context) {
    return textfields;
  }
}

// PinEntryTextField end................................................>>

// CustomOTPCode................................................>>
class CustomOTPCode extends StatelessWidget {
  const CustomOTPCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 68,
          width: 72,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            style: Theme.of(context).textTheme.headlineMedium,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: textGreyColor)),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: colorPrimary),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 68,
          width: 72,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            style: Theme.of(context).textTheme.headlineMedium,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: textGreyColor)),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: colorPrimary),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 68,
          width: 72,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            style: Theme.of(context).textTheme.headlineMedium,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: textGreyColor)),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: colorPrimary),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 68,
          width: 72,
          child: TextFormField(
            style: Theme.of(context).textTheme.headlineMedium,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: textGreyColor)),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: colorPrimary),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
