part of Levels;

abstract class LevelWrapper
{
	List<int> DataArray;
	Character char;
	Level level;

	void Init(LevelState S);

	void AddToRenderList();

	void Update(num DeltaTime);
}