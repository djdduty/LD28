part of Utils;

String getBaseUrl() {
	var location = window.location.href;
	return "${location.substring(0, location.length - "solar.html".length)}";
}

int CreateCube(double size, List<double> InfoList)
{
	List<double> Verts = new List();
	List<double> Norms = new List();
	List<double> Uvs = new List();
	Vector3 v1,v2,v3,v4,v5,v6,v7,v8;

	double v = size/2;
	double n = -v;

	v1 = new Vector3(n,n,v);
	v2 = new Vector3(v,n,v);
	v3 = new Vector3(v,v,v);
	v4 = new Vector3(n,v,v);
	v5 = new Vector3(v,n,n);
	v6 = new Vector3(n,n,n);
	v7 = new Vector3(n,v,n);
	v8 = new Vector3(v,v,n);

	double TCWSize = (32.0 / 32.0);
	double TCHSize = (32.0 / 32.0);

	Vector2 TopLeft = new Vector2(0.0, 0.0);
	Vector2 TopRight = new Vector2(TCWSize, 0.0);
	Vector2 BottomLeft = new Vector2(0.0, TCHSize);
	Vector2 BottomRight = new Vector2(TCWSize, TCHSize);

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
	Verts.add(v2.X);Verts.add(v2.Y);Verts.add(v2.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(1.0);Norms.add(0.0);Norms.add(0.0);
	Verts.add(v5.X);Verts.add(v5.Y);Verts.add(v5.Z); /**/ Items++; /**/ Uvs.add(BottomLeft.X);Uvs.add(BottomLeft.Y); 	/**/ Norms.add(1.0);Norms.add(0.0);Norms.add(0.0);
	Verts.add(v8.X);Verts.add(v8.Y);Verts.add(v8.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(1.0);Norms.add(0.0);Norms.add(0.0);

	Verts.add(v2.X);Verts.add(v2.Y);Verts.add(v2.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(1.0);Norms.add(0.0);Norms.add(0.0);
	Verts.add(v8.X);Verts.add(v8.Y);Verts.add(v8.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(1.0);Norms.add(0.0);Norms.add(0.0);
	Verts.add(v3.X);Verts.add(v3.Y);Verts.add(v3.Z); /**/ Items++; /**/ Uvs.add(TopRight.X);Uvs.add(TopRight.Y); 		/**/ Norms.add(1.0);Norms.add(0.0);Norms.add(0.0);

	//Left
	Verts.add(v6.X);Verts.add(v6.Y);Verts.add(v6.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(-1.0);Norms.add(0.0);Norms.add(0.0);
	Verts.add(v1.X);Verts.add(v1.Y);Verts.add(v1.Z); /**/ Items++; /**/ Uvs.add(BottomLeft.X);Uvs.add(BottomLeft.Y); 	/**/ Norms.add(-1.0);Norms.add(0.0);Norms.add(0.0);
	Verts.add(v4.X);Verts.add(v4.Y);Verts.add(v4.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(-1.0);Norms.add(0.0);Norms.add(0.0);

	Verts.add(v6.X);Verts.add(v6.Y);Verts.add(v6.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(-1.0);Norms.add(0.0);Norms.add(0.0);
	Verts.add(v4.X);Verts.add(v4.Y);Verts.add(v4.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(-1.0);Norms.add(0.0);Norms.add(0.0);
	Verts.add(v7.X);Verts.add(v7.Y);Verts.add(v7.Z); /**/ Items++; /**/ Uvs.add(TopRight.X);Uvs.add(TopRight.Y); 		/**/ Norms.add(-1.0);Norms.add(0.0);Norms.add(0.0);

	//Top
	Verts.add(v4.X);Verts.add(v4.Y);Verts.add(v4.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(0.0);Norms.add(1.0);Norms.add(0.0);
	Verts.add(v3.X);Verts.add(v3.Y);Verts.add(v3.Z); /**/ Items++; /**/ Uvs.add(BottomLeft.X);Uvs.add(BottomLeft.Y); 	/**/ Norms.add(0.0);Norms.add(1.0);Norms.add(0.0);
	Verts.add(v8.X);Verts.add(v8.Y);Verts.add(v8.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(0.0);Norms.add(1.0);Norms.add(0.0);

	Verts.add(v4.X);Verts.add(v4.Y);Verts.add(v4.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(0.0);Norms.add(1.0);Norms.add(0.0);
	Verts.add(v8.X);Verts.add(v8.Y);Verts.add(v8.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(0.0);Norms.add(1.0);Norms.add(0.0);
	Verts.add(v7.X);Verts.add(v7.Y);Verts.add(v7.Z); /**/ Items++; /**/ Uvs.add(TopRight.X);Uvs.add(TopRight.Y); 		/**/ Norms.add(0.0);Norms.add(1.0);Norms.add(0.0);

	//Bottom
	Verts.add(v6.X);Verts.add(v6.Y);Verts.add(v6.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(0.0);Norms.add(-1.0);Norms.add(0.0);
	Verts.add(v5.X);Verts.add(v5.Y);Verts.add(v5.Z); /**/ Items++; /**/ Uvs.add(BottomLeft.X);Uvs.add(BottomLeft.Y); 	/**/ Norms.add(0.0);Norms.add(-1.0);Norms.add(0.0);
	Verts.add(v2.X);Verts.add(v2.Y);Verts.add(v2.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(0.0);Norms.add(-1.0);Norms.add(0.0);

	Verts.add(v6.X);Verts.add(v6.Y);Verts.add(v6.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(0.0);Norms.add(-1.0);Norms.add(0.0);
	Verts.add(v2.X);Verts.add(v2.Y);Verts.add(v2.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(0.0);Norms.add(-1.0);Norms.add(0.0);
	Verts.add(v1.X);Verts.add(v1.Y);Verts.add(v1.Z); /**/ Items++; /**/ Uvs.add(TopRight.X);Uvs.add(TopRight.Y); 		/**/ Norms.add(0.0);Norms.add(-1.0);Norms.add(0.0);

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

int CreatePlane(double size, List<double> InfoList, int TexIndex, int TexWidth, int ImgWidth)
{
	List<double> Verts = new List();
	List<double> Norms = new List();
	List<double> Uvs = new List();
	Vector3 v1,v2,v3,v4;

	double v = size/2;
	double n = -v;
	double z = 0.0;

	v1 = new Vector3(n,n,z);
	v2 = new Vector3(v,n,z);
	v3 = new Vector3(v,v,z);
	v4 = new Vector3(n,v,z);

	double TCWSize = (TexWidth / ImgWidth);
	double TCHSize = 1.0;
	double TexelOffset = 1/ImgWidth;

	Vector2 TopLeft = new Vector2(TexIndex*TCWSize+TexelOffset, 0.0);
	Vector2 TopRight = new Vector2(TexIndex*TCWSize+TCWSize-TexelOffset, 0.0);
	Vector2 BottomLeft = new Vector2(TexIndex*TCWSize+TexelOffset, TCHSize);
	Vector2 BottomRight = new Vector2(TexIndex*TCWSize+TCWSize-TexelOffset, TCHSize);

	int Items = 0;

	//front
	Verts.add(v1.X);Verts.add(v1.Y);Verts.add(v1.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(1.0);
	Verts.add(v2.X);Verts.add(v2.Y);Verts.add(v2.Z); /**/ Items++; /**/ Uvs.add(BottomLeft.X);Uvs.add(BottomLeft.Y); 	/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(1.0);
	Verts.add(v3.X);Verts.add(v3.Y);Verts.add(v3.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(1.0);

	Verts.add(v1.X);Verts.add(v1.Y);Verts.add(v1.Z); /**/ Items++; /**/ Uvs.add(BottomRight.X);Uvs.add(BottomRight.Y); 	/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(1.0);
	Verts.add(v3.X);Verts.add(v3.Y);Verts.add(v3.Z); /**/ Items++; /**/ Uvs.add(TopLeft.X);Uvs.add(TopLeft.Y); 			/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(1.0);
	Verts.add(v4.X);Verts.add(v4.Y);Verts.add(v4.Z); /**/ Items++; /**/ Uvs.add(TopRight.X);Uvs.add(TopRight.Y); 		/**/ Norms.add(0.0);Norms.add(0.0);Norms.add(1.0);

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

void DefaultMouseMoveCB(MouseEvent Event)
{

}