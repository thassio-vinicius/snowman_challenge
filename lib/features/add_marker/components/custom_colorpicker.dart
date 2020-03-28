import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/features/add_marker/components/custom_button.dart';
import 'package:snowmanchallenge/providers/pincolor_provider.dart';

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
        CustomButton(
          onTap: () => Navigator.pop(context),
          label: 'Confirm color',
          percentageWidth: 0.35,
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
            },
            paletteType: PaletteType.rgb,
          ),
        ),
      ),
    );
  }
}
