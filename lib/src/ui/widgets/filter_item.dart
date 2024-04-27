import 'package:flutter/material.dart';

import '../../data/api/articles.dart';
import '../localizations/localization.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class FilterItem extends StatefulWidget {
  final String query;
  final Map<String, String> activeQuery;

  final void Function(String queryName, String queryValue) updateActiveQuery;
  const FilterItem({
    super.key,
    required this.query,
    required this.updateActiveQuery,
    required this.activeQuery,
  });

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  late String queryData;

  @override
  void initState() {
    setState(() {
      queryData = widget.activeQuery[widget.query]!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          width: 160,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(
              color: Colors.black, // Border color
              width: 2, // Border width
            ),
          ),
          child: Text(
            "${AppLocalizations.of(context)[widget.query]!}: $queryData",
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
          ),
        ),
        onTap: () {
          picker.DatePicker.showDatePicker(context,
              showTitleActions: true,
              onChanged: (date) {},
              minTime: DateTime.now().subtract(const Duration(days: 30)),
              maxTime: DateTime.now(), onConfirm: (date) {
            final formatDate = formatDateTimeApi(date);
            setState(() {
              queryData = formatDate;
            });
            widget.updateActiveQuery(widget.query, formatDate);
          },
              locale: picker.LocaleType.values.firstWhere((element) =>
                  element.name ==
                  AppLocalizations.of(context)['languageCode']));
        });
  }
}
