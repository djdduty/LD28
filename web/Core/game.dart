part of Core;

class Game
{
	int DisplayWidth, DisplayHeight;
	bool ShowFPS, CloseRequested;
	StateManager Manager;
	GL.RenderingContext Context;
	CanvasElement Canvas;
	Engine mEngine;
	num DeltaTime, FpsTimer, OldTime;
	int Frames;
	Stopwatch TimerMilli;

	Game(Engine e)
	{
		ShowFPS = false;
		CloseRequested = false;
		mEngine = e;

		Canvas = querySelector("#canvas");
	}

	bool InitGL()
	{
		Context = Canvas.getContext("experimental-webgl");
		Context.clearColor(0.0, 0.0, 0.0, 1.0);
		//Context.clear(GL.COLOR_BUFFER_BIT);
		//Context.colorMask(true, true, true, false);

		if(Context == null)
		{
			return false;
		}
		return true;
	}

	void Init(State s)
	{
		Manager = new StateManager(s);
		InitGL();
	}

	void Setup()
	{
		DeltaTime = 0.0;
		FpsTimer = 0.0;
		Frames = 0;

		Manager.Init();
		TimerMilli = new Stopwatch()..start();
		OldTime = TimerMilli.elapsedMilliseconds;
	}

	void Run()
	{
		var timer = new Timer.periodic(Duration.ZERO, DoFrame);
	}

	DoFrame(Timer timer) {
  		DeltaTime = TimerMilli.elapsedMilliseconds - OldTime;
  		OldTime = TimerMilli.elapsedMilliseconds;

  		Context.viewport(0, 0, Canvas.width, Canvas.height);
  		Context.clear(GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT);

  		Manager.Update(DeltaTime);
  		mEngine.Update(DeltaTime);

  		Frames++;
  		FpsTimer += DeltaTime;
  		if(FpsTimer >= 1000)
  		{
			//print(Frames);
			FpsTimer = 0;
			Frames = 0;
    	}
	}

	void Close()
	{
		CloseRequested = true;
	}

	GL.RenderingContext GetContext()
	{
		return Context;
	}

	void Die()
	{
		CloseRequested = true;
	}

	int GetWidth()
	{
		return DisplayWidth;
	}

	int GetHeight()
	{
		return DisplayHeight;
	}
}
