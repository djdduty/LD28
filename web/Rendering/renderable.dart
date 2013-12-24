part of Renderer;

abstract class RenderableType
{
	static const DEFAULT = 0;
	static const TWODIM = 1;
	static const ENTITY = 2;
	static const NUM_RENDERABLE_TYPES = 3;
}

class Renderable
{
	GL.Buffer Data;
	String TexName;
	Matrix Transform;
	int Type = 0;
	int NumVerts = 0;
	int NumNormals = 0;
	int NumUvs = 0;
	int NumItems = 3;

	String Name = '';

	Renderable()
	{
		Data = new Engine().GetContext().createBuffer();
	}

	void Init()
	{}

	void PreRender()
	{}

	void Render(int VertAttrib, int NormAttrib, int UVAttrib)
	{
		Engine e = new Engine();
		GL.RenderingContext Context = e.GetContext();

		Context.enableVertexAttribArray(VertAttrib);

		Context.bindBuffer(GL.ARRAY_BUFFER, Data);
		Context.vertexAttribPointer(VertAttrib, 3, GL.FLOAT, false, 0, 0);
		Context.drawArrays(GL.TRIANGLES, 0, NumVerts);

		Context.disableVertexAttribArray(VertAttrib);
	}

	void PostRender()
	{}

	bool IsVisible()
	{return true;}

	void SetTransform(Matrix mat)
	{Transform = mat;}

	Matrix GetTransform()
	{return Transform;}

	int GetType()
	{return Type;}
}