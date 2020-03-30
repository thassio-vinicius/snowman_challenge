import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class CustomSearchBox extends StatefulWidget {
  const CustomSearchBox({@required this.dialogPressed});

  final Widget dialogPressed;

  @override
  _CustomSearchBoxState createState() => _CustomSearchBoxState();
}

class _CustomSearchBoxState extends State<CustomSearchBox> {
  TextEditingController _searchController =
      TextEditingController(text: 'Search here');
  TextStyle _style = GoogleFonts.nunito(
    textStyle: TextStyle(
      color: HexColor('#6C6C6C').withOpacity(0.50),
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 1.0),
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Icon(Icons.search, color: HexColor('#757685'), size: 25),
          ),
          Flexible(
            flex: 7,
            fit: FlexFit.tight,
            child: Container(
              padding: EdgeInsets.only(left: 6, right: 6),
              alignment: Alignment.center,
              child: TextField(
                scrollPadding: EdgeInsets.zero,
                onTap: () => _onTap(),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                controller: _searchController,
                style: _style,
                cursorColor: Colors.black,
              ),
            ),
          ),
          Container(
            width: 1.5,
            height: MediaQuery.of(context).size.height * 0.05,
            color: HexColor('#E7E7E9'),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.add, color: HexColor('#757685'), size: 25),
              onPressed: () => showDialog(
                  context: context, builder: (context) => widget.dialogPressed),
            ),
          )
        ],
      ),
    );
  }

  _onTap() {
    setState(() {
      if (_counter == 0) _searchController.text = '';
      _style = GoogleFonts.nunito(
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
      _counter = 1;
    });
  }
}
