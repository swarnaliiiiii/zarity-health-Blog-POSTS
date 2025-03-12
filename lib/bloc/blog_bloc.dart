import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/blog_model.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final FirebaseFirestore _firestore;

  BlogBloc({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      super(BlogInitial()) {
    on<LoadBlogs>(_onLoadBlogs);
    on<LoadBlogById>(_onLoadBlogById);
    on<RefreshBlogs>(_onRefreshBlogs);
  }

  Future<void> _onLoadBlogs(LoadBlogs event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    try {
      final blogs = await _fetchBlogs();
      emit(BlogLoaded(blogs: blogs));
    } catch (e, stackTrace) {
      print("Error loading blogs: $e\n$stackTrace");
      emit(BlogError("Unable to load blogs. Please try again."));
    }
  }

  Future<void> _onLoadBlogById(
    LoadBlogById event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());
    try {
      final doc = await _firestore.collection('blogs').doc(event.blogId).get();
      if (!doc.exists) {
        emit(BlogError("Blog not found"));
        return;
      }

      final blog = BlogModel.fromMap(
        doc.id,
        doc.data() as Map<String, dynamic>,
      );
      emit(BlogLoaded(blogs: [blog], highlightedBlogId: event.blogId));
    } catch (e, stackTrace) {
      print("Error loading blog by ID: $e\n$stackTrace");
      emit(BlogError("Unable to load the blog."));
    }
  }

  Future<void> _onRefreshBlogs(
    RefreshBlogs event,
    Emitter<BlogState> emit,
  ) async {
    if (state is! BlogLoaded) return;

    try {
      final blogs = await _fetchBlogs();
      emit(BlogLoaded(blogs: blogs));
    } catch (e, stackTrace) {
      print("Error refreshing blogs: $e\n$stackTrace");
      emit(BlogError("Failed to refresh blogs."));
    }
  }

  Future<List<BlogModel>> _fetchBlogs() async {
    final querySnapshot = await _firestore.collection('blogs').get();
    return querySnapshot.docs
        .map((doc) => BlogModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
