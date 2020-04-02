import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/features/update_marker/components/star_rating.dart';
import 'package:snowmanchallenge/models/comment.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/providers/user_provider.dart';
import 'package:snowmanchallenge/shared/components/custom_button.dart';
import 'package:snowmanchallenge/shared/components/custom_textbox.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class AddComment extends StatefulWidget {
  const AddComment(
      {@required this.id, @required this.commentsLength, this.notifyParent});

  final String id;
  final Function notifyParent;
  final int commentsLength;

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  double _rating = 0;

  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.80,
          width: MediaQuery.of(context).size.width,
          child: Theme(
            data: ThemeData.light(),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              buttonPadding: EdgeInsets.zero,
              backgroundColor: Theme.of(context).dialogBackgroundColor,
              title: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 15,
                      child: Text(
                        'New Review',
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            color: HexColor('#757685').withOpacity(0.60),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      bottom: 1,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: HexColor('#757685').withOpacity(0.60),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.50,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: StarRating(
                          size: 40,
                          rating: _rating,
                          onRatingChanged: (newRating) {
                            setState(() {
                              _rating = newRating;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: CustomTextBox(
                          label: 'Comment',
                          controller: _commentController,
                          maxLines: 5,
                          boxPercentageHeight: 0.25,
                          maxLength: 140,
                        ),
                      ),
                      CustomButton(
                        onTap: () => _newComment(_rating),
                        label: 'Comment',
                        percentageWidth: 0.70,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _newComment(rating) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    String owner =
        userProvider.user.displayName ?? userProvider.customUser.displayName;

    Comment comment =
        Comment(comment: _commentController.text, rating: rating, owner: owner);

    List<Comment> comments = [comment];

    Provider.of<FireStoreProvider>(context, listen: false).updateSpot(
        id: widget.id,
        isArray: true,
        key: 'comments',
        value: comments.map((e) => e.toJson()).toList());

    Navigator.pop(context);
  }
}
