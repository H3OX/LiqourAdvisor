import 'home_page.dart';

double processResponse(MLResponse) {
  if (HomePageState.effect == 1) {
    return (MLResponse / 4);
  }
  else if (HomePageState.effect == 2) {
    return (MLResponse / 2);
  }
  else if (HomePageState.effect == 3) {
    return (MLResponse * 0.75);
  }
  else {
    return (MLResponse).toDouble();
  }
}
