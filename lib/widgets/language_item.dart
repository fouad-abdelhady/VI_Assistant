import 'package:flutter/material.dart';
import 'package:jarvis000/models/language.dart';

class LanguageItem extends StatelessWidget {
  Language language;
  Function(Language language) onTap;
  LanguageItem({Key? key, required this.language, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(language);
      },
      child: Center(
        child: Stack(
          children: [
            const SizedBox(
              height: 260,
              width: double.infinity,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(child: Image.asset(language.languageImg))),
            Positioned(
                bottom: 55,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    color: Color.fromARGB(131, 0, 0, 0),
                  ),
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Center(
                    child: Text(
                      language.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
