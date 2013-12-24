part of Entities;

abstract class Entity
{
	Vector3 Position;
	Collidable Shape;
	Level level;
	EntityRenderable RendComponent;
	String Name = '';

	void Init(Level l);

	void Update(num DeltaTime);

	void Move(num DeltaTime);

	void Die()
	{
		level.RemoveEntity(Name);
		new Engine().GetRenderer().RemoveRenderable(Name+'-render');
	}

	void AddToRenderList()
	{
		new Engine().GetRenderer().AddRenderable(RendComponent);
	}
}