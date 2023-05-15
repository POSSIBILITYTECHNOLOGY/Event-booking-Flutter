// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';
import '../../../utils/widgets/common_widget.dart';

class SettingCommonScreen extends StatelessWidget {
  final String? text;
  final String? data;

  const SettingCommonScreen({Key? key, required this.text, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              SettingsCommonAppBar(
                text: text,
              ),
              const SizedBox(
                height: 23,
              ),
              Expanded(
                child: ListView(children: [
                  Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Html(
                        data: data!.toString(),
                        style: {"body": Style(color: AppColor.white_Color)},
                      )

                      // Text(
                      //     Html(data: data!.toString()).toString(),
                      //   overflow: TextOverflow.clip,
                      //   style: TextStyle(color: AppColor.light_grey),
                      // ),
                      ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
