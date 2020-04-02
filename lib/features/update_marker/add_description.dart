import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/shared/components/custom_textbox.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class AddDescription extends StatefulWidget {
  const AddDescription({@required this.id});

  final String id;

  @override
  _AddDescriptionState createState() => _AddDescriptionState();
}

class _AddDescriptionState extends State<AddDescription> {
  TextEditingController _aboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.height * 0.80,
      child: Theme(
        data: ThemeData.light(),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          title: Text(
            'Add a new description below:',
            style: GoogleFonts.nunito(
              textStyle: TextStyle(
                  fontSize: 16,
                  color: HexColor('#111236'),
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: CustomTextBox(
            label: 'Description',
            controller: _aboutController,
            maxLength: 140,
            maxLines: 5,
            boxPercentageHeight: 0.25,
          ),
          actionsPadding: EdgeInsets.all(16),
          actions: <Widget>[
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Provider.of<FireStoreProvider>(context, listen: false)
                    .updateSpot(
                  id: widget.id,
                  key: 'description',
                  value: _aboutController.text,
                );

                Navigator.pop(context);
              },
              child: Text(
                'Submit',
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    color: HexColor('#11159A'),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
