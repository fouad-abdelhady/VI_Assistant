import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String _appBarTitel;
  final AppBar? _aplicationAppBar;
  final Widget _screenBody;
  final FloatingActionButton? _screenFloatingActionButton;

  AppScaffold(
      {Key? key,
      required String appBarTitle,
      AppBar? applicationAppBar,
      required Widget screenBody,
      FloatingActionButton? screenFloatingActionButton})
      : _appBarTitel = appBarTitle,
        _aplicationAppBar = applicationAppBar,
        _screenBody = screenBody,
        _screenFloatingActionButton = screenFloatingActionButton,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: _aplicationAppBar ?? _getDefaultAppBar(),
      body: SafeArea(
          child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 54, 54, 54),
                Color.fromARGB(255, 27, 27, 27)
              ], begin: Alignment.topLeft)),
              child: _screenBody)),
      //floatingActionButton: _screenFloatingActionButton,
    );
  }

  AppBar _getDefaultAppBar() => AppBar(
        title: Text(_appBarTitel),
      );
}
