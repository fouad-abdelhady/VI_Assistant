import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  Color color1;
  Color color2;
  String label;
  IconData icon;
  Function onPressed;
  OptionItem(
      {required this.color1,
      required this.color2,
      required this.label,
      required this.icon,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 10),
      child: InkWell(
        onTap: () {
          onPressed(context: context);
        },
        child: Container(
          width: double.infinity,
          decoration: _getBoxdeciration(),
          child: _getBotonSection(context: context, label: label, icon: icon),
        ),
      ),
    ));
  }

  _getBoxdeciration() => BoxDecoration(
          gradient: LinearGradient(
              colors: [color1, color2]), // for controlling the bottons colors
          /*border: Border.all(color: Color.fromARGB(221, 31, 30, 30), width: 2)*/
          borderRadius: const BorderRadius.only(
              // to controle the border radius
              topLeft: Radius.circular(80),
              bottomRight: Radius.circular(80),
              topRight: Radius.circular(80),
              bottomLeft: Radius.circular(80)),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 138, 101, 1),
                blurStyle: BlurStyle.normal,
                blurRadius: 10,
                offset: Offset(3, 3))
          ]);

  _getBotonSection(
          {required BuildContext context,
          required String label,
          required IconData icon}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 90,
            color: Color.fromARGB(248, 0, 0, 0),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Color.fromARGB(248, 0, 0, 0),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          )
        ],
      );
}
