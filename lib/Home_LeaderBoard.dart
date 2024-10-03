import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeLeaderboard extends StatefulWidget {
  const HomeLeaderboard({super.key});

  @override
  State<HomeLeaderboard> createState() => _HomeLeaderboardState();
}

class _HomeLeaderboardState extends State<HomeLeaderboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset("asset/background.png",),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Leaderboard",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(
                height: 250,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Image.asset(
                        "asset/chart2.png",
                        width: 100,
                      ).animate().fade( delay: Duration(milliseconds: 300),duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn,).slide( begin: Offset(0, 0.4),
                            curve: Curves.easeIn),
                   Image.asset(
                        "asset/chart1.png",
                        width: 100,
                      ).animate().fade(duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn,).slide( begin: Offset(0, 0.4),
                            curve: Curves.easeIn),
                   Image.asset(
                        "asset/chart3.png",
                        width: 100,
                      ).animate().fade(  delay: Duration(milliseconds: 150),duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn,).slide( begin: Offset(0, 0.4),
                            curve: Curves.easeIn),
                ],
              ),
            ],
          ),
          DraggableScrollableSheet(
            minChildSize: 0.4,
            initialChildSize: 0.4,
            maxChildSize: 0.7,
            builder: (BuildContext context, scrollController) {
              return Container(margin: EdgeInsets.symmetric(horizontal: 10),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color:Color.fromRGBO(239, 238, 252,1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          height: 4,
                          width: 40,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  
                    SliverList.list(children: const [
                      ListTile(title: Text('Jane Doe')),
                      ListTile(title: Text('Jack Reacher')),
                    ])
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
