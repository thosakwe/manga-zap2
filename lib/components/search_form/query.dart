class SearchQuery {
  final List<String> categories = [];
  String title;

  void clear() {
    title = '';
    categories.clear();
  }
}