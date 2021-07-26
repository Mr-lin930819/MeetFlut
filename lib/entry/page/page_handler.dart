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
    final result = await __loadAction?.call(1, condition);
    if (result != null) {
      _curPage = 2;
      _cachedList = result;
      _cachedCondition = condition;
      return PageSuccessState(result);
    } else {
      return PageFailState(true);
    }
  }

  Future<PageCompletedState> loadMore() async {
    final albumList = await __loadAction?.call(_curPage, _cachedCondition);
    if (albumList != null) {
      _curPage++;
      _cachedList.addAll(albumList);
      return PageSuccessState(_cachedList, isRefresh: false);
    } else {
      return PageFailState(false);
    }
  }
}
