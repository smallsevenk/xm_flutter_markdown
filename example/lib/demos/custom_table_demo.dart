// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_implementing_value_types

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// ignore_for_file: public_member_api_docs

const String _markdownData = '''
| 日期 日期日期日期日期日期日期日期日期日期日期      | 天气   | 温度  | 日期       | 天气   | 温度  | 日期       | 天气   | 温度  |
| ---------- | ------ | ----- | ---------- | ------ | ----- | ---------- | ------ | ----- |
| 2025-09-15 | 晴    | 281°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-16 | 多云   | 27°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | 小雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
| 2025-09-17 | da雨   | 25°C  | 2025-09-15 | 晴    | 28°C  |2025-09-15 | 晴    | 28°C  |
''';

class CustomTableDemo extends StatelessWidget {
  const CustomTableDemo({super.key});

  static const String _title = 'Custom Table Demo';

  @override
  Widget build(BuildContext context) {
    var border = BorderSide(color: Colors.grey[200]!, width: 1);
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: SafeArea(
        child: Markdown(
          data: _markdownData,
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            tableCellsDecoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!, width: 1),
            ),
            tableHead:
                TextStyle(fontWeight: FontWeight.w600, color: Color(0xff1A1A1A), fontSize: 15),
            tableHeadAlign: TextAlign.left,
            tableCellConstraints: BoxConstraints(maxWidth: 200),
            tableColumnWidth: IntrinsicColumnWidth(),
            tableBorder: TableBorder(horizontalInside: border, verticalInside: border),
          ),
        ),
      ),
    );
  }
}
