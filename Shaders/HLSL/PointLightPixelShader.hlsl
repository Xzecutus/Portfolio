texture2D normalMap : register(t0); // normal map for models
texture2D baseTexture : register(t1); // base texture for models

SamplerState filters : register(s0); // filter 0 using CLAMP, filter 1 using WRAP

									 // Per-pixel color data passed through the pixel shader.
struct PixelShaderInput
{
	float4 pos : SV_POSITION;
	float4 uv : UV;
	float4 normal : NORMAL;
	float4 worldPos : WORLD_POSITION;

};

// A pass-through function for the (interpolated) color data.
float4 main(PixelShaderInput input) : SV_TARGET
{
	float4 baseColor = baseTexture.Sample(filters, input.uv.xyz); // get base color

	// Directional Light Code
	float3 lightDirection = float3(0.5f, -1, 0);
	float3 surfaceNormals = input.normal.xyz;
	float4 lightColor = float4(1.0f, 1.0f, 1.0f, 1.0f);

	float lightRatio = saturate(dot(-normalize(lightDirection), normalize(surfaceNormals)));
	return lightRatio * lightColor * baseColor;
}



/*           POINT LIGHT
LIGHTDIR = NORMALIZE( LIGHTPOS – SURFACEPOS )
LIGHTRATIO = CLAMP( DOT( LIGHTDIR, SURFACENORMAL ) )
RESULT = LIGHTRATIO * LIGHTCOLOR * SURFACECOLOR
*/

/*             SPOT LIGHT
LIGHTDIR = NORMALIZE( LIGHTPOS – SURFACEPOS ) )
SURFACERATIO = CLAMP( DOT(   -LIGHTDIR, CONEDIR ) )
SPOTFACTOR = ( SURFACERATIO > CONERATIO ) ? 1 : 0
LIGHTRATIO = CLAMP( DOT( LIGHTDIR, SURFACENORMAL ) )
RESULT = SPOTFACTOR * LIGHTRATIO * LIGHTCOLOR * SURFACECOLOR
*/