part of Renderer;

class Texture
{
	final int Binding;
	GL.Texture Tex;
	Texture(this.Binding);
}

class TextureManager
{
	final GL.RenderingContext Context = new Engine().GetContext();
	String BasePath;

	Map<String, Texture> Textures;

	TextureManager(this.BasePath)
	{
		Textures = new Map<String, Texture>();
	}

	Texture Make(String Name)
	{
		Texture t = new Texture(GL.RenderingContext.TEXTURE_2D);
		t.Tex = Context.createTexture();
		Textures[Name] = t;
		Context.bindTexture(t.Binding, t.Tex);
		return t;
	}

	void Update(String Name, ImageData Data)
	{
		Texture t = Textures[Name];
		if(t == null)
		{
			return;
		}

		Context.bindTexture(GL.RenderingContext.TEXTURE_2D, t.Tex);
		Context.texImage2D(GL.RenderingContext.TEXTURE_2D,
			0,
			GL.RenderingContext.RGBA,
			GL.RenderingContext.RGBA,
			GL.RenderingContext.UNSIGNED_BYTE,
			Data);
		Context.generateMipmap(GL.RenderingContext.TEXTURE_2D);
	}

	Future Load(String Name)
	{
		Texture t = Textures[Name];
		if(t == null)
		{
			t = new Texture(GL.RenderingContext.TEXTURE_2D);
			t.Tex = Context.createTexture();
			Textures[Name] = t;
		}

		ImageElement img = new ImageElement();
		Completer c = new Completer();
		img.onLoad.listen((_) {
    		Context.bindTexture(t.Binding, t.Tex);
			Context.texParameteri(t.Binding, GL.RenderingContext.TEXTURE_MIN_FILTER, GL.RenderingContext.NEAREST);
			Context.texParameteri(t.Binding, GL.RenderingContext.TEXTURE_MAG_FILTER, GL.RenderingContext.NEAREST);
    		Context.texImage2D(t.Binding,
    		0,
    		GL.RenderingContext.RGBA,
    		GL.RenderingContext.RGBA,
    		GL.RenderingContext.UNSIGNED_BYTE,
    		img);
    		Context.generateMipmap(t.Binding);
    		c.complete(img.src);
    		});
    	img.src = '$BasePath$Name';
    	return c.future;
  	}

	Future LoadCube(String Name, List<String> Sides)
	{
		assert(Sides.length == 6);
		Texture t = Textures[Name];
		if(t == null)
		{
			t = new Texture(GL.RenderingContext.TEXTURE_CUBE_MAP);
			t.Tex = Context.createTexture();
			Context.bindTexture(t.Binding, t.Tex);
			Context.texParameteri(t.Binding, GL.RenderingContext.TEXTURE_MIN_FILTER, GL.RenderingContext.NEAREST);
			Context.texParameteri(t.Binding, GL.RenderingContext.TEXTURE_MAG_FILTER, GL.RenderingContext.NEAREST);
			Textures[Name] = t;
		}

		List<int> SideTargets = [
			GL.RenderingContext.TEXTURE_CUBE_MAP_POSITIVE_X,
			GL.RenderingContext.TEXTURE_CUBE_MAP_NEGATIVE_X,
			GL.RenderingContext.TEXTURE_CUBE_MAP_POSITIVE_Y,
			GL.RenderingContext.TEXTURE_CUBE_MAP_NEGATIVE_Y,
			GL.RenderingContext.TEXTURE_CUBE_MAP_POSITIVE_Z,
			GL.RenderingContext.TEXTURE_CUBE_MAP_NEGATIVE_Z,
		];

		List<Future> Futures = new List<Future>();
		for(int i = 0; i < Sides.length; i++)
		{
			ImageElement img = new ImageElement();
			Completer c = new Completer();
			Futures.add(c.future);
			img.onLoad.listen((_) {
      			Context.bindTexture(GL.RenderingContext.TEXTURE_2D, null);
				Context.bindTexture(GL.RenderingContext.TEXTURE_CUBE_MAP, null);
				Context.bindTexture(t.Binding, t.Tex);
				Context.texImage2D(SideTargets[i],
      			0,
      			GL.RenderingContext.RGBA,
      			GL.RenderingContext.RGBA,
      			GL.RenderingContext.UNSIGNED_BYTE,
      			img);
      			c.complete(img.src);
      		});
    		img.src = '$BasePath${Sides[i]}';
    	}
    return Future.wait(Futures);
  	}

	void Bind(String Name, int Location)
	{
		Texture t = Textures[Name];

		if(t == null)
		{
			print('Cannot find texture $Name');
			return;
		}

		Context.activeTexture(GL.TEXTURE0+Location);
		Context.bindTexture(GL.RenderingContext.TEXTURE_2D, null);
		Context.bindTexture(GL.RenderingContext.TEXTURE_CUBE_MAP, null);
		Context.bindTexture(t.Binding, t.Tex);
	}
}