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
  String? _failMsg;
  PageFailState(bool isRefresh, [this._failMsg]) : super(isRefresh);

  String get failMsg => _failMsg ?? "";
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
      } else if (!newState.noMoreData) {
        loadComplete();
      }
    }
    return true;
  }
}
