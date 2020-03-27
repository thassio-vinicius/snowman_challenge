import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/providers/pincolor_provider.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class CustomMarkerTextBox extends StatelessWidget {
  const CustomMarkerTextBox({
    @required this.label,
    @required this.controller,
    this.onColorBoxTap,
    this.onLocationBoxSubmitted,
    this.isLocationTextBox = false,
    this.isColorPicker = false,
  });

  final VoidCallback onColorBoxTap;
  final Function onLocationBoxSubmitted;
  final String label;
  final TextEditingController controller;
  final bool isLocationTextBox;
  final bool isColorPicker;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.70,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                              style: BorderStyle.solid,
                              color: HexColor('#757685').withOpacity(0.60),
                              width: 1.0)),
                      child: Consumer<PinColorProvider>(
                        builder: (context, provider, child) => TextField(
                          controller: controller,
                          cursorColor: Colors.black,
                          readOnly: isColorPicker,
                          onTap: isColorPicker ? onColorBoxTap : null,
                          onSubmitted: isLocationTextBox
                              ? (location) => onLocationBoxSubmitted
                              : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: isLocationTextBox
                                ? Icon(
                                    CupertinoIcons.location_solid,
                                    color: HexColor('#10159A'),
                                  )
                                : isColorPicker
                                    ? Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: provider.currentColor),
                                        width: 5,
                                        height: 5,
                                        margin:
                                            EdgeInsets.only(top: 6, bottom: 6),
                                      )
                                    : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -6.0,
          left: 20.0,
          child: Container(
            padding: EdgeInsets.only(left: 4, right: 4),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 12.0, color: HexColor('#757685').withOpacity(0.60)),
            ),
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
