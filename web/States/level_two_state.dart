part of States;

class LevelTwoState extends State
{
	StateManager Manager;

	Character Char;
	State Owner;

	Level2 level2;

	Mouse mouse = new Mouse();
	Keyboard keyboard = new Keyboard();

	EntityRenderable CH;

	Vector3 CharPos;
	Vector3 MouseRot;

	LevelTwoState(this.Owner, this.Char)
	{
		this.Char = new Character(Char.Gun);
		level2 = new Level2(this.Char);
		new Engine().GetCamera().Rotation = new Vector3(0.0,0.0,0.0);
	}

	void Init(StateManager M)
	{
		new Engine().LoadTexture('Office.png');
		new Engine().LoadTexture('Entity.png');
		Manager = M;
		level2.Init(Owner);
		level2.AddToRenderList();

		window.onKeyDown.listen(OnKeyDown);
		mouse.BindMouseMove(OnMouseMove);
		mouse.BindMouseClick(OnMouseClick);
		mouse.Enable();

		CH = new EntityRenderable(0.3,7,'CH');
		CH.Init();
		CH.Type = RenderableType.TWODIM;
		new Engine().GetRenderer().AddRenderable(CH);
	}

	void Update(num DeltaTime)
	{
		level2.Update(DeltaTime);
	}

	void DeInit()
	{

	}

	OnKeyDown(KeyboardEvent e)
	{
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
		CharPos = new Vector3(Char.Position.X, Char.Position.Y, Char.Position.Z);
	}
}