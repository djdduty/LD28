library EntityRenderable;

import '../Rendering/rendering.dart';
import '../Core/core.dart';
import '../Math/glmatrix.dart';
import '../Utils/utils.dart';
import 'dart:typed_data';
import 'dart:web_gl' as GL;

class EntityRenderable extends Renderable
{
	Engine gEngine = new Engine();
	GL.UniformLocation SamplerLocation;

	double Size = 1.0;

	int TexIndex;

	EntityRenderable(this.Size, this.TexIndex, String Name)
	{
		this.Name = Name;
	}

	void Init()
	{
		TexName = 'Entity.png';

		Transform = new Matrix.identity();
		Transform.translate(new Vector3(0.0,0.0,-5.0));

		GL.RenderingContext Context = gEngine.GetContext();
		Context.bindBuffer(GL.ARRAY_BUFFER, Data);

		List<double> InfoList = new List();

		int items = CreatePlane(Size, InfoList, TexIndex, 32, 256);

		Float32List Info = new Float32List.fromList(InfoList);

		Context.bufferData(GL.ARRAY_BUFFER, Info, GL.STATIC_DRAW);

		NumVerts = items;
		NumNormals = items;
	}

	void SetTexture(String Name)
	{
		TexName = Name;
	}

	void SetSamplerLoc(GL.UniformLocation loc)
	{
		SamplerLocation = loc;
	}

	void Render(int VertAttrib, int NormAttrib, int UVAttrib)
	{
		GL.RenderingContext Context = new Engine().GetContext();
		Context.enableVertexAttribArray(VertAttrib);
		Context.enableVertexAttribArray(NormAttrib);
		Context.enableVertexAttribArray(UVAttrib);

		new Engine().BindTexture(TexName, 0);
		Context.uniform1i(SamplerLocation, 0);

		Context.bindBuffer(GL.ARRAY_BUFFER, Data);
		Context.vertexAttribPointer(VertAttrib, 3, GL.FLOAT, false, 32, 0);
		Context.vertexAttribPointer(NormAttrib, 3, GL.FLOAT, false, 32, 12);
		Context.vertexAttribPointer(UVAttrib, 2, GL.FLOAT, false, 32, 24);
		Context.drawArrays(GL.TRIANGLES, 0, NumVerts);

		Context.disableVertexAttribArray(VertAttrib);
		Context.disableVertexAttribArray(NormAttrib);
		Context.disableVertexAttribArray(UVAttrib);
	}
}