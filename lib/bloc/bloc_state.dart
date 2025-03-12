import 'package:blog_posts/models/blog_model.dart';

abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<BlogModel> blogs;
  final String? highlightedBlogId;

  BlogLoaded({required this.blogs, this.highlightedBlogId});

  BlogLoaded copyWith({List<BlogModel>? blogs, String? highlightedBlogId}) {
    return BlogLoaded(
      blogs: blogs ?? this.blogs,
      highlightedBlogId: highlightedBlogId ?? this.highlightedBlogId,
    );
  }
}

class BlogError extends BlogState {
  final String message;

  BlogError(this.message);
}
