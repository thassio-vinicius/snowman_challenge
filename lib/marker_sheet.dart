import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/custom_progress_indicator.dart';
import 'package:snowmanchallenge/features/add_marker/components/custom_backbutton.dart';
import 'package:snowmanchallenge/features/update_marker/section.dart';
import 'package:snowmanchallenge/models/comment_list.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/star_rating.dart';

class MarkerSheet extends StatefulWidget {
  const MarkerSheet({
    @required this.id,
    @required this.scrollController,
    @required this.onClose,
  });

  final String id;
  final Function onClose;
  final ScrollController scrollController;

  @override
  _MarkerSheetState createState() => _MarkerSheetState();
}

class _MarkerSheetState extends State<MarkerSheet> {
  Future<DocumentSnapshot> _future;
  double _rating;
  bool _isFavorite;

  @override
  void didChangeDependencies() {
    _future = Provider.of<FireStoreProvider>(context, listen: false)
        .getSpotById(widget.id);

    _future.then((value) {
      _rating = value.data['rating'];
      _isFavorite = value.data['isFavorite'];
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              child: CustomBackButton(
                onTap: widget.onClose,
                icon: Icons.close,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.95,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 2,
                ),
              ],
            ),
            child: FutureBuilder<DocumentSnapshot>(
              future: _future,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Align(
                      alignment: Alignment.topCenter,
                      child: CustomProgressIndicator(),
                    );
                    break;
                  default:
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: MediaQuery.of(context).size.height * 0.20,
                              child: _buildHeader(
                                  snapshot.data.data['mainPicture'])),
                          Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: MediaQuery.of(context).size.height * 0.75,
                            padding:
                                EdgeInsets.only(top: 24, left: 24, right: 24),
                            child: _buildBody(snapshot),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text('error ' + snapshot.error),
                      );
                    }
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildHeader(String image) {
    return Image(
      image: image != null && image != ''
          ? NetworkImage(image)
          : AssetImage('assets/images/logo.png'),
      fit: BoxFit.cover,
    );
  }

  _buildBody(AsyncSnapshot<DocumentSnapshot> snapshot) {
    return Column(
      children: <Widget>[
        Section(
          id: widget.id,
          percentageHeight: 0.07,
          title: snapshot.data.data['title'],
          description: snapshot.data.data['location'],
          section: DescriptionSection.spotTitleSection,
          isFavorite: snapshot.data.data['isFavorite'],
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          child: StarRating(
            rating: _rating,
            /*
            onRatingChanged: (rating) {
              setState(() {
                _rating = rating;
              });

              print(rating);
              Provider.of<FireStoreProvider>(context, listen: false).updateSpot(
                  id: snapshot.data.documentID, key: 'rating', value: rating);
            },

             */
          ),
        ),
        Section(
          id: widget.id,
          percentageHeight: 0.08,
          title: 'Category',
          description: snapshot.data.data['category'],
          section: DescriptionSection.categorySection,
        ),
        Section(
          id: widget.id,
          title: 'About',
          percentageHeight: 0.20,
          description: snapshot.data.data['description'],
          section: DescriptionSection.aboutSection,
        ),
        Section(
          id: widget.id,
          title: 'Comments',
          percentageHeight: 0.30,
          comments: snapshot.data.data['comments'] != null
              ? CommentList.fromJson(snapshot.data.data['comments'])
              : null,
          section: DescriptionSection.commentSection,
        ),
      ],
    );
  }

  /*
  Container _buildSectionButton(
      {bool isFavoriteButton, bool isFavorite, Function onTap}) {
    return Container(
      //margin: EdgeInsets.only(right: 24),
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          border: Border.all(
            color: isFavoriteButton ? HexColor('#FF7074') : HexColor('#10159A'),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          color: Colors.white),
      child: Center(
        child: IconButton(
            icon: Icon(
              isFavoriteButton
                  ? _isFavorite ? Icons.favorite : Icons.favorite_border
                  : Icons.comment,
              color:
                  isFavoriteButton ? HexColor('#FF7074') : HexColor('#10159A'),
              size: 24,
            ),
            onPressed: onTap),
      ),
    );
  }
   */

  /*
  Widget _buildSection({
    String title = '',
    DescriptionSection section,
    String description = '',
    double percentageHeight,
    double percentageWidth = 0.70,
    CommentList comments,
    bool isFavorite,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * percentageWidth,
          height: MediaQuery.of(context).size.height * percentageHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.nunito(
                  textStyle: section == DescriptionSection.spotTitleSection
                      ? TextStyle(
                          fontSize: 18,
                          color: HexColor('#111236'),
                          fontWeight: FontWeight.bold,
                        )
                      : TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: HexColor('#757685'),
                        ),
                ),
              ),
              section == DescriptionSection.commentSection
                  ? Expanded(
                      child: _buildSectionDescription(
                        section: section,
                        comments: comments,
                      ),
                    )
                  : Expanded(
                      child: _buildSectionDescription(
                        section: section,
                        description: description,
                      ),
                    ),
            ],
          ),
        ),
        if (section == DescriptionSection.spotTitleSection)
          _buildSectionButton(
              isFavoriteButton: true,
              isFavorite: isFavorite,
              onTap: () {
                Provider.of<FireStoreProvider>(context, listen: false)
                    .updateSpot(
                        id: widget.id, key: 'isFavorite', value: !_isFavorite);

                setState(() {
                  _isFavorite = !_isFavorite;
                });
                print('isFavorite state:' + _isFavorite.toString());
                print('isFavorite db:' + isFavorite.toString());
              }),
        if (section == DescriptionSection.commentSection)
          _buildSectionButton(
              isFavoriteButton: false, onTap: () => _addComment()),
      ],
    );
  }

   */

  /*

  _buildSectionDescription(
      {String description, DescriptionSection section, CommentList comments}) {
    switch (section) {
      case DescriptionSection.spotTitleSection:
        return Text(
          description,
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: HexColor('#757685').withOpacity(0.60),
              fontSize: 12,
            ),
          ),
        );
        break;
      case DescriptionSection.categorySection:
        return Text(
          description,
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              color: HexColor('#757685'),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
        break;
      case DescriptionSection.aboutSection:
        if (description != null && description != '') {
          return Text(
            description,
            style: GoogleFonts.nunito(
              textStyle: TextStyle(
                color: HexColor('#757685'),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        } else {
          return _buildEmptyDescription(isCommentSection: false);
        }
        break;
      case DescriptionSection.commentSection:
        if (comments != null && comments.comments.length > 2) {
          return comments.comments
              .sublist(0, 1)
              .map((e) => CommentSection(
                  owner: e.owner, comment: e.comment, rating: e.rating))
              .toList();
        } else if (comments != null && comments.comments.length == 1) {
          return CommentSection(
            owner: comments.comments.first.owner,
            comment: comments.comments.first.comment,
            rating: comments.comments.first.rating,
          );
        } else {
          return Align(
            alignment: Alignment.topCenter,
            child: _buildEmptyDescription(isCommentSection: true),
          );
        }
    }
  }

   */

  /*
  Widget _buildCommentSection({String owner, String comment, double rating}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              owner,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: HexColor('#757685'),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(
                Icons.star,
                size: 30,
                color: HexColor('#10159A'),
              ),
            ),
            Text(
              rating.toString(),
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: HexColor('#10159A'),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Text(
          comment,
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              color: HexColor('#757685'),
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Divider(
          color: HexColor('#979797').withOpacity(0.21),
          thickness: 1,
        )
      ],
    );
  }

   */

  /*

  Center _buildEmptyDescription({bool isCommentSection}) {
    return Center(
      child: Row(
        children: <Widget>[
          Text(
            isCommentSection
                ? "There's no comments yet. "
                : "There's no description yet. ",
            style: GoogleFonts.nunito(
              textStyle: TextStyle(
                color: HexColor('#757685'),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => isCommentSection ? _addComment() : _addDescription(),
            child: Text(
              'Try adding one!',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: HexColor('#11159A'),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

   */

  /*
  _addDescription() {
    return showDialog(
      context: context,
      builder: (context) => Container(
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
            actionsPadding: EdgeInsets.all(8),
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
      ),
    );
  }

   */

  /*
  _addComment() {
    double rating;
    return showDialog(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: MediaQuery.of(context).size.width * 0.80,
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
            content: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: StarRating(
                    size: 40,
                    onRatingChanged: (newRating) {
                      setState(() {
                        rating = newRating;
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
                  onTap: () => _newComment(rating),
                  label: 'Comment',
                  percentageWidth: 0.70,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _newComment(rating) {
    String owner =
        Provider.of<UserProvider>(context, listen: false).user.displayName;

    Comment comment =
        Comment(comment: _commentController.text, rating: rating, owner: owner);

    //CommentList(comments: [comment]);

    List<Comment> comments = [comment];

    Provider.of<FireStoreProvider>(context, listen: false).updateSpot(
        id: widget.id,
        key: 'comments',
        value: comments.map((e) => comment.toJson()).toList());

    Navigator.of(context);
  }

   */
}

enum DescriptionSection {
  spotTitleSection,
  commentSection,
  aboutSection,
  categorySection,
}
