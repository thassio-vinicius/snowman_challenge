import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  Widget buildLeading(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Icon(
        Icons.search,
        color: Colors.white,
        size: 26,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: Icon(Icons.add), onPressed: () {})];

  @override
  Widget buildResults(BuildContext context) => Container();
}
