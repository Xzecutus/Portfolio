textureCUBE textureMap : register(t0);
SamplerState texFilter : register(s0);

struct PixelShaderInput
{
	float4 pos : SV_POSITION;
	float3 uv : UV;
	float3 norm : NORMALS;
};

float4 main(PixelShaderInput input) : SV_TARGET
{
	float4 baseColor = textureMap.Sample(texFilter, input.uv.xyz); // get base color
	return baseColor;
}