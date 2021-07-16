import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
  final _pagingController = PagingController<int, Movie>(
    firstPageKey: 1,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
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
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
          ),
        ),
      );
}
