import '../Rendering/rendering.dart';
import '../Core/core.dart';
import '../Math/glmatrix.dart';
import 'dart:typed_data';
import 'dart:web_gl' as GL;

class BoxModel extends Renderable
{
	Engine gEngine = new Engine();
	GL.UniformLocation SamplerLocation;

	double CubeSize;
	int width, height;

	BoxModel(int width, int height, this.CubeSize, String Name)
	{
		this.Name = Name;
		List<double> InfoList = new List();
		this.width = width;
		this.height = height;
	}

	void Init()
	{
		TexName = 'b3.png';

		SetSamplerLoc();

		Transform = new Matrix.identity();

		GL.RenderingContext Context = gEngine.GetContext();
		Context.bindBuffer(GL.ARRAY_BUFFER, Data);
	}

	void SetModel(List<int> Indices)
	{

	List<double> InfoList = new List();
		int items = 0;
		if(Indices.length == width*height)
		{
			for(int x = 0; x < width; x++)
			{
				for(int y = 0; y < height; y++)
				{
					if (Indices[y*width+x] != 0)
					{
						items += AddBox(InfoList, x.toDouble(), -y.toDouble(), 0.0, Indices[y*width+x], Indices, y*width+x);
					}
				}
			}
		}

		Update(InfoList);

		NumVerts = items;
		NumNormals = items;
	}

	void Update(List<double> InfoList)
	{
		Float32List Info = new Float32List.fromList(InfoList);

		new Engine().GetContext().bufferData(GL.ARRAY_BUFFER, Info, GL.STATIC_DRAW);
	}

	void SetTexture(String Name)
	{
		TexName = Name;
	}

	void SetSamplerLoc()
	{
		if(Type == RenderableType.DEFAULT || Type == RenderableType.ENTITY)
		SamplerLocation = new Engine().GetRenderer().GetUniformLocationDefault("Texture");

		if(Type == RenderableType.TWODIM)
		SamplerLocation = new Engine().GetRenderer().GetUniformLocationText("Texture");
	}

	void Render(int VertAttrib, int NormAttrib, int UVAttrib)
	{
		GL.RenderingContext Context = new Engine().GetContext();
		Context.enableVertexAttribArray(VertAttrib);
		Context.enableVertexAttribArray(NormAttrib);
		Context.enableVertexAttribArray(UVAttrib);

		new Engine().BindTexture(TexName, 0);
		Context.uniform1i(SamplerLocation, 0);

		Context.bindBuffer(GL.ARRAY_BUFFER, this.Data);
		Context.vertexAttribPointer(VertAttrib, 3, GL.FLOAT, false, 32, 0);
		Context.vertexAttribPointer(NormAttrib, 3, GL.FLOAT, false, 32, 12);
		Context.vertexAttribPointer(UVAttrib, 2, GL.FLOAT, false, 32, 24);
		Context.drawArrays(GL.TRIANGLES, 0, NumVerts);

		Context.disableVertexAttribArray(VertAttrib);
		Context.disableVertexAttribArray(NormAttrib);
		Context.disableVertexAttribArray(UVAttrib);
	}

