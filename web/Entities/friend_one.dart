part of Entities;

class FriendOne extends Entity
{
	FriendOne(String Name, Vector3 Vec)
	{
		this.Name = Name;
		this.Position = Vec;
	}

	void Init(Level l)
	{
		this.level = l;
		RendComponent = new EntityRenderable(0.5,3,Name+'-render');
		RendComponent.Init();
		RendComponent.Type = RenderableType.ENTITY;

		Shape = new Collidable(new Vector3(Position.X, Position.Y, -Position.Z),1.0);
	}

	void Update(num DeltaTime)
	{
		RendComponent.SetTransform(new Matrix.identity());
		RendComponent.GetTransform().translate(Position);
		Shape.SetPos();
	}

	void Move(num DeltaTime)
	{

	}
}