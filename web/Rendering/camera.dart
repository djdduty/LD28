part of Renderer;

class Camera
{
	Matrix Projection;

	double fov = 45.0;

	Vector3 Position = new Vector3(0.0,0.0,0.0);
	Vector3 Rotation = new Vector3(0.0,0.0,0.0);

	Camera()
	{
		Rotation = new Vector3(0.0,0.0,0.0);
	}

	void Init()
	{
		//Perspective Projection
		UpdateProjection();
	}

	void Update()
	{}

	void SetFov(double fov)
	{
		this.fov = fov;
		UpdateProjection();
	}

	void UpdateProjection()
	{
		Projection = new Matrix.identity();
		Engine e = new Engine();
		int width = new Engine().GetWidth();
		int height = new Engine().GetHeight();
		double aspect = width/height;
		Matrix.Perspective(fov, aspect, 0.1, 1000.0, Projection);
	}

	Matrix GetTransform()
	{
		//return Transform;
		Matrix Tmp = new Matrix.identity();
		Tmp.rotateX(Rotation.X);
		Tmp.rotateY(Rotation.Y);
		Tmp.translate(Position);
		return Tmp;
	}

	Matrix GetProjection()
	{
		return Projection;
	}

	void MoveCamera(Vector3 vec)
	{
		Matrix Tmp = new Matrix.identity();
		Tmp.rotateY(Rotation.Y);
		Tmp.rotateX(Rotation.X);
		Vector3 move = new Vector3(0.0, 0.0, 0.0);
		Vector3.MultiplyMatrix(vec, Tmp, move);

		Position.X += -move.X;
		Position.Y += -move.Y;
		Position.Z += move.Z;
	}

	Vector3 MultByCamera(Vector3 vec)
	{
		Matrix Tmp = new Matrix.identity();
		Tmp.rotateY(Rotation.Y);
		Tmp.rotateX(Rotation.X);
		Vector3 move = new Vector3(0.0, 0.0, 0.0);
		Vector3.MultiplyMatrix(vec, Tmp, move);

		return new Vector3(-move.X, -move.Y, move.Z);
	}

	void RotateCamera(Vector2 Vec)
	{
		Rotation.Y += Vec.Y;
		//Rotation.Z += Vec.Z;

		Rotation.X += Vec.X;

		if(Rotation.X > 1.5707)
			Rotation.X = 1.56;

		if(Rotation.X < -1.5707)
		Rotation.X = -1.56;
	}
}