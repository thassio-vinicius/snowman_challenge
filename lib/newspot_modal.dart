import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snowmanchallenge/utils/custom_fonts.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class NewSpotModal extends StatefulWidget {
  @override
  _NewSpotModalState createState() => _NewSpotModalState();
}

class _NewSpotModalState extends State<NewSpotModal> {
  TextEditingController _categoriesController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.white),
                margin: EdgeInsets.only(top: 24, left: 40),
                width: 40,
                height: 40,
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: HexColor('#757685'),
                      size: 25,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
            Container(
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                titlePadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                title: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    color: HexColor('#D8D8D8'),
                  ),
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Center(
                      child: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: HexColor('#10159A'),
                          ),
                          onPressed: () {})),
                ),
                content: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCustomTextBox(
                          controller: _nameController, label: 'Name'),
                      _buildCustomTextBox(
                          controller: _categoriesController, label: 'Category'),
                      _buildCustomTextBox(
                        controller: _categoriesController,
                        label: 'Location',
                        isLocationTextBox: true,
                      ),
                      _buildCustomTextBox(
                          controller: _categoriesController,
                          label: 'Pin Color'),
                      _buildAddButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack _buildCustomTextBox({
    String label,
    TextEditingController controller,
    bool isLocationTextBox = false,
  }) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.70,
              height: MediaQuery.of(context).size.height * 0.08,
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
                      child: TextField(
                        controller: controller,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(border: InputBorder.none),
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

  _buildAddButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.70,
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
              'Add Spot',
              style: TextStyle(
                fontFamily: CustomFonts.nunitoExtraBold,
                color: HexColor('#10159A'),
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
