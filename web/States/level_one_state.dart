part of States;

class LevelOneState extends State
{
	StateManager Manager;

	Character Char;
	State Owner;

	Level1 level;

	Mouse mouse = new Mouse();
	Keyboard keyboard = new Keyboard();

	EntityRenderable CH;

	Vector3 CharPos;
	Vector3 MouseRot;

	LevelOneState(this.Owner, this.Char)
	{
	}

	void Init(StateManager M)
	{
		Manager = M;
		level = new Level1(Char, M);
		new Engine().LoadTexture('Office.png');
		new Engine().LoadTexture('Entity.png');

		level.Init(Owner);
		level.AddToRenderList();
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
		level.Update(DeltaTime);
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