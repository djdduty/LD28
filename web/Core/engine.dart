part of Core;

class Engine
{
	Game mGame;
	StateManager mStateManager;
	Renderer mRenderer;
	TextureManager mTexManager;

	int test=0;
	int GetTest() { return test; }
	int SetTest(int x) {test = x; }

	bool HasFriend1 = false;
	bool HasFriend2 = false;
	bool HasFriend3 = false;
	bool HasFriend4 = false;

	static final Engine _singleton = new Engine._internal();

	factory Engine()
	{
		return _singleton;
	}

	Engine._internal();

	void InitTextureManager()
	{
		var BaseUrl = getBaseUrl();
		BaseUrl = '${BaseUrl}/Images/';
		mTexManager = new TextureManager(BaseUrl);
	}

	void InitGame(State s)
	{
		mGame = new Game(this);
		mRenderer = new Renderer();

		mGame.Init(s);
		InitTextureManager();
		mRenderer.Init();
		mGame.Setup();
	}

	void Run()
	{
		mGame.Run();
	}

	Game GetGame()
	{
		return mGame;
	}

	StateManager GetStateManager()
	{
		return mStateManager;
	}

	int GetWidth()
	{
		return 800;
	}

	int GetHeight()
	{
		return 600;
	}

	void LoadTexture(String Name)
	{
		mTexManager.Load(Name);
	}

	void LoadCubeMap(String Name, List<String> Sides)
	{
		mTexManager.LoadCube(Name, Sides);
	}

	void BindTexture(String Name, int loc)
	{
		mTexManager.Bind(Name, loc);
	}

	void Update(num DeltaTime)
	{
		mRenderer.Update();
		mRenderer.Render();
	}

	Renderer GetRenderer()
	{
		return mRenderer;
	}

	GL.RenderingContext GetContext()
	{
		return mGame.GetContext();
	}

	Sound LoadSound(String Name, bool Loop)
	{
		//var BaseUrl = getBaseUrl();
		//BaseUrl = '${BaseUrl}/sound/';
		//Sound ret = new Sound('$BaseUrl$Name', Loop);
		//return ret;
	}

	Camera GetCamera()
	{
		return mRenderer.GetCamera();
	}

	void HasFriendOne(bool has)
	{
		HasFriend1 = has;
	}

	void HasFriendTwo(bool has)
	{
		HasFriend2 = has;
	}

	void HasFriendThree(bool has)
	{
		HasFriend3 = has;
	}

	void HasFriendFour(bool has)
	{
		HasFriend4 = has;
	}
}