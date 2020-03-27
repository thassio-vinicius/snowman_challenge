import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/pincolor_provider.dart';
import 'package:snowmanchallenge/utils/custom_fonts.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class CustomColorPicker extends StatefulWidget {
  @override
  _CustomColorPickerState createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  Color _currentPinColor;

  @override
  void didChangeDependencies() {
    _currentPinColor =
        Provider.of<PinColorProvider>(context, listen: false).currentColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsPadding:
          EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.22),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      actions: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              /*
              _pinController.text = '#' +
                  pickerColor
                      .toString()
                      .toUpperCase()
                      .substring(9)
                      .replaceAll(
                        ')',
                        '',
                      );

               */
            });

            print('color confirm pin color:' + _currentPinColor.toString());
            Navigator.pop(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.08,
            decoration: BoxDecoration(
              color: HexColor('#FFBE00'),
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Confirm color',
                  style: TextStyle(
                    fontFamily: CustomFonts.nunitoExtraBold,
                    color: HexColor('#10159A'),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      content: SingleChildScrollView(
        child: Center(
          child: ColorPicker(
            pickerAreaHeightPercent: 0.10,
            pickerColor: _currentPinColor,
            onColorChanged: (newColor) {
              setState(() {
                Provider.of<PinColorProvider>(context, listen: false)
                    .newColor(newColor);
                _currentPinColor = newColor;
              });

              print('change color:' + _currentPinColor.toString());
            },
            paletteType: PaletteType.rgb,
          ),
        ),
      ),
    );
  }
}
