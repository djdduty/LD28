library Audio;

import 'dart:html';

class Sound
{
	AudioElement Element;
	Sound(String Path, bool Loop)
	{
		Element = new AudioElement(Path);
		Element.loop = Loop;
		Element.volume = 1.0;
	}

	void Play()
	{
		Element.play();
	}
}