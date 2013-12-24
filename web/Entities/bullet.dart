part of Entities;

class Bullet extends Entity
{
	Vector3 Dir;
	Vector3 Velocity = new Vector3(0.02,0.02,0.02);
	int LifeTime = 0;
	int MaxLife = 2000;

	Bullet(Vector3 Vec, this.Dir, String Name)
	{
		this.Name = Name;
		this.Position = Vec;
	}

	void Init(Level l)
	{
		this.level = l;
		RendComponent = new EntityRenderable(0.05,2, Name+'-render');
		RendComponent.Init();
		RendComponent.Type = RenderableType.ENTITY;

		new Engine().GetRenderer().AddRenderable(RendComponent);
		Shape = new Collidable(new Vector3(Position.Z, Position.Y, Position.Z), 0.05);
	}

	void Update(num DeltaTime)
	{
		LifeTime += DeltaTime;
		if(LifeTime >= MaxLife)
			Die();


		RendComponent.SetTransform(new Matrix.identity());
		RendComponent.GetTransform().translate(Position);

		Move(DeltaTime);
		Entity Other = level.CheckEntityCollision(this);
		if(Other != null)
		{
			Other.Die();
			Die();
		}
	}

	void Move(num DeltaTime)
	{
		Position.X += Dir.X * Velocity.X;
		Position.Y += Dir.Y * Velocity.Y;
		Position.Z += Dir.Z * Velocity.Z;


		Shape.Pos = new Vector3(Position.X, Position.Y, Position.Z);
		Shape.SetPos();
	}
}