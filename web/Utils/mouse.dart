part of Input;

class Mouse
{
	bool MouseLocked = false;
	bool Enabled = false;

	Vector2 MousePos = new Vector2(0.0,0.0);

	Mouse()
	{
		Init();
	}

	void Init()
	{
		BindEvents();
	}

	void BindEvents()
	{
		document.onPointerLockChange.listen(PointerLockChange);
		new Engine().GetGame().Canvas.onClick.listen(Clicked);
	}


	void MouseMove()
	{}

	void BindMouseClick(void Callback(Event))
	{
		new Engine().GetGame().Canvas.onClick.listen(Callback);
	}

	void BindMouseMove(void Callback(MouseEvent))
	{
		document.onMouseMove.listen(Callback);
	}

	bool get _MouseLocked => new Engine().GetGame().Canvas == document.pointerLockElement;

	void PointerLockChange(Event event)
	{
		MouseLocked = _MouseLocked;
		if(!Enabled)
			MouseLocked = false;
	}

	void Clicked(Event event)
	{
		if(Enabled)
			new Engine().GetGame().Canvas.requestPointerLock();
	}

	void Enable()
	{
		Enabled = true;
	}

	void Disable()
	{
		Enabled = false;
	}
}