import 'dart:convert';

import 'package:azkar_app/models/section_model.dart';
import 'package:azkar_app/screens/section_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SectionModel> sections = [];

  @override
  void initState() {
    super.initState();
    loadSections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'اذكار المسلم',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: sections.length,
          itemBuilder: (context, index) =>
              buildSectionItem(model: sections[index]),
        ),
      ),
    );
  }

  Widget buildSectionItem({required SectionModel model}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SectionDatailScreen(
                  id: model.id!,
                  title: model.name!,
                )));
      },
      child: Container(
        margin: EdgeInsets.only(top: 12),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blueAccent,
                Colors.blue.shade900,
                Colors.lightBlue,
              ],
            )),
        child: Center(
            child: Text(
          '${model.name}',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
      ),
    );
  }

  loadSections() async {
    DefaultAssetBundle.of(context)
        .loadString("assets/database/sections_db.json")
        .then((data) {
      var response = json.decode(data);

      response.forEach((section) {
        SectionModel _section = SectionModel.fromJson(section);
        sections.add(_section);
      });
      setState(() {});
    }).catchError((error) {
      print(error.toString());
    });
  }
}
