Shader "Hidden/ProCamera2D/TransitionsFX/Fade" 
{
    Properties 
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Step ("Step", Range(0, 1)) = 0
        _BackgroundColor ("Background Color", Color) = (0, 0, 0, 1)
    }
    SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}

            sampler2D _MainTex;
            float _Step;
            float4 _BackgroundColor;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 colour = _BackgroundColor;
                colour = tex2D(_MainTex, i.uv);
				return (saturate(colour) * (1 - _Step)) + (_BackgroundColor * _Step);
            }

            ENDCG
        }
    }
}