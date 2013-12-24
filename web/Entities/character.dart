part of Entities;

class Character
{
	Vector3 Position = new Vector3(0.0,0.0,0.0);
	Collidable Shape;

	Vector3 Velocity = new Vector3(0.0,0.0,0.0);

	Level level;
	Keyboard keyboard = new Keyboard();

	bool CamAttached = true;

	MachineGun Gun;

	Character(this.Gun)
	{

	}

	double GunTimer = 0.0;
	double GunAnim = 0.0;
	double GunVel = 0.0032;

	int lifetime = 0;

	void Init(Level l)
	{
		Gun.GetTransform().indentify();
		Gun.GetTransform().rotateY(1.7);
		Gun.GetTransform().translate(new Vector3(1.0,-0.2,0.5));
		Gun.GunModel.Type = RenderableType.TWODIM;

		level = l;
		Shape = new Collidable(Position, 0.5);
		SetPosition();
	}

	void Update(num DeltaTime)
	{
		lifetime++;
		GunTimer++;
		HandleInput(DeltaTime);

		MoveX();
		MoveZ();

		Velocity.X = 0.0;
		Velocity.Y = 0.0;
		Velocity.Z = 0.0;

		SetPosition();

		if(GunTimer < 20)
		{
			GunAnim += GunVel*4.5;
			Gun.GetTransform().rotateZ(GunVel*4.5);
		} else if (GunTimer < 40){

			if(GunAnim >= 0.0)
			{
				GunAnim -= GunVel*4.5;
				Gun.GetTransform().rotateZ(-GunVel*4.5);
			}
		}
	}

	void HandleInput(num DeltaTime)
	{
		if(keyboard.isPressed(KeyCode.W))
		{
			Velocity.Z += 0.01*DeltaTime/5;
		}
		if(keyboard.isPressed(KeyCode.S))
		{
			Velocity.Z -= 0.01*DeltaTime/5;
		}
		if(keyboard.isPressed(KeyCode.A))
		{
			Velocity.X -= 0.01*DeltaTime/5;
		}
		if(keyboard.isPressed(KeyCode.D))
		{
			Velocity.X += 0.01*DeltaTime/5;
		}

		Velocity = MultByCamera(Velocity);
	}

	void MoveX()
	{
		Vector3 OldPos = Position;
		Position.X += Velocity.X;
		SetPosition();
		if(level.CheckCollision(Shape))
		{
			Position.X -= Velocity.X;
		}
		SetPosition();
	}

	void MoveZ()
	{
		Vector3 OldPos = Position;
		Position.Z += Velocity.Z;
		SetPosition();
		if(level.CheckCollision(Shape))
		{
			Position.Z -= Velocity.Z;
		}
		SetPosition();
	}

	void DetachCam()
	{
		CamAttached = false;
	}

	void AttachCam()
	{
		CamAttached = true;
	}

	void AddToRenderList()
	{
		//Gun.AddToRenderList();
	}

	void SetPosition()
	{
		Shape.Pos = Position;
		Shape.SetPos();

		if(CamAttached)
			new Engine().GetCamera().Position = new Vector3(Position.X, Position.Y, Position.Z);
	}

	Vector3 MultByCamera(Vector3 Vec)
	{
		if(CamAttached)
			return new Engine().GetCamera().MultByCamera(Vec);
		else
		return new Vector3(0.0,0.0,0.0);
	}

	void Shoot()
	{
		if(GunTimer > 40)
		{
			GunTimer = 0.0;
			Vector3 Dir = new Vector3(0.0,0.0,-1.0);
			Dir = MultByCamera(Dir);
			level.AddEntity(new Bullet(new Vector3(-Position.X, -Position.Y, -Position.Z), Dir, 'bullet:'+lifetime.toString()));
		}
	}
}