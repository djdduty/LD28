part of Core;

class StateManager
{
	State TmpHolder;
	State CurrentState;

	StateManager(State s)
	{
		CurrentState = s;
	}

	void Init()
	{
		CurrentState.Init(this);
	}

	void ChangeState(State s, bool clear)
	{
		CurrentState.OnDeactivate();
		CurrentState.DeInit();
		CurrentState = s;
		if(clear)
		{
			new Engine().GetRenderer().ClearRenderables();
			new Engine().GetRenderer().ClearLights();
		}
		s.Init(this);

		//s.OnActivate();
	}

	void SwitchState(State s, bool clear)
	{
		CurrentState.OnDeactivate();
		CurrentState = s;
		if(clear)
		{
			new Engine().GetRenderer().ClearRenderables();
			new Engine().GetRenderer().ClearLights();
		}

		s.OnActivate();
	}

	void Update(num DeltaTime)
	{
		CurrentState.Update(DeltaTime);
	}

	State GetState()
	{
		return CurrentState;
	}
}
