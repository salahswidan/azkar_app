import 'package:azkar_app/models/secttion_detail_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SectionDatailScreen extends StatefulWidget {
  final int id;
  final String title;
  const SectionDatailScreen({super.key, required this.id, required this.title});

  @override
  State<SectionDatailScreen> createState() => _SectionDatailScreenState();
}

class _SectionDatailScreenState extends State<SectionDatailScreen> {
  List<SectionDetailModel> sectionDetails = [];
  @override
  void initState() {
    super.initState();
    loadSectionDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.title}'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      '${sectionDetails[index].reference}',
                      textDirection: TextDirection.rtl,
                    ),
                    subtitle: Text(
                      '${sectionDetails[index].content}',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                    height: 1,
                  ),
              itemCount: sectionDetails.length),
        ));
  }

  loadSectionDetail() async {
    sectionDetails = [];
    DefaultAssetBundle.of(context)
        .loadString("assets/database/section_details_db.json")
        .then((data) {
      var response = json.decode(data);

      response.forEach((section) {
        SectionDetailModel _sectionDetail =
            SectionDetailModel.fromJson(section);
        if (_sectionDetail.sectionId == widget.id) {
          sectionDetails.add(_sectionDetail);
        }
      });
      setState(() {});
    }).catchError((error) {
      print(error.toString());
    });
  }
}