	int AddBox(List<double>InfoList, double x, double y, double z, int TexIndex, List<int> Indices, int index)
	{
		List<double> Verts = new List();
		List<double> Norms = new List();
		List<double> Uvs = new List();
		Vector3 v1,v2,v3,v4,v5,v6,v7,v8;

		double v = CubeSize;
		double n = 0.0;

		double x2 = x*CubeSize;
		double y2 = y*CubeSize;
		v1 = new Vector3(x2+n,y2+n,z+v);
		v2 = new Vector3(x2+v,y2+n,z+v);
		v3 = new Vector3(x2+v,y2+v,z+v);
		v4 = new Vector3(x2+n,y2+v,z+v);
		v5 = new Vector3(x2+v,y2+n,z+n);
		v6 = new Vector3(x2+n,y2+n,z+n);
		v7 = new Vector3(x2+n,y2+v,z+n);
		v8 = new Vector3(x2+v,y2+v,z+n);

		double TCWSize = (1 / 8);
		double TCHSize = 1.0;//(64.0 / 64.0);
		double TexelOffset = 1.0/256;

		Vector2 TopLeft = new Vector2((TCWSize*TexIndex)+TexelOffset, 0.0);
		Vector2 TopRight = new Vector2((TCWSize*TexIndex+TCWSize)-TexelOffset, 0.0);
		Vector2 BottomLeft = new Vector2((TCWSize*TexIndex)+TexelOffset, TCHSize);
		Vector2 BottomRight = new Vector2((TCWSize*TexIndex+TCWSize)-TexelOffset, TCHSize);

		int Items = 0;

		//back
		Verts.add(v1.X);Verts.add(v1.Y);Verts.add(v1.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(1.0);
		Verts.add(v2.X);Verts.add(v2.Y);Verts.add(v2.Z); /**/ Items++; /**/ Uvs.add(BottomLeft.X);Uvs.add(BottomLeft.Y); 	/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(1.0);
		Verts.add(v3.X);Verts.add(v3.Y);Verts.add(v3.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(1.0);

		Verts.add(v1.X);Verts.add(v1.Y);Verts.add(v1.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(1.0);
		Verts.add(v3.X);Verts.add(v3.Y);Verts.add(v3.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(1.0);
		Verts.add(v4.X);Verts.add(v4.Y);Verts.add(v4.Z); /**/ Items++; /**/ Uvs.add(TopRight.X);Uvs.add(TopRight.Y); 		/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(1.0);

		//front
		Verts.add(v5.X);Verts.add(v5.Y);Verts.add(v5.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(-1.0);
		Verts.add(v6.X);Verts.add(v6.Y);Verts.add(v6.Z); /**/ Items++; /**/ Uvs.add(BottomLeft.X);Uvs.add(BottomLeft.Y);	/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(-1.0);
		Verts.add(v7.X);Verts.add(v7.Y);Verts.add(v7.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(-1.0);

		Verts.add(v5.X);Verts.add(v5.Y);Verts.add(v5.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(-1.0);
		Verts.add(v7.X);Verts.add(v7.Y);Verts.add(v7.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(-1.0);
		Verts.add(v8.X);Verts.add(v8.Y);Verts.add(v8.Z); /**/ Items++; /**/ Uvs.add(TopRight.X);Uvs.add(TopRight.Y); 		/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(-1.0);

		//Right
		if(((index+1)%width) == 0 || index == Indices.length-1 || Indices[index+1] == 0)
		{
			Verts.add(v2.X);Verts.add(v2.Y);Verts.add(v2.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(1.0);Norms.add(0.0);Norms.add(0.0);
			Verts.add(v5.X);Verts.add(v5.Y);Verts.add(v5.Z); /**/ Items++; /**/ Uvs.add(BottomLeft.X);Uvs.add(BottomLeft.Y); 	/**/ Norms.add(1.0);Norms.add(0.0);Norms.add(0.0);
			Verts.add(v8.X);Verts.add(v8.Y);Verts.add(v8.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(1.0);Norms.add(0.0);Norms.add(0.0);

			Verts.add(v2.X);Verts.add(v2.Y);Verts.add(v2.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(1.0);Norms.add(0.0);Norms.add(0.0);
			Verts.add(v8.X);Verts.add(v8.Y);Verts.add(v8.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(1.0);Norms.add(0.0);Norms.add(0.0);
			Verts.add(v3.X);Verts.add(v3.Y);Verts.add(v3.Z); /**/ Items++; /**/ Uvs.add(TopRight.X);Uvs.add(TopRight.Y); 		/**/ Norms.add(1.0);Norms.add(0.0);Norms.add(0.0);
		}

		//Left
		if(index == 0 || Indices[index-1] == 0 || index%width == 0)
		{
			Verts.add(v6.X);Verts.add(v6.Y);Verts.add(v6.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(-1.0);Norms.add(0.0);Norms.add(0.0);
			Verts.add(v1.X);Verts.add(v1.Y);Verts.add(v1.Z); /**/ Items++; /**/ Uvs.add(BottomLeft.X);Uvs.add(BottomLeft.Y); 	/**/ Norms.add(-1.0);Norms.add(0.0);Norms.add(0.0);
			Verts.add(v4.X);Verts.add(v4.Y);Verts.add(v4.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(-1.0);Norms.add(0.0);Norms.add(0.0);

			Verts.add(v6.X);Verts.add(v6.Y);Verts.add(v6.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(-1.0);Norms.add(0.0);Norms.add(0.0);
			Verts.add(v4.X);Verts.add(v4.Y);Verts.add(v4.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(-1.0);Norms.add(0.0);Norms.add(0.0);
			Verts.add(v7.X);Verts.add(v7.Y);Verts.add(v7.Z); /**/ Items++; /**/ Uvs.add(TopRight.X);Uvs.add(TopRight.Y); 		/**/ Norms.add(-1.0);Norms.add(0.0);Norms.add(0.0);
		}

		//Top
		if(index < width || Indices[index-width] == 0)
		{
			Verts.add(v4.X);Verts.add(v4.Y);Verts.add(v4.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(0.0);Norms.add(1.0);Norms.add(0.0);
			Verts.add(v3.X);Verts.add(v3.Y);Verts.add(v3.Z); /**/ Items++; /**/ Uvs.add(BottomLeft.X);Uvs.add(BottomLeft.Y); 	/**/ Norms.add(0.0);Norms.add(1.0);Norms.add(0.0);
			Verts.add(v8.X);Verts.add(v8.Y);Verts.add(v8.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(0.0);Norms.add(1.0);Norms.add(0.0);

			Verts.add(v4.X);Verts.add(v4.Y);Verts.add(v4.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(0.0);Norms.add(1.0);Norms.add(0.0);
			Verts.add(v8.X);Verts.add(v8.Y);Verts.add(v8.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(0.0);Norms.add(1.0);Norms.add(0.0);
			Verts.add(v7.X);Verts.add(v7.Y);Verts.add(v7.Z); /**/ Items++; /**/ Uvs.add(TopRight.X);Uvs.add(TopRight.Y); 		/**/ Norms.add(0.0);Norms.add(1.0);Norms.add(0.0);
		}

		//Bottom
		if(index > (Indices.length - width-1) || Indices[index+width] == 0)
		{
			Verts.add(v6.X);Verts.add(v6.Y);Verts.add(v6.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(0.0);Norms.add(-1.0);Norms.add(0.0);
			Verts.add(v5.X);Verts.add(v5.Y);Verts.add(v5.Z); /**/ Items++; /**/ Uvs.add(BottomLeft.X);Uvs.add(BottomLeft.Y); 	/**/ Norms.add(0.0);Norms.add(-1.0);Norms.add(0.0);
			Verts.add(v2.X);Verts.add(v2.Y);Verts.add(v2.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(0.0);Norms.add(-1.0);Norms.add(0.0);

			Verts.add(v6.X);Verts.add(v6.Y);Verts.add(v6.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(0.0);Norms.add(-1.0);Norms.add(0.0);
			Verts.add(v2.X);Verts.add(v2.Y);Verts.add(v2.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(0.0);Norms.add(-1.0);Norms.add(0.0);
			Verts.add(v1.X);Verts.add(v1.Y);Verts.add(v1.Z); /**/ Items++; /**/ Uvs.add(TopRight.X);Uvs.add(TopRight.Y); 		/**/ Norms.add(0.0);Norms.add(-1.0);Norms.add(0.0);
		}

		for(int i = 0; i < Items; i++)
		{
			InfoList.add(Verts[3*i+0]);
			InfoList.add(Verts[3*i+1]);
			InfoList.add(Verts[3*i+2]);

			InfoList.add(Norms[3*i+0]);
			InfoList.add(Norms[3*i+1]);
			InfoList.add(Norms[3*i+2]);

			InfoList.add(Uvs[2*i+0]);
			InfoList.add(Uvs[2*i+1]);
		}

		return Items;
	}
}