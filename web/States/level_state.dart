part of States;

class LevelState extends State
{
	StateManager Manager;

	State Level1State;
	State Level2State;
	State Level3State;
	State Level4State;

	Character Char;
	MachineGun Gun;

	LevelState(this.Gun)
	{
		Char = new Character(Gun);
	}

	void Init(StateManager M)
	{
		Manager = M;

		if(!new Engine().HasFriend1)
		{
			LoadFirstLevel();
			return;
		}

		if(!new Engine().HasFriend2)
		{
			LoadSecondLevel();
			return;
		}
	}

	void LoadFirstLevel()
	{
		Level1State = new LevelOneState(this, Char);
		Level1State.Init(Manager);
		Manager.ChangeState(Level1State, false);
	}

	void LoadSecondLevel()
	{
		Level2State = new LevelTwoState(this, Char);
		Level2State.Init(Manager);
		Manager.ChangeState(Level2State, false);
	}

	void DeInit()
	{

	}

	void Update(num DeltaTime)
	{

	}

	void OnActivate()
	{

	}

	void OnDeactivate()
	{

	}
}