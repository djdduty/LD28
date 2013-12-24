part of States;

class GameState extends State
{
	Engine e = new Engine();
	StateManager Manager;

	LevelWrapper level;

	Vector3 MouseRot;
	Vector3 CharPos;

	EntityRenderable CH;

	Collidable MenuC;

	Keyboard keyboard = new Keyboard();
	Mouse mouse = new Mouse();

	Character Char;

	GameState( MachineGun Gun)
	{
		Char = new Character(Gun);
		level = new Level1(Char);
	}

	void Init(StateManager m)
	{
		level.Init(new LevelState(Char.Gun));

		Manager = m;

		new Engine().LoadTexture('b3.png');
		new Engine().LoadTexture('Office.png');
		new Engine().LoadTexture('Entity.png');

		mouse.BindMouseMove(OnMouseMove);
		mouse.BindMouseClick(OnMouseClick);
		mouse.Enable();

		MenuC = new Collidable(new Vector3(0.0,0.0,0.0),1.0);

		window.onKeyDown.listen(OnKeyDown);

		level.AddToRenderList();

		CH = new EntityRenderable(0.3,7,'CH');
		CH.Init();
		CH.Type = RenderableType.TWODIM;
		new Engine().GetRenderer().AddRenderable(CH);
	}

	void DeInit()
	{
		OnDeactivate();
	}

	void Update(num DeltaTime)
	{
		level.Update(DeltaTime);
	}

	OnKeyDown(KeyboardEvent e)
	{
		if(e.keyCode == KeyCode.E)
		{
			//if(MenuC.Collision(Char.Shape))
			//{
				//Manager.ChangeState(Menu, true);
			//}
		}
	}

	void OnMouseClick(Event event)
	{
		if(mouse.Enabled)
		{
			Char.Shoot();
		}
	}

	void OnMouseMove(MouseEvent Event)
	{
		if(!mouse.MouseLocked)
			return;

		Vector2 Rotation = new Vector2(Event.movement.y/200, Event.movement.x/200);
		new Engine().GetCamera().RotateCamera(Rotation);
	}

	void OnActivate()
	{
		Char.AttachCam();
		mouse.Enable();
		Char.SetPosition();
		new Engine().GetCamera().Rotation = MouseRot;
	}

	void OnDeactivate()
	{
		Char.DetachCam();
		mouse.Disable();
		MouseRot = new Engine().GetCamera().Rotation;
		CharPos = Char.Position;
	}
}