import 'package:bloc/bloc.dart';
import '../pages/homepage.dart';
import '../pages/myaccountspage.dart';
import '../pages/myorderspage.dart';
import '../pages/Wishlist.dart';
import '../pages/settings.dart';
import '../pages/logout.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  MyOrdersClickedEvent,
  wishlist,
  settings,
  logout,
}

abstract class NavigationStates {

}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => MyAccountsPage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    print(event);
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield MyAccountsPage();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield MyOrdersPage();
        break;
      case NavigationEvents.wishlist:
        yield Wishlist();
        break;
      case NavigationEvents.settings:
        yield Settings();
        break;
      case NavigationEvents.logout:
        yield LogOut();
        break;
    }
  }
}
