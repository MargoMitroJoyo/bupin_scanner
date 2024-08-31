import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/WebivewPolos.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Event extends StatefulWidget {
  const Event({super.key});

  @override
  State<Event> createState() => _EventState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _EventState extends State<Event> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true, min: 0.9, max: 1);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInToLinear,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    check();
    super.initState();
  }

  Map<String, dynamic>? data;
  check() async {
    data = await ApiService.checkEvent();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? SizedBox()
        : data!["image"] != null
            ? ScaleTransition(
                scale: _animation,
                child: InkWell(
                    onTap: () {
                      if ((data!["link"] as String).isNotEmpty) {
                        if (data!["external"] == true) {
                          _launchInBrowser(Uri.parse(data!["link"]));
                        } else {
                          Navigator.of(context).push(CustomRoute(
                            builder: (context) => HalamanWebview(
                                url: data!["link"], judul: data!["title"]),
                          ));
                        }
                      }
                    },
                    child: Image.network(
                      data!["image"],
                      width: MediaQuery.of(context).size.width * 0.35,
                    )),
              )
            : SizedBox();
  }
}
