part of Levels;

class Level2 extends LevelWrapper
{
	//FriendTwo Friend;
	bool Victory = false;

	Level2(Character char)
	{
		this.char = char;
	}

	ThreeDString GratFont;
	ThreeDString GratFontCont;
	bool Celebrated = false;

	Keyboard keyboard = new Keyboard();

	EntityRenderable Friend2;
	Collidable MenuC;

	StateManager Manager;

	void Init(LevelState S)
	{
		Manager = S.Manager;
		//Friend = new FriendTwo('friend-2', new Vector3(0.0,0.0,-5.0));
		new Engine().GetCamera().Rotation = new Vector3(0.0,0.0,0.0);
		level = new Level(3,20,1, char);

		level.OffsetX = -10.0;
		level.OffsetZ = -10.0;
		level.gridOffX = 0.5;
		level.gridOffZ = 1.2;

		level.Model.TexName = 'Office.png';
		level.SetData(Level2a);
		//level.AddEntity(new Mob1('mob-1', new Vector3(-1.0,0.0,-4.0)));
		//level.AddEntity(new Mob1('mob-2', new Vector3(1.0,0.0,-4.0)));
		//level.AddEntity(Friend);

		Friend2 = new EntityRenderable(0.8, 3, 'Friend2-icon');
		Friend2.Init();
		Friend2.Type = RenderableType.TWODIM;
		Friend2.GetTransform().translate(new Vector3(2.3,1.3,0.0));

		GratFont = new ThreeDString(new Vector2(1.57,0.2), 0.005, "Round complete and you saved someone");
		GratFontCont = new ThreeDString(new Vector2(0.99,0.16), 0.005, "Press space to continue");
		GratFontCont.Init();
		GratFont.Init();
		for(int i = 0; i < GratFont.Models.length; i++)
		{
			GratFont.Models[i].Type = RenderableType.TWODIM;
		}

		for(int i = 0; i < GratFontCont.Models.length; i++)
		{
			GratFontCont.Models[i].Type = RenderableType.TWODIM;
		}
		MenuC = new Collidable(new Vector3(0.0,0.0,0.0), 1.0);
	}

	void Update(num DeltaTime)
	{
		//Friend.Update(DeltaTime);
		//Friend.Shape.SetPos();

		level.Update(DeltaTime);

		/*if(Friend.Shape.Collision(char.Shape))
		{
				new Engine().HasFriendOne(true);
				Victory = true;
				Friend.Die();
				new Engine().GetRenderer().AddRenderable(Friend1);
		}*/

		if(Victory)
		{
			if(keyboard.isPressed(KeyCode.SPACE))
			{
				HideGratFont();
			}
		}

		if(MenuC.Collision(char.Shape))
		{
			if(keyboard.isPressed(KeyCode.E))
			{
				new Engine().GetRenderer().ClearRenderables();
				level.AddToRenderList();
				Manager.ChangeState(new MenuState(false), false);
			}
		}

		if(Victory && !Celebrated)
		{
			Celebrate();
			GratFont.Update();
			GratFontCont.Update();
		}
	}

	void Celebrate()
	{
		GratFont.AddToRenderList();
		GratFontCont.AddToRenderList();
		Celebrated = true;
	}

	void HideGratFont()
	{
		GratFont.Die();
		GratFontCont.Die();
	}
	void AddToRenderList()
	{
		level.AddCollidablesToRender();
		level.AddToRenderList();
	}
}