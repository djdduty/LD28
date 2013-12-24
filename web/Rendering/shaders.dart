part of Renderer;

var DefaultFragShader = """
precision mediump float;

varying vec4 WorldPos;
varying vec2 TexCoord;
varying vec3 Norm;

uniform sampler2D Texture;

void main(void) {
	vec3 Normal = normalize(Norm);

	vec3 LightDir = WorldPos.xyz - vec3(0.0,0.0,0.0);
	float NdotL = max(dot(Normal, normalize(-LightDir)),0.0);
	float Atten, Distance;
	vec4 Color, DiffuseColor, AmbientColor;
	Distance = length(-LightDir);

	if(NdotL > 0.0)
	{
		Atten = 1.0 + 0.2 * Distance + 0.1 * Distance * Distance;
		DiffuseColor = vec4(vec3(1.0,1.0,1.0), 1.0) * 2.0 * NdotL;
		AmbientColor = vec4(vec3(1.0,1.0,1.0), 1.0) * 0.05;
		Color = DiffuseColor;
	}
	Color.w = 1.0;
	AmbientColor.w=1.0;
	vec4 Albedo = texture2D(Texture, TexCoord);
	gl_FragColor = Albedo * (Color/Atten) + (AmbientColor * Albedo);
}
""";

var TextFragShader = """
precision mediump float;

varying vec4 WorldPos;
varying vec2 TexCoord;
varying vec3 Norm;

uniform sampler2D Texture;

void main(void) {
	vec3 Normal = normalize(Norm);

	vec3 LightDir = WorldPos.xyz - vec3(0.0,0.0,0.0);
	float NdotL = max(dot(Normal, normalize(-LightDir)),0.0);
	float Atten, Distance;
	vec4 Color, DiffuseColor, AmbientColor;
	Distance = length(-LightDir);

	if(NdotL > 0.0)
	{
		Atten = 1.0 + 0.2 * Distance + 0.1 * Distance * Distance;
		DiffuseColor = vec4(vec3(1.0,1.0,1.0), 1.0) * 2.0 * NdotL;
		AmbientColor = vec4(vec3(1.0,1.0,1.0), 1.0) * 0.05;
		Color = DiffuseColor;
	}
	Color.w = 1.0;
	AmbientColor.w=1.0;
	vec4 Albedo = texture2D(Texture, TexCoord);
	gl_FragColor = Albedo * (Color/Atten) + (AmbientColor * Albedo);
}
""";

var DefaultVertShader = """
	attribute vec3 Vertex;
	attribute vec3 Normal;
	attribute vec2 UV;

	uniform mat3 NormalMatrix;
	uniform mat4 ModelViewMatrix;
	uniform mat4 ProjectionMatrix;

	varying vec2 TexCoord;
	varying vec3 Norm;
	varying vec4 WorldPos;

	void main(void) {
		gl_Position = ProjectionMatrix * ModelViewMatrix * vec4(Vertex, 1.0);
		Norm = NormalMatrix * Normal;
		TexCoord = UV;
		WorldPos = ModelViewMatrix * vec4(Vertex,1);
	}
""";