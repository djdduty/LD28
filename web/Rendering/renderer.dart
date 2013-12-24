part of Renderer;

class Renderer
{
	Camera mCamera;
	GL.RenderingContext Context;
	GL.Program DefaultProgram;
	GL.Program TwoDProgram;
	Engine e = new Engine();

	GL.UniformLocation ProjectionMatrixUniform;
	GL.UniformLocation ModelViewMatrixUniform;
	GL.UniformLocation NormalMatrixUniform;
	int VertPosAttrib;
	int NormAttrib;
	int UVAttrib;

	Matrix ModelViewMatrix;
	Matrix ProjectionMatrix;
	Matrix3 NormalMatrix;

	//2D
	GL.UniformLocation ProjectionMatrixUniform2D;
	GL.UniformLocation ModelViewMatrixUniform2D;
	GL.UniformLocation NormalMatrixUniform2D;
	int VertPosAttrib2D;
	int NormAttrib2D;
	int UVAttrib2D;

	Matrix ModelViewMatrix2D;
	Matrix ProjectionMatrix2D;
	Matrix3 NormalMatrix2D;

	List<Renderable> Renderables = new List();
	List<Light> Lights = new List();
	List<Renderable> AfterList = new List();

	Renderer()
	{
	}

	void Init()
	{
		mCamera = new Camera();
		Context = new Engine().GetContext();
		InitShaders();
		mCamera.Init();
	}

	bool InitShaders()
	{
		InitDefaultShader();
		InitTwoDShader();
	}

	bool InitDefaultShader()
	{
		//Vertex
		GL.Shader VertexShader = Context.createShader(GL.VERTEX_SHADER);
		Context.shaderSource(VertexShader, DefaultVertShader);
		Context.compileShader(VertexShader);

		//Fragment
		GL.Shader FragShader = Context.createShader(GL.FRAGMENT_SHADER);
		Context.shaderSource(FragShader, DefaultFragShader);
		Context.compileShader(FragShader);

		GL.Program program = Context.createProgram();
		Context.attachShader(program, VertexShader);
		Context.attachShader(program, FragShader);
		Context.linkProgram(program);
		Context.useProgram(program);

		if(!Context.getShaderParameter(VertexShader, GL.COMPILE_STATUS))
		{
			print(Context.getShaderInfoLog(VertexShader));
		}

		if(!Context.getShaderParameter(FragShader, GL.COMPILE_STATUS))
		{
			print(Context.getShaderInfoLog(FragShader));
		}

		if(!Context.getProgramParameter(program, GL.LINK_STATUS))
		{
			print(Context.getProgramInfoLog(program));
		}

		DefaultProgram = program;

		VertPosAttrib = Context.getAttribLocation(program, "Vertex");
		NormAttrib = Context.getAttribLocation(program, "Normal");
		UVAttrib = Context.getAttribLocation(program, "UV");

		ProjectionMatrixUniform = Context.getUniformLocation(program, "ProjectionMatrix");
		ModelViewMatrixUniform = Context.getUniformLocation(program, "ModelViewMatrix");
		NormalMatrixUniform = Context.getUniformLocation(program, "NormalMatrix");

		return true;
	}

	bool InitTwoDShader()
	{
		//Vertex
		GL.Shader VertexShader = Context.createShader(GL.VERTEX_SHADER);
		Context.shaderSource(VertexShader, DefaultVertShader);
		Context.compileShader(VertexShader);

		//Fragment
		GL.Shader FragShader = Context.createShader(GL.FRAGMENT_SHADER);
		Context.shaderSource(FragShader, TextFragShader);
		Context.compileShader(FragShader);

		GL.Program program = Context.createProgram();
		Context.attachShader(program, VertexShader);
		Context.attachShader(program, FragShader);
		Context.linkProgram(program);
		Context.useProgram(program);

		if(!Context.getShaderParameter(VertexShader, GL.COMPILE_STATUS))
		{
			print(Context.getShaderInfoLog(VertexShader));
		}

		if(!Context.getShaderParameter(FragShader, GL.COMPILE_STATUS))
		{
			print(Context.getShaderInfoLog(FragShader));
		}

		if(!Context.getProgramParameter(program, GL.LINK_STATUS))
		{
			print(Context.getProgramInfoLog(program));
		}

		TwoDProgram = program;

		VertPosAttrib2D = Context.getAttribLocation(program, "Vertex");
		NormAttrib2D = Context.getAttribLocation(program, "Normal");
		UVAttrib2D = Context.getAttribLocation(program, "UV");

		ProjectionMatrixUniform2D = Context.getUniformLocation(program, "ProjectionMatrix");
		ModelViewMatrixUniform2D = Context.getUniformLocation(program, "ModelViewMatrix");
		NormalMatrixUniform2D = Context.getUniformLocation(program, "NormalMatrix");

		return true;
	}

