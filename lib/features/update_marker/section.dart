import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/features/update_marker/add_comment.dart';
import 'package:snowmanchallenge/features/update_marker/add_description.dart';
import 'package:snowmanchallenge/features/update_marker/comment_section.dart';
import 'package:snowmanchallenge/features/update_marker/empty_description.dart';
import 'package:snowmanchallenge/features/update_marker/section_button.dart';
import 'package:snowmanchallenge/marker_sheet.dart';
import 'package:snowmanchallenge/models/comment_list.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class Section extends StatefulWidget {
  const Section({
    @required this.percentageHeight,
    @required this.id,
    @required this.section,
    @required this.title,
    this.rating = 0,
    this.percentageWidth = 0.70,
    this.comments,
    this.isFavorite,
    this.description,
    this.notifyParent,
  });

  final double percentageHeight;
  final double percentageWidth;
  final double rating;
  final DescriptionSection section;
  final VoidCallback notifyParent;
  final String id;
  final String title;
  final CommentList comments;
  final bool isFavorite;
  final String description;

  @override
  _SectionState createState() => _SectionState();
}

class _SectionState extends State<Section> {
  bool _isFavorite;
  double _rating;

  @override
  initState() {
    _isFavorite = widget.isFavorite;

    super.initState();
  }

  _toggleValue() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * widget.percentageWidth,
          height: MediaQuery.of(context).size.height * widget.percentageHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: GoogleFonts.nunito(
                  textStyle:
                      widget.section == DescriptionSection.spotTitleSection
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
              widget.section == DescriptionSection.commentSection
                  ? Expanded(
                      child: _buildSectionDescription(
                        section: widget.section,
                        comments: widget.comments,
                      ),
                    )
                  : Expanded(
                      child: _buildSectionDescription(
                        section: widget.section,
                        description: widget.description,
                      ),
                    ),
            ],
          ),
        ),
        if (widget.section == DescriptionSection.spotTitleSection)
          SectionButton(
              isFavoriteButton: true,
              isFavorite: _isFavorite,
              onTap: () {
                _toggleValue();

                Provider.of<FireStoreProvider>(context, listen: false)
                    .updateSpot(
                        id: widget.id, key: 'isFavorite', value: _isFavorite);

                print('isFavorite state:' + _isFavorite.toString());
                //print('isFavorite db:' + widget.isFavorite.toString());

                return widget.notifyParent;
              }),
        if (widget.section == DescriptionSection.commentSection)
          SectionButton(
              isFavoriteButton: false,
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => AddComment(
                        id: widget.id,
                        commentsLength: widget.comments.comments.length,
                      ))),
      ],
    );
  }

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
          return EmptyDescription(
              isCommentSection: false,
              onTap: () => showDialog(
                  context: context,
                  builder: (builder) => AddDescription(
                        id: widget.id,
                      )));
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
            child: EmptyDescription(
                isCommentSection: true,
                onTap: () => showDialog(
                    context: context,
                    builder: (builder) => AddComment(
                          id: widget.id,
                          commentsLength: widget.comments.comments.length,
                        ))),
          );
        }
    }
  }
}
