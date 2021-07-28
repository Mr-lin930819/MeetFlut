import 'package:meet_flut/entry/page/page_state.dart';

typedef _LoadAction<T, Condition> = Future<List<T>?> Function(
    int page, Condition? condition);

class PageHandler<T, Condition> {
  int _curPage = 1;
  List<T> _cachedList = [];
  Condition? _cachedCondition;
  _LoadAction<T, Condition>? __loadAction;

  PageHandler(this.__loadAction);

  Future<PageCompletedState> refresh(Condition condition) async {
    try {
      final result = await __loadAction?.call(1, condition);
      if (result != null) {
        _curPage = 2;
        _cachedList = result;
        _cachedCondition = condition;
        return PageSuccessState(result, noMoreData: result.isEmpty);
      } else {
        return PageFailState(true);
      }
    } on PageFailException catch (e) {
      return PageFailState(false, e.message);
    }
  }

  Future<PageCompletedState> loadMore() async {
    try {
      final albumList = await __loadAction?.call(_curPage, _cachedCondition);
      if (albumList != null) {
        _curPage++;
        _cachedList.addAll(albumList);
        return PageSuccessState(_cachedList,
            isRefresh: false, noMoreData: albumList.isEmpty);
      } else {
        return PageFailState(false);
      }
    } on PageFailException catch (e) {
      return PageFailState(false, e.message);
    }
  }
}

class PageFailException implements Exception {
  String message;

  PageFailException(this.message);
}