	void Update()
	{

	}

	void Render()
	{
		Context.enable(GL.DEPTH_TEST);
		Context.enable(GL.CULL_FACE);
		Context.enable(GL.BLEND);
		Context.blendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA);
		Context.cullFace(GL.BACK);
		Context.viewport(0, 0, e.GetWidth(), e.GetHeight());
		Context.clear(GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT);
		for(int i = 0; i < Renderables.length; i++)
		{
			Renderable Ptr = Renderables[i];
			if(Ptr.Type == RenderableType.DEFAULT || Ptr.Type == RenderableType.ENTITY)
				DefaultRender(Ptr);

			if(Ptr.Type == RenderableType.TWODIM)
				AfterList.add(Ptr);
		}

		for(int i = 0; i < AfterList.length; i++)
		{
			TwoDRender(AfterList[i]);
		}

		AfterList.clear();

		Context.disable(GL.DEPTH_TEST);
	}

	void DefaultRender(Renderable Ptr)
	{
		Context.useProgram(DefaultProgram);
		ModelViewMatrix = new Matrix.identity();
		Matrix.Multiply(mCamera.GetTransform(), Ptr.GetTransform(), ModelViewMatrix);
		if(Ptr.Type == RenderableType.ENTITY)
		{
			ModelViewMatrix.m11 = 1.0;
			ModelViewMatrix.m12 = 0.0;
			ModelViewMatrix.m13 = 0.0;

			ModelViewMatrix.m21 = 0.0;
			ModelViewMatrix.m22 = 1.0;
			ModelViewMatrix.m23 = 0.0;

			ModelViewMatrix.m31 = 0.0;
			ModelViewMatrix.m32 = 0.0;
			ModelViewMatrix.m33 = 1.0;
		}
		Context.uniformMatrix4fv(ModelViewMatrixUniform, false, ModelViewMatrix.dest);

		ProjectionMatrix = mCamera.GetProjection();
		Context.uniformMatrix4fv(ProjectionMatrixUniform, false, ProjectionMatrix.dest);

		NormalMatrix = new Matrix3.zero();
		NormalMatrix = Matrix.ToMat3(ModelViewMatrix, NormalMatrix);
		Context.uniformMatrix3fv(NormalMatrixUniform, false, NormalMatrix.dest);


		Ptr.Render(VertPosAttrib, NormAttrib, UVAttrib);
	}

	void TwoDRender(Renderable Ptr)
	{
		Context.clear(GL.DEPTH_BUFFER_BIT);
		Context.useProgram(TwoDProgram);

		ModelViewMatrix2D = Ptr.GetTransform();//new Matrix.identity();
		//Matrix.Multiply(mCamera.GetTransform(), Ptr.GetTransform(), ModelViewMatrix2D);
		ProjectionMatrix2D = mCamera.GetProjection();

		Context.uniformMatrix4fv(ProjectionMatrixUniform2D, false, ProjectionMatrix2D.dest);
		Context.uniformMatrix4fv(ModelViewMatrixUniform2D, false, ModelViewMatrix2D.dest);

		NormalMatrix2D = new Matrix3.zero();
		NormalMatrix2D = Matrix.ToMat3(ModelViewMatrix2D, NormalMatrix2D);
		Context.uniformMatrix3fv(NormalMatrixUniform2D, false, NormalMatrix2D.dest);

		Ptr.Render(VertPosAttrib2D, NormAttrib2D, UVAttrib2D);
	}

	void AddRenderable(Renderable r)
	{
		Renderables.add(r);
	}

	void ClearRenderables()
	{
		Renderables.clear();
		print('Renderables Cleared');
	}

	void AddLights(Light r)
	{
		Lights.add(r);
	}

	void ClearLights()
	{
		Lights.clear();
	}

	Camera GetCamera()
	{
		return mCamera;
	}

	GL.UniformLocation GetUniformLocationDefault(String Name)
	{
		return Context.getUniformLocation(DefaultProgram, Name);
	}

	GL.UniformLocation GetUniformLocationText(String Name)
	{
		return Context.getUniformLocation(TwoDProgram, Name);
	}

	void RemoveRenderable(String name)
	{
		for(int i = 0; i < Renderables.length; i++)
		{
			if(Renderables[i].Name == name)
			{
				Renderables.removeAt(i);
			}
		}
	}
}