part of Level;

class Collidable
{
	double Size = 1.0;
	Vector3 Pos = new Vector3(0.0,0.0,0.0);
	Vector2 Top;
	Vector2 Bot;

	Collidable(this.Pos, this.Size)
	{
		Top = new Vector2(Pos.X-0.2, Pos.Z);
		Bot = new Vector2(Pos.X+Size+0.2, Pos.Z+Size);
	}

	void SetPos()
	{
		Top = new Vector2(Pos.X, Pos.Z);
		Bot = new Vector2(Pos.X, Pos.Z+Size);
	}

	bool Collision(Collidable Other)
	{
		num s1x = Pos.X;
		num s1y = Pos.Y;
		num s1z	= Pos.Z;
		num s1Radius = Size/2;

		num s2x = Other.Pos.X;
		num s2y = Other.Pos.Y;
		num s2z = Other.Pos.Z;
		num s2Radius = Other.Size/2;

		double d = sqrt(((s1x - s2x) * (s1x - s2x)) + ((s1y - s2y) * (s1y - s2y)) + ((s1z - s2z) * (s1z - s2z)));

		if(d < (s1Radius + s2Radius))
		{
			return true;
		}

		return false;
	}

	bool SquareCollision(Collidable Other)
	{
		return !(Bot.X <= Other.Top.X ||
				 Top.X >= Other.Bot.X ||
				 Bot.Y <= Other.Top.Y ||
				 Top.Y >= Other.Bot.Y);
	}
}