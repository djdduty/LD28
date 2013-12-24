part of Levels;

class Level1 extends LevelWrapper
{
	FriendOne Friend;
	bool Victory = false;

	StateManager Manager;

	Level1(Character char, this.Manager)
	{
		this.char = char;
	}

	ThreeDString GratFont;
	ThreeDString GratFontCont;
	bool Celebrated = false;

	Keyboard keyboard = new Keyboard();

	EntityRenderable Friend1;

	LevelState Owner;
	Collidable MenuC;

	void Init(LevelState S)
	{
		Owner = S;

		char.Position = new Vector3(0.0,0.0,0.0);
		level = new Level(3,10,1, char);
		level.SetData(Level1a);
		level.Model.TexName = 'Office.png';

		Friend = new FriendOne('friend-2', new Vector3(0.0,0.0,-5.0));
		level.AddEntity(Friend);

		level.AddEntity(new Mob1('mob-1', new Vector3(-1.0,0.0,-4.0)));
		level.AddEntity(new Mob1('mob-2', new Vector3(1.0,0.0,-4.0)));

		Friend1 = new EntityRenderable(0.8, 3, 'Friend1-icon');
		Friend1.Init();
		Friend1.Type = RenderableType.TWODIM;
		Friend1.GetTransform().translate(new Vector3(2.3,1.6,0.0));

		GratFont = new ThreeDString(new Vector2(1.50,0.2), 0.005, "Round complete! you saved someone!");
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
		Friend.Update(DeltaTime);
		Friend.Shape.SetPos();

		level.Update(DeltaTime);

		if(Friend.Shape.Collision(char.Shape))
		{
				new Engine().HasFriendOne(true);
				Victory = true;
				Friend.Die();
				new Engine().GetRenderer().AddRenderable(Friend1);
		}

		if(Victory)
		{
			if(keyboard.isPressed(KeyCode.SPACE))
			{
				new Engine().HasFriendOne(true);
				HideGratFont();
				HideGratFont();
				HideGratFont();
				level.Model.Die();
				level.Collidables.clear();
				level.Entities.clear();
				Manager.ChangeState(new MenuState(true), true);
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
		GratFont.Die();
		GratFont.Die();
		GratFontCont.Die();
		GratFontCont.Die();
		GratFontCont.Die();
	}
	void AddToRenderList()
	{
		//level.AddCollidablesToRender();
		level.AddToRenderList();
	}
}