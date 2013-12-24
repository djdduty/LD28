library States;

import '../Core/core.dart';
import '../Objects/font3d.dart';
import '../Objects/machine_gun.dart';
import '../Math/glmatrix.dart';
import '../Utils/keyboard.dart';
import '../Audio/audio.dart';
import '../Objects/level.dart';
import '../Levels/levels.dart';
import '../Entities/entities.dart';
import '../Objects/entity_renderable.dart';
import '../Rendering/rendering.dart';

import 'dart:html';

part 'level_state.dart';
part 'level_one_state.dart';
part 'level_two_state.dart';

class MenuState extends State
{
	Sound Music;

	MachineGun Gun;
	ThreeDString font;

	double CurRot = 0.0;
	double Rotmax = 0.2;
	double RotVel = 0.001;
	double ConstRot = 0.0;

	ThreeDString Play;
	ThreeDString Test;
	ThreeDString Selected;
	ThreeDString Continue;
	ThreeDString Info;
	ThreeDString Info2;

	double SizeDelta=0.0;
	double SizeVel=0.0002;
	double MaxSize=0.01;

	Keyboard keyboard = new Keyboard();

	StateManager Manager;

	bool Loaded = false;
	bool LoadLevel = false;

	MenuState(bool ll)
	{
		if(ll)
		{
			LoadLevel = true;
		}
	}

	void Init(StateManager m)
	{
		Manager = m;

		Gun  = new MachineGun(0.04);
		Gun.Init();

		Gun.AddToRenderList();

		Matrix Transform = Gun.GetTransform();
		Transform.translate(new Vector3(-0.1,-0.25,-1.05));
		Transform.rotateZ(1.0);

		font = new ThreeDString(new Vector2(-0.2,0.25),0.025,"LD48!");
		font.Init();
		font.AddToRenderList();

		Play = new ThreeDString(new Vector2(-0.25, 0.0), 0.015, "Play");
		Play.Init();
		Play.AddToRenderList();

		Test = new ThreeDString(new Vector2(-0.28, -0.1), 0.015, "Test");
		Test.Init();
		Test.AddToRenderList();

		Continue = new ThreeDString(new Vector2(1.6, -0.25), 0.005, "Use Arrows or press ENTER to continue");
		Continue.Init();
		Continue.AddToRenderList();

		Info2 = new ThreeDString(new Vector2(1.56, -0.33), 0.005, "Press E Next to Menu to access again");
		Info2.Init();
		Info2.AddToRenderList();

		Info = new ThreeDString(new Vector2(2.2, -0.38), 0.003, "Made with only WebGL and Dart Standard Library");
		Info.Init();
		Info.AddToRenderList();

		Selected = Play;
	}

	void DeInit()
	{
	}

	void LoadLevelState()
	{
		Manager.ChangeState(new LevelState(Gun), false);
	}

	void Update(num DeltaTime)
	{
		if(LoadLevel)
			LoadLevelState();

		ConstRot += 0.01;

		CurRot += RotVel;
		if(CurRot >= Rotmax || CurRot <= -Rotmax)
		{
			RotVel *= -1;
		}
		font.SetRotation(new Vector3(-0.2, CurRot,0.0));
		font.Update();

		Play.Update();
		Test.Update();

		Selected.SetRotation(new Vector3(-ConstRot, 0.0, 0.0));
		Selected.Update();

		if(keyboard.isPressed(KeyCode.DOWN) && identical(Selected, Play))
		{
			Selected = Test;
		}

		if(keyboard.isPressed(KeyCode.UP) && identical(Selected, Test))
		{
			Selected = Play;
		}

		if(keyboard.isPressed(KeyCode.ENTER))
		{
			if(identical(Selected, Play))
			{
				if(!Loaded)
				{
					new Engine().GetRenderer().RemoveRenderable('Level');
					Manager.ChangeState(new LevelState(Gun), false);
				}
			}
		}

		SizeDelta += SizeVel;
		if(SizeDelta >= MaxSize || SizeDelta <= -MaxSize)
		{
			SizeVel *= -1;
		}
		Continue.SetSize(0.005+SizeDelta);
		Continue.SetRotation(new Vector3(0.2,0.0,0.0));
		Continue.Update();

		Info.Update();
		Info2.Update();
	}

	void OnActivate()
	{
		new Engine().GetCamera().Position = new Vector3(0.0,0.0,0.0);
		new Engine().GetCamera().Rotation = new Vector3(0.0,0.0,0.0);
		Loaded = true;
		//Gun.AddToRenderList();
		//Play.AddToRenderList();
		//Test.AddToRenderList();
		//Continue.AddToRenderList();
		//Selected.AddToRenderList();
		//font.AddToRenderList();
	}

	void OnDeactivate()
	{

	}
}