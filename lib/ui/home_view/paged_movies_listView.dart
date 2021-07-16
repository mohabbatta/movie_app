import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:movie_app/ui/home_view/movies_item.dart';
import 'package:movie_app/ui/exception_indicators/empty_list_indicator.dart';
import 'package:movie_app/ui/exception_indicators/error_indicator.dart';

class PagedMoviesListView extends StatefulWidget {
  @override
  _PagedMoviesListViewState createState() => _PagedMoviesListViewState();
}

class _PagedMoviesListViewState extends State<PagedMoviesListView> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();

  final _pagingController = PagingController<int, Movie>(
    firstPageKey: 1,
  );

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      print(notification);

    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      print(notification);

      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });

  }

  Future displayNotificationAndroid(RemoteMessage message) async {

    var androidPlatformChannelSpecifics = new  AndroidNotificationDetails('1', 'name', 'desc',
      icon: "@mipmap/ic_launcher",
      largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
      enableLights: true,
      importance: Importance.max,

      priority: Priority.high,
      color: Colors.white,
      playSound: true,


    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      "AppGain",
      message.notification.body,
      platformChannelSpecifics,
      payload: message.notification.body,
    );
  }


  Future<void> _fetchPage(int pageKey) async {
    try {
      final newPage = await Repository(nextPage: pageKey).getMovies;
      final isLastPage = newPage.page == newPage.totalPages;
      final newItems = newPage.movies;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: Text("Popular Movies"),
        ),
        body: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
          child: PagedListView.separated(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Movie>(
              itemBuilder: (context, movie, index) => MovieItem(
                movie: movie,
              ),
              firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
                error: _pagingController.error,
                onTryAgain: () => _pagingController.refresh(),
              ),
              noItemsFoundIndicatorBuilder: (context) => EmptyListIndicator(),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
          ),
        ),
      );
}
