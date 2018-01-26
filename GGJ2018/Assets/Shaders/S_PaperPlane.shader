// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GGJ18/PaperPlane"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Albedo("Albedo", 2D) = "white" {}
		_Noise("Noise", 2D) = "white" {}
		_Dissolve("Dissolve", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float2 texcoord_0;
		};

		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _Noise;
		uniform float4 _Noise_ST;
		uniform float _Dissolve;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
			v.vertex.xyz += ( ( _SinTime.z * float3(0,0.1,0) ) * v.color.r );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float2 uv_Noise = i.uv_texcoord * _Noise_ST.xy + _Noise_ST.zw;
			float4 tex2DNode11 = tex2D( _Noise, uv_Noise );
			float4 lerpResult29 = lerp( float4( 1,1,1,0 ) , ( ( tex2DNode11.r + 0.5 ) * float4(1,0.4344828,0,0) ) , _Dissolve);
			o.Albedo = ( tex2D( _Albedo, uv_Albedo ) * lerpResult29 ).rgb;
			float temp_output_8_0 = 0.0;
			o.Metallic = temp_output_8_0;
			o.Smoothness = temp_output_8_0;
			o.Alpha = 1;
			float lerpResult24 = lerp( 1.0 , ( i.texcoord_0.y + tex2DNode11.r ) , _Dissolve);
			clip( lerpResult24 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13201
1927;29;1906;1004;1368.284;814.6082;1.396525;True;True
Node;AmplifyShaderEditor.SamplerNode;11;-906.3103,-43.83727;Float;True;Property;_Noise;Noise;2;0;Assets/Models/Plane/T_Noise_1.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;31;-773.3645,-515.7518;Float;False;Constant;_Color0;Color 0;4;0;1,0.4344828,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;32;-616.9542,-260.1878;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.5;False;1;FLOAT
Node;AmplifyShaderEditor.SinTimeNode;3;-723.7026,267.2333;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-858.212,-312.9373;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;15;-827.0098,155.0629;Float;False;Property;_Dissolve;Dissolve;3;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.Vector3Node;7;-757.257,439.1941;Float;False;Constant;_Vector0;Vector 0;1;0;0,0.1,0;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-495.4565,-377.4957;Float;True;2;2;0;FLOAT;0.0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.VertexColorNode;4;-753.3799,590.8265;Float;False;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;1;-479.8307,-581.8108;Float;True;Property;_Albedo;Albedo;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-552.7097,-141.3372;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-547.257,399.1941;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT3;0;False;1;FLOAT3
Node;AmplifyShaderEditor.LerpOp;29;-284.0096,-366.3187;Float;False;3;0;COLOR;1,1,1,0;False;1;COLOR;0.0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;24;-299.2103,-23.0372;Float;True;3;0;FLOAT;1.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-35.36407,-456.7919;Float;True;2;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;8;-213.5358,-130.3919;Float;False;Constant;_Float0;Float 0;1;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;28;-310.9103,-184.2371;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-376.2567,529.1942;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;55.39999,-128.3;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;GGJ18/PaperPlane;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Custom;0.5;True;True;0;False;Opaque;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;32;0;11;1
WireConnection;30;0;32;0
WireConnection;30;1;31;0
WireConnection;23;0;10;2
WireConnection;23;1;11;1
WireConnection;6;0;3;3
WireConnection;6;1;7;0
WireConnection;29;1;30;0
WireConnection;29;2;15;0
WireConnection;24;1;23;0
WireConnection;24;2;15;0
WireConnection;27;0;1;0
WireConnection;27;1;29;0
WireConnection;5;0;6;0
WireConnection;5;1;4;1
WireConnection;0;0;27;0
WireConnection;0;3;8;0
WireConnection;0;4;8;0
WireConnection;0;10;24;0
WireConnection;0;11;5;0
ASEEND*/
//CHKSM=21139DF8A1B0395073FD3AAB1A7B54184B4B375D