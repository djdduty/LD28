import 'Core/core.dart';
import 'States/menu_state.dart';

void main() {
	Engine e = new Engine();
	MenuState s = new MenuState(false);

	e.InitGame(s);
	e.Run();
}
