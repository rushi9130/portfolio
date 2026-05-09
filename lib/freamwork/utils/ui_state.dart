

class UIState<T> {
  UIState({this.isLoading = false, this.success, this.request, this.isLoadMore = false});

  bool isLoading;
  T? success;
  dynamic request;
  bool isLoadMore;
}