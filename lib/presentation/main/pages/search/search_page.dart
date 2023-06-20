import 'package:flutter/material.dart';

import '../../../resources/strings_manager.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // final HomeViewModel _viewModel = instance<HomeViewModel>();

  // _bind() {
  //   _viewModel.start();
  // }

  @override
  void initState() {
    // _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.search),
    );
  }
}

/* import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return   Center(
      child: Text(AppStrings.search.tr()),
    );
  }
}
 */