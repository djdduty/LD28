part of Core;

abstract class State
{
	void Init(StateManager m);
	void DeInit();
	void OnActivate();
	void OnDeactivate();
	void Update(num DeltaTime);
}