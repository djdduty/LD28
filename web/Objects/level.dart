library Level;

import 'dart:math';

import 'box_model_layered.dart';
import '../Core/core.dart';
import '../Math/glmatrix.dart';
import '../Rendering/rendering.dart';
import '../Entities/entities.dart';
import 'cube_renderable.dart';
import '../Objects/machine_gun.dart';

part 'collidable.dart';

class Level
{
	List<Collidable> Collidables = new List();
	List<Entity> Entities = new List();
	BoxModelLayered Model;

	int NumLayers, LayerSize;
	double BlockSize=1.0;
	int CollideLayer = 1;

	Character char;

	double OffsetX = 0.0;
	double OffsetZ = 0.0;
	double gridOffX = 0.0;
	double gridOffZ = 0.0;


	Level(this.NumLayers, this.LayerSize, this.CollideLayer, this.char)
	{
		Model = new BoxModelLayered(LayerSize, LayerSize, NumLayers, BlockSize, 'Level');
		Model.Init();

		char.Init(this);
	}

	void SetData(List<int> Indices)
	{
		Model.SetModel(Indices);
		Model.GetTransform().translate(new Vector3(-5.0,-1.5,-7.05));
		Model.Type = RenderableType.DEFAULT;
		List<int> Inverse = new List();
		for(int i = Indices.length-1; i >= 0; i--)
		{
			Inverse.add(Indices[i]);
		}
		if(Indices.length == LayerSize*LayerSize*NumLayers)
		{
			for(int y = CollideLayer; y < CollideLayer+1; y++)
			{
				for(int x = 0; x < LayerSize; x++)
				{
					for(int z = 0; z < LayerSize; z++)
					{
						if (Inverse[z*LayerSize+x+(y.toInt()*(LayerSize*LayerSize))] != 0)
						{
							AddCollidable(x.toDouble()-5.0+OffsetX, y.toDouble()-1, z.toDouble()-2.75+OffsetZ);
						}
					}
				}
			}
		}
	}

	void AddCollidable(double x, double y, double z)
	{
		//Collidable Tmp =
		//Tmp.SetPos();
		Collidables.add(new Collidable(new Vector3(x, y, z), BlockSize));
	}

	void AddCollidablesToRender()
	{
		for(int i = 0; i < Collidables.length; i++)
		{
			CubeRenderable Tmp = new CubeRenderable(BlockSize);
			Tmp.Init();
			Tmp.GetTransform().translate(new Vector3 (Collidables[i].Pos.X-OffsetX+gridOffX,Collidables[i].Pos.Y,Collidables[i].Pos.Z-OffsetZ+gridOffZ));
			//Tmp.Type = RenderableType.TWODIM;
			new Engine().GetRenderer().AddRenderable(Tmp);
		}
	}

	void AddToRenderList()
	{
		new Engine().GetRenderer().AddRenderable(Model);

		for(int i = 0; i < Entities.length; i++)
		{
			new Engine().GetRenderer().AddRenderable(Entities[i].RendComponent);
		}
	}

	void Update(num DeltaTime)
	{
		char.Update(DeltaTime);

		for(int i = 0; i < Entities.length; i++)
		{
			Entities[i].Update(DeltaTime);
		}
	}

	bool CheckCollision(Collidable Shape)
	{
		for(int i = 0; i < Collidables.length; i++)
		{
			if(Collidables[i].SquareCollision(Shape))
			{
				//print('Collision');
				return true;
			}
		}
		return false;
	}

	Entity CheckEntityCollision(Entity Primary)
	{
		for(int i = 0; i < Entities.length; i++)
		{
			if(Entities[i].Name.contains('mob', 0) && Entities[i].Shape.SquareCollision(Primary.Shape))
				return Entities[i];
		}
		return null;
	}

	void AddEntity(Entity E)
	{
		E.Init(this);
		Entities.add(E);
	}

	void RemoveEntity(String name)
	{
		for(int i = 0; i < Entities.length; i++)
		{
			if(Entities[i].Name == name)
			{
				Entities.removeAt(i);
			}
		}
	}
}