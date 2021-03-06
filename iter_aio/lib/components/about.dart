import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iteraio/main.dart';
import 'package:iteraio/widgets/Mdviewer.dart';
import 'package:iteraio/widgets/ReportBugs.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wiredash/wiredash.dart';

// ignore: must_be_immutable
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.feedback),
            onPressed: () {
              Wiredash.of(context).show();
            },
          ),
        ],
        elevation: 15,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 150,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Image.asset(
                    brightness == Brightness.light
                        ? 'assets/logos/codex.jpg'
                        : 'assets/logos/codexLogo.png',
                    fit: BoxFit.contain,
                  )),
                  Expanded(
                      child: Image.asset(
                    'assets/logos/icon.png',
                    fit: BoxFit.contain,
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'THIS APP DOES NOT PROMOTE BUNKING.\n\nTHE APP WAS DESIGNED TO ENSURE THAT YOU CAN MANAGE A PROPER ATTENDANCE AND BUNK SAFELY.THE ATTENDANCE & DATA SHOWN IS COMPLETELY MANAGED BY COLLEGE.\n\nTHE DEVELOPER IS NOT RESPONSIBLE FOR INACCURATE ATTENDANCE & DATA OR DELAY IN ATTENDANCE UPDATE.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () => _launchURL(
                      'https://www.facebook.com/ayushkejariwal.ayush'),
                  icon: Icon(
                    LineAwesomeIcons.facebook,
                    size: 45,
                    color: Colors.blueAccent,
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      _launchURL('https://www.instagram.com/a_kejariwal/'),
                  icon: Icon(
                    LineAwesomeIcons.instagram,
                    size: 45,
                    color: Colors.orangeAccent,
                  ),
                ),
                IconButton(
                  onPressed: () => _launchURL(
                      'https://www.linkedin.com/in/ayush-kejariwal-1923a2191/'),
                  icon: Icon(
                    LineAwesomeIcons.linkedin_square,
                    size: 45,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      _launchURL('https://www.github.com/KejariwalAyush'),
                  icon: Icon(
                    LineAwesomeIcons.github_square,
                    size: 45,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () => _launchURL('mailto:iteraio2020@gmail.com'),
                  icon: Icon(
                    LineAwesomeIcons.envelope,
                    size: 45,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 15,
            // ),
            // Center(
            //   child: SelectableText('Email Us at: iteraio2020@gmail.com'),
            // ),
            Divider(),
            Center(
              child: RichText(
                text: TextSpan(
                    text: 'Source Code : ',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'GitHub',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _launchURL(
                                  "https://github.com/KejariwalAyush/ITER-AIO");
                            }
//                      ) // Not Working on click of url
                          )
                    ]),
              ),
            ),
            Divider(),
            Center(
              child: RichText(
                text: TextSpan(
                    text: 'Version ',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '$version',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _launchURL(
                                  "https://github.com/KejariwalAyush/ITER-AIO/releases");
                            })
                    ]),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              height: 15,
              thickness: 5,
            ),
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MdViewer(
                          'Privacy Policy', 'assets/policy/PrivacyPolicy.md'))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      LineAwesomeIcons.lock,
                      size: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Privacy Policy',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
      bottomSheet: ReportBugs(),
    );
  }

  _launchURL(String url) async {
    // const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
    return;
  }
}
