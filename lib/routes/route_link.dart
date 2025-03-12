import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/blog_model.dart';
import '../components/blog_list_screen.dart';
import '../components/blog_details_screen.dart';
import '../bloc/blog_bloc.dart';
import '../bloc/bloc_event.dart';
import '../bloc/bloc_state.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => BlogListScreen());

      case '/blog':
        return MaterialPageRoute(builder: (_) => BlogListScreen());

      default:
        if (settings.name!.startsWith('/blog/')) {
          final blogId = settings.name!.split('/').last;

          if (args is BlogModel) {
            return MaterialPageRoute(
              builder: (_) => BlogDetailScreen(blog: args),
            );
          } else {
            // If coming from a deep link, we need to load the blog post
            BlocProvider.of<BlogBloc>(
              navigatorKey.currentContext!,
            ).add(LoadBlogById(blogId));

            // Find the blog from the current state
            return MaterialPageRoute(
              builder: (context) {
                final state = BlocProvider.of<BlogBloc>(context).state;
                if (state is BlogLoaded) {
                  final blog = state.blogs.firstWhere(
                    (blog) => blog.id == blogId,
                    orElse:
                        () => BlogModel(
                          id: 'not-found',
                          imageURL: '',
                          title: 'Blog Not Found',
                          summary:
                              'Sorry, the blog post you\'re looking for could not be found.',
                          content:
                              'Please go back and select another blog post.',
                          deeplink: '',
                        ),
                  );
                  return BlogDetailScreen(blog: blog);
                }
                return BlogListScreen();
              },
            );
          }
        }

        // If the route is not recognized
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(body: Center(child: Text('Route not found!'))),
        );
    }
  }
}

// Global navigator key for accessing the navigator from anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
