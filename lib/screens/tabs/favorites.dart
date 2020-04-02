import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/features/favorites/spot_card.dart';
import 'package:snowmanchallenge/models/tourist_spot.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/shared/components/custom_progress_indicator.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({this.anonymous = false});

  final bool anonymous;
  @override
  _FavoritesTabState createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  Stream _stream;
  List<TouristSpot> _favs = [];

  @override
  void didChangeDependencies() {
    _stream =
        Provider.of<FireStoreProvider>(context, listen: false).getStreamSpots();
    //_favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          color: Colors.transparent,
        ),
        backgroundColor: HexColor('#10159A'),
        title: Text('Favorites'),
        centerTitle: true,
      ),
      body: widget.anonymous
          ? Center(
              child: Image.asset('assets/images/logo.png'),
            )
          : _buildFavorites(),
    );
  }

  _buildFavorites() {
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Container(
                  padding: EdgeInsets.all(70),
                  child: CustomProgressIndicator()),
            );
            break;
          default:
            List<DocumentSnapshot> spots = snapshot.data.documents
                .where((element) => element.data['isFavorite'] == true)
                .toList();

            if (spots.isNotEmpty) return _populateFavorites(spots);
            return _buildNoFavorites();
        }
      },
    );
  }

  Widget _buildNoFavorites() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 48, bottom: 16),
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/logo.png'),
            Text(
              'You have no favorite spots yet',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    color: HexColor('#606062'),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _populateFavorites(spots) {
    for (int i = 0; i < spots.length; i++)
      if (!_favs.contains(TouristSpot.fromJson(spots[i].data)))
        _favs.add(TouristSpot.fromJson(spots[i].data));

    return ListView(
      //itemExtent: 50,
      children: _favs
          .map((e) => SpotCard(
                address: e.location,
                title: e.title,
                imageUrl: e.mainPicture,
              ))
          .toList(),
    );
  }
}
