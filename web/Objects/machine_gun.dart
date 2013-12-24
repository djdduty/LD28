library MachineGun;

import 'box_model.dart';
import '../Core/core.dart';
import '../Rendering/rendering.dart';
import '../Math/glmatrix.dart';

class MachineGun
{
	BoxModel GunModel;
	Engine e = new Engine();
	Vector3 Position = new Vector3(0.0,0.0,0.0);
	Vector3 Velocity = new Vector3(0.0,0.0,0.0);
	Matrix Transform;
	double Size = 1.0;

	MachineGun(this.Size)
	{

	}

	void Init()
	{
		GunModel  = new BoxModel(19,10,Size,'Machinegun-render');
		GunModel.Init();
		List<int> Model = new List();
		Model = [
		0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,
		0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,0,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
		1,0,0,0,1,1,1,0,1,1,1,1,1,0,1,0,0,0,0,
		0,0,0,1,1,1,1,1,0,1,1,1,0,0,1,0,0,0,0,
		0,0,1,1,1,1,0,0,0,0,1,1,0,0,1,0,0,0,0,
		0,1,1,1,1,0,0,0,0,0,1,1,0,0,1,0,0,0,0,
		0,1,1,1,1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0];

		GunModel.SetModel(Model);

		new Engine().SetTest(3889);

		new Engine().LoadTexture('ump.png');
		GunModel.SetTexture('ump.png');

		Transform = GunModel.GetTransform();
		GunModel.Type = RenderableType.DEFAULT;
	}

	void AddToRenderList()
	{
		Renderer R = e.GetRenderer();
		R.AddRenderable(GunModel);
	}

	void Update()
	{
		Position.add(Velocity);
		Transform.translate(Velocity);
	}

	Matrix GetTransform()
	{
		return Transform;
	}

	void SetTransform(Matrix m)
	{
		GunModel.SetTransform(m);
	}
}