abstract class BlogEvent {}

class LoadBlogs extends BlogEvent {}

class LoadBlogById extends BlogEvent {
  final String blogId;

  LoadBlogById(this.blogId);
}

class RefreshBlogs extends BlogEvent {}
