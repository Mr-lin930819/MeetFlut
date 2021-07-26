import 'package:pull_to_refresh/pull_to_refresh.dart';
export 'package:meet_flut/entry/page/page_state.dart' show RefreshControllerEx;

abstract class PageCompletedState {
  final bool isRefresh;

  PageCompletedState(this.isRefresh);
}

class PageSuccessState<T> extends PageCompletedState {
  final List<T> list;
  final bool noMoreData;

  PageSuccessState(this.list, {bool isRefresh = true, this.noMoreData = false})
      : super(isRefresh);
}

class PageFailState extends PageCompletedState {
  PageFailState(bool isRefresh) : super(isRefresh);
}

extension RefreshControllerEx on RefreshController {
  bool handlePageState(PageCompletedState newState) {
    if (newState is PageFailState) {
      if (newState.isRefresh) {
        refreshFailed();
      } else {
        loadFailed();
      }
      return false;
    }
    if (newState is PageSuccessState) {
      if (newState.noMoreData) {
        loadNoData();
      } else {
        resetNoData();
      }
      if (newState.isRefresh) {
        refreshCompleted();
      } else {
        loadComplete();
      }
    }
    return true;
  }
}
