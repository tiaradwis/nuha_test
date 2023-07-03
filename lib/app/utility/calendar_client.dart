import 'dart:developer';

import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarClient {
  static const _scopes = const [CalendarApi.calendarScope];

  insert(title, startTime, endTime) {
    var _clientID = new ClientId("AIzaSyCDcpqpoqF0Z_LYgtOq-iTUUIRG1B2c8ac", "");
    clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) {
      var calendar = CalendarApi(client);
      calendar.calendarList.list().then((value) => print("VAL________$value"));

      String calendarId = "primary";
      Event event = Event(); // Create object of event

      event.summary = title;

      EventDateTime start = new EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+05:00";
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+05:00";
      end.dateTime = endTime;
      event.end = end;
      try {
        calendar.events.insert(event, calendarId).then((value) {
          print("ADDEDDD_________________${value.status}");
          if (value.status == "confirmed") {
            log('Event added in google calendar');
          } else {
            log("Unable to add event in google calendar");
          }
        });
      } catch (e) {
        log('Error creating event $e');
      }
    });
  }

  void prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // static const _credentialsFile = 'assets/data/client_secret.json';

  // Future<String?> insert() async {
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //   final idTokenResult = await currentUser!.getIdTokenResult();
  //   final idToken = idTokenResult.token;

  //   // final client = http.Client();
  //   // final credentials = auth.ServiceAccountCredentials.fromJson(
  //   //     json.decode(await rootBundle.loadString(_credentialsFile)));
  //   // final httpClient = await auth.clientViaServiceAccount(
  //   //   credentials,
  //   //   const ['https://www.googleapis.com/auth/calendar'],
  //   // );
  //   final client = await auth.authenticatedClient(
  //     http.Client(),
  //     auth.AccessCredentials(
  //       auth.AccessToken('Bearer', idToken!,
  //           DateTime.now().toUtc().add(const Duration(hours: 1))),
  //       null,
  //       ['https://www.googleapis.com/auth/calendar'],
  //     ),
  //   );

  //   final calendarApi = calendar.CalendarApi(client);

  //   final event = calendar.Event()
  //     ..summary = 'Meeting'
  //     ..start = calendar.EventDateTime()
  //     ..end = calendar.EventDateTime()
  //     ..conferenceData = calendar.ConferenceData();

  //   event.start!.dateTime = DateTime.now().toUtc();
  //   event.end!.dateTime = DateTime.now().add(const Duration(hours: 1)).toUtc();

  //   // event.conferenceData!.createRequest = calendar.CreateConferenceRequest();

  //   final createdEvent = await calendarApi.events.insert(event, 'primary');
  //   final meetLink = createdEvent.conferenceData!.entryPoints![0].uri;

  //   return meetLink?.toString();
  // }

  // static var calendar;

  // Future<Map<String, String>> insert({
  //   required String title,
  //   required String description,
  //   required String location,
  //   required List<EventAttendee> attendeeEmailList,
  //   required bool shouldNotifyAttendees,
  //   required bool hasConferenceSupport,
  //   required DateTime startTime,
  //   required DateTime endTime,
  // }) async {
  //   Map<String, String> eventData = {};

  //   String calendarId = "primary";
  //   Event event = Event();

  //   event.summary = title;
  //   event.description = description;
  //   event.attendees = attendeeEmailList;
  //   event.location = location;

  //   if (hasConferenceSupport) {
  //     ConferenceData conferenceData = ConferenceData();
  //     CreateConferenceRequest conferenceRequest = CreateConferenceRequest();
  //     conferenceRequest.requestId =
  //         "${startTime.millisecondsSinceEpoch}-${endTime.millisecondsSinceEpoch}";
  //     conferenceData.createRequest = conferenceRequest;

  //     event.conferenceData = conferenceData;
  //   }

  //   EventDateTime start = new EventDateTime();
  //   start.dateTime = startTime;
  //   start.timeZone = "GMT+05:30";
  //   event.start = start;

  //   EventDateTime end = new EventDateTime();
  //   end.timeZone = "GMT+05:30";
  //   end.dateTime = endTime;
  //   event.end = end;

  //   try {
  //     await calendar.events
  //         .insert(event, calendarId,
  //             conferenceDataVersion: hasConferenceSupport ? 1 : 0,
  //             sendUpdates: shouldNotifyAttendees ? "all" : "none")
  //         .then((value) {
  //       print("Event Status: ${value.status}");
  //       if (value.status == "confirmed") {
  //         String joiningLink = '';
  //         String eventId;

  //         eventId = value.id;

  //         if (hasConferenceSupport) {
  //           joiningLink =
  //               "https://meet.google.com/${value.conferenceData.conferenceId}";
  //         }

  //         eventData = {'id': eventId, 'link': joiningLink};

  //         print('Event added to Google Calendar');
  //       } else {
  //         print("Unable to add event to Google Calendar");
  //       }
  //     });
  //   } catch (e) {
  //     print('Error creating event $e');
  //   }

  //   return eventData;
  // }

  // static const scopes = [CalendarApi.calendarEventsScope];

  // void insert(String title, DateTime startTime, DateTime endTime) async {
  //   var clientID = ClientId(
  //       "904581381315-r5ukdkn5q021nd73infvp2fhkn6jdt75.apps.googleusercontent.com",
  //       "");

  //   await clientViaUserConsent(clientID, scopes, prompt)
  //       .then((AuthClient client) async {
  //     var calendar = CalendarApi(client);
  //     await calendar.calendarList
  //         .list()
  //         .then((value) => print("VAL________$value"));

  //     String calendarId = "primary";
  //     Event event = Event(); // Create object of event

  //     event.summary = title;

  //     EventDateTime start = EventDateTime();
  //     start.dateTime = startTime;
  //     start.timeZone = "GMT+05:00";
  //     event.start = start;

  //     EventDateTime end = EventDateTime();
  //     end.timeZone = "GMT+05:00";
  //     end.dateTime = endTime;
  //     event.end = end;

  //     try {
  //       await calendar.events.insert(event, calendarId).then((value) {
  //         print("ADDEDDD_________________${value.status}");
  //         if (value.status != null) {
  //           log('Event added in Google Calendar');
  //         } else {
  //           log("Unable to add event in Google Calendar");
  //         }
  //       });
  //     } catch (e) {
  //       log('Error creating event $e');
  //     }
  //   });
  // }

  // void prompt(String url) async {
  //   print("Please go to the following URL and grant access:");
  //   print("  => $url");
  //   print("");

  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
