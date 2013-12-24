part of Entities;

class Mob1 extends Entity
{
	Mob1(String Name, Vector3 Vec)
	{
		this.Name = Name;
		this.Position = Vec;
	}

	void Init(Level l)
	{
		this.level = l;
		RendComponent = new EntityRenderable(0.5,1,Name+'-render');
		RendComponent.Init();
		RendComponent.Type = RenderableType.ENTITY;

		Shape = new Collidable(new Vector3(Position.X, Position.Y, Position.Z),0.5);
	}

	void Update(num DeltaTime)
	{
		RendComponent.SetTransform(new Matrix.identity());
		RendComponent.GetTransform().translate(Position);
	}

	void Move(num DeltaTime)
	{

	}
}