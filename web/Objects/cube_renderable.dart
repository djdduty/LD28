library CubeRenderable;

import '../Rendering/rendering.dart';
import '../Core/core.dart';
import '../Math/glmatrix.dart';
import '../Utils/utils.dart';
import 'dart:typed_data';
import 'dart:web_gl' as GL;

class CubeRenderable extends Renderable
{
	Engine gEngine = new Engine();
	GL.UniformLocation SamplerLocation;

	double Size;

	CubeRenderable(this.Size)
	{

	}

	void Init()
	{
		TexName = 'b3.png';

		Transform = new Matrix.identity();
		Transform.translate(new Vector3(0.0,0.0,-5.0));

		GL.RenderingContext Context = gEngine.GetContext();
		Context.bindBuffer(GL.ARRAY_BUFFER, Data);

		List<double> InfoList = new List();

		int items = CreateCube(Size, InfoList);

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
		Context.drawArrays(GL.LINE_LOOP, 0, NumVerts);

		Context.disableVertexAttribArray(VertAttrib);
		Context.disableVertexAttribArray(NormAttrib);
		Context.disableVertexAttribArray(UVAttrib);
	}
}