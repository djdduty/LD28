library font3d;

import 'box_model.dart';
import '../Math/glmatrix.dart';
import '../Utils/font_arrays.dart';
import '../Core/core.dart';
import '../Rendering/rendering.dart';

class ThreeDString
{
	Vector2 Pos = new Vector2(0.0,0.0);
	double Size;
	String Content;
	List<BoxModel> Models;
	Vector3 RotationDelta = new Vector3(0.0,0.0,0.0);
	double Spacing = 0.1;

	ThreeDString(this.Pos, this.Size, this.Content)
	{
		Content = Content.toUpperCase();
		Models = new List();
		new Engine().LoadTexture('b3.png');
		Spacing = Size*5;
	}

	void Update()
	{
		for(int i = 0; i < Models.length; i++)
		{
			Models[i].GetTransform().indentify();
			Models[i].GetTransform().translate(new Vector3(Pos.X,Pos.Y, -1.0));
			Models[i].GetTransform().rotateX(RotationDelta.X);
			Models[i].GetTransform().rotateY(RotationDelta.Y);
			Models[i].GetTransform().rotateZ(RotationDelta.Z);
			Models[i].GetTransform().translate(new Vector3((i*Spacing)-Models.length/18,Size*1.2,0.0));
		}
		RotationDelta = new Vector3(0.0,0.0,0.0);
	}

	Vector3 GetRotation()
	{
		return RotationDelta;
	}

	void SetSize(double Size)
	{
		this.Size = Size;
	}

	Vector3 SetRotation(Vector3 Vec)
	{
		RotationDelta = Vec;
	}

	void Init()
	{
		new Engine().LoadTexture('font.png');
		for(int i2 = 0; i2 < Content.length; i2++)
		{
			BoxModel tmp = new BoxModel(4,5,Size, Content);
			tmp.Init();
			tmp.GetTransform().translate(new Vector3(Pos.X+i2*Spacing, Pos.Y, -1.0));
			tmp.CubeSize = Size;
			switch (Content.codeUnitAt(i2))
			{
				case 65:
					tmp.SetModel(a);
					break;
				case 66:
					tmp.SetModel(b);
					break;
				case 67:
					tmp.SetModel(c);
					break;
				case 68:
					tmp.SetModel(d);
					break;
				case 69:
					tmp.SetModel(e);
					break;
				case 70:
					tmp.SetModel(f);
					break;
				case 71:
					tmp.SetModel(g);
					break;
				case 72:
					tmp.SetModel(h);
					break;
				case 73:
					tmp.SetModel(i);
					tmp.GetTransform().translate(new Vector3(-0.8, 0.0, 0.0));
					break;
				case 74:
					tmp.SetModel(j);
					break;
				case 75:
					tmp.SetModel(k);
					break;
				case 76:
					tmp.SetModel(l);
					break;
				case 77:
					tmp = new BoxModel(5,5,Size,Content);
					tmp.Init();
					tmp.GetTransform().translate(new Vector3((Pos.X+i2*Spacing)-0.5, Pos.Y, -1.0));
					tmp.CubeSize = Size;
					tmp.SetModel(m);
					break;
				case 78:
					tmp.SetModel(n);
					break;
				case 79:
					tmp.SetModel(o);
					break;
				case 80:
					tmp.SetModel(p);
					break;
				case 81:
					tmp.SetModel(q);
					break;
				case 82:
					tmp.SetModel(r);
					break;
				case 83:
					tmp.SetModel(s);
					break;
				case 84:
					tmp.SetModel(t);
					tmp.GetTransform().translate(new Vector3(-0.8, 0.0, 0.0));
					break;
				case 85:
					tmp.SetModel(u);
					break;
				case 86:
					tmp.SetModel(v);
					break;
				case 87:
					tmp = new BoxModel(5,5,Size,Content);
					tmp.Init();
					tmp.GetTransform().translate(new Vector3((Pos.X+i2*Spacing)-0.5, Pos.Y, -1.0));
					tmp.CubeSize = Size;
					tmp.SetModel(w);
					break;
				case 88:
					tmp.SetModel(x);
					break;
				case 89:
					tmp.SetModel(y);
					break;
				case 90:
					tmp.SetModel(z);
					break;
				case 32:
					tmp.SetModel(space);
					break;
				case 33:
					tmp.SetModel(exclamation);
					break;
				case 48:
					tmp.SetModel(zero);
					break;
				case 49:
					tmp.SetModel(one);
					break;
				case 50:
					tmp.SetModel(two);
					break;
				case 51:
					tmp.SetModel(three);
					break;
				case 52:
					tmp.SetModel(four);
					break;
				case 53:
					tmp.SetModel(five);
					break;
				case 54:
					tmp.SetModel(six);
					break;
				case 55:
					tmp.SetModel(seven);
					break;
				case 56:
					tmp.SetModel(eight);
					break;
				case 57:
					tmp.SetModel(nine);
					break;
				default:
					tmp.SetModel(a);
					break;
			}
			tmp.CubeSize = Size;
			tmp.SetTexture('font.png');
			tmp.Type = RenderableType.DEFAULT;
			Models.add(tmp);
		}
	}

	void AddToRenderList()
	{
		for(int i = 0; i < Models.length; i++)
		{
			new Engine().GetRenderer().AddRenderable(Models[i]);
		}
	}

	void Die()
	{
		new Engine().GetRenderer().RemoveRenderable(Content);
	}
}