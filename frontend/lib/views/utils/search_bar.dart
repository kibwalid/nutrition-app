import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function onSaved;
  final Function onSearch;
  const SearchBar({
    Key key,
    this.onSaved,
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29.5),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Search",
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: onSearch,
          ),
          border: InputBorder.none,
        ),
        onSaved: onSaved,
      ),
    );
  }
}
