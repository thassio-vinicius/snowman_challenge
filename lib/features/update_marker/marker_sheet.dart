import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/features/update_marker/components/star_rating.dart';
import 'package:snowmanchallenge/features/update_marker/section.dart';
import 'package:snowmanchallenge/models/comment_list.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/shared/components/custom_backbutton.dart';
import 'package:snowmanchallenge/shared/components/custom_progress_indicator.dart';

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
          child: StarRating(rating: _rating),
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
}

enum DescriptionSection {
  spotTitleSection,
  commentSection,
  aboutSection,
  categorySection,
}
