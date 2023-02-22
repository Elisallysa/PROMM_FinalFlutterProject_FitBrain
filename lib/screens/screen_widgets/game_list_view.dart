import 'package:fit_brain/main.dart';
import 'package:fit_brain/screen_data/language_games_data.dart';
import 'package:fit_brain/screen_data/math_games_data.dart';
import 'package:fit_brain/screens/game_cambio.dart';
import 'package:fit_brain/screens/screen_widgets/drawer.dart';
import 'package:fit_brain/theme/fitbrain_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GameListView extends StatefulWidget {
  // Lista de juegos de una categoría.
  GameListView({Key? key, required this.categoria}) : super(key: key);

  String categoria = '';
  List<Map<String, dynamic>> items = [];

  @override
  State<StatefulWidget> createState() => _GameListState();
}

class _GameListState extends State<GameListView> {
  @override
  void initState() {
    if (widget.categoria == 'math') {
      widget.items = getMathgames();
    } else {
      widget.items = getLanguageGames();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.pinkEmphasis,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Juegos de cálculo',
              style: AppTheme.appBarTitle,
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.person, color: Colors.white),
            )
          ],
        ),
      ),
      drawer: const FitBrainDrawer(name: 'user'),
      body: SingleChildScrollView(
        // La lista está formada por paneles expandibles
        child: ExpansionPanelList(
          elevation: 3,
          // Se controla el comportamiento de la expansión
          expansionCallback: (index, isExpanded) {
            setState(() {
              widget.items[index]['isExpanded'] = !isExpanded;
            });
          },
          animationDuration: const Duration(milliseconds: 600),
          children: widget.items
              .map(
                (item) => ExpansionPanel(
                  canTapOnHeader: true,
                  backgroundColor: item['isExpanded'] == true
                      ? AppTheme.greenishBlue
                      : Colors.white,
                  headerBuilder: (_, isExpanded) => Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: Text(
                        item['title'],
                        style: AppTheme.gameTitle,
                      )),
                  body: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: Column(
                      children: [
                        Text(item['description'],
                            style: AppTheme.gameDescription),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              backgroundColor: AppTheme.pinkEmphasis,
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CambioGame()));
                            },
                            child: const Text('¡A entrenar! 🧠',
                                style: AppTheme.gameDescription))
                      ],
                    ),
                  ),
                  isExpanded: item['isExpanded'],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
