import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/blog_bloc.dart';
import '../widget/blog_card_widget.dart';
import '../bloc/bloc_state.dart';

class BlogListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blog Posts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BlogLoaded) {
            return _buildBlogList(context, state);
          } else if (state is BlogError) {
            return Center(
              child: Text(state.message, style: TextStyle(color: Colors.red)),
            );
          }
          return Center(
            child: Text('Something went wrong. Please try again later.'),
          );
        },
      ),
    );
  }

  Widget _buildBlogList(BuildContext context, BlogLoaded state) {
    final blogs = state.blogs;
    final highlightedBlogId = state.highlightedBlogId;

    if (blogs.isEmpty) {
      return Center(child: Text('No blog posts available.'));
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: blogs.length,
      itemBuilder: (context, index) {
        final blog = blogs[index];
        final isHighlighted = blog.id == highlightedBlogId;

        if (isHighlighted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Scrollable.ensureVisible(
              context,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        }

        return BlogCard(blog: blog, isHighlighted: isHighlighted);
      },
    );
  }
}
