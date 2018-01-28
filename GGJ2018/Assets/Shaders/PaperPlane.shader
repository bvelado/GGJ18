// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GGJ18/PaperPlane"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Albedo("Albedo", 2D) = "white" {}
		_Paper("Paper", 2D) = "white" {}
		_Slide("Slide", Range( 0 , 1)) = 0
		_InkColor("InkColor", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float2 texcoord_0;
		};

		uniform float4 _InkColor;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _Paper;
		uniform float4 _Paper_ST;
		uniform float _Slide;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
			v.vertex.xyz += ( ( _SinTime.z * float3(0,0.1,0) ) * v.color.r );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float temp_output_28_0 = distance( i.texcoord_0.x , 0.5 );
			float2 uv_Paper = i.uv_texcoord * _Paper_ST.xy + _Paper_ST.zw;
			float lerpResult22 = lerp( 0.1 , 1.0 , ( _Slide * 0.5 ));
			float temp_output_19_0 = ( ( pow( temp_output_28_0 , 0.6 ) * pow( tex2D( _Paper, uv_Paper ).r , 1.0 ) ) + lerpResult22 );
			float clampResult18 = clamp( temp_output_19_0 , 0.0 , 1.0 );
			float4 lerpResult24 = lerp( _InkColor , tex2D( _Albedo, uv_Albedo ) , round( clampResult18 ));
			o.Albedo = lerpResult24.rgb;
			float temp_output_8_0 = 0.0;
			o.Metallic = temp_output_8_0;
			o.Smoothness = temp_output_8_0;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13201
1927;29;1906;1004;1641.997;364.0571;1.59412;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-1048.361,471.3576;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;20;-485.5258,973.8007;Float;False;Property;_Slide;Slide;2;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.DistanceOpNode;28;-766.2462,455.216;Float;False;2;0;FLOAT;0,0,0,0;False;1;FLOAT;0.5;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;16;-1000.074,854.6732;Float;True;Property;_Paper;Paper;1;0;Assets/Models/Plane/Paper.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.PowerNode;31;-519.2462,369.6219;Float;True;2;0;FLOAT;0.0;False;1;FLOAT;0.6;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-119.2462,886.216;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.5;False;1;FLOAT
Node;AmplifyShaderEditor.PowerNode;13;-611.152,883.1573;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-279.932,556.007;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;22;-94.43201,689.3068;Float;False;3;0;FLOAT;0.1;False;1;FLOAT;1.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-100.932,517.007;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;18;152.568,520.407;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SinTimeNode;3;-798.7349,-74.36013;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.Vector3Node;7;-832.2892,97.60052;Float;False;Constant;_Vector0;Vector 0;1;0;0,0.1,0;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.VertexColorNode;4;-828.4122,249.2329;Float;False;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;25;-431.3686,-428.2574;Float;False;Property;_InkColor;InkColor;3;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-622.2892,57.60047;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT3;0;False;1;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;1;-439.7921,-169.8709;Float;True;Property;_Albedo;Albedo;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RoundOpNode;23;297.068,507.007;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;8;261.8306,30.43658;Float;False;Constant;_Float0;Float 0;1;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-451.2892,187.6007;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.PowerNode;21;8.167994,439.7071;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;3.0;False;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;29;-603.2462,602.216;Float;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;24;235.1514,-121.5225;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;579.9294,-40.86724;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;GGJ18/PaperPlane;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;26;1
WireConnection;31;0;28;0
WireConnection;30;0;20;0
WireConnection;13;0;16;1
WireConnection;10;0;31;0
WireConnection;10;1;13;0
WireConnection;22;2;30;0
WireConnection;19;0;10;0
WireConnection;19;1;22;0
WireConnection;18;0;19;0
WireConnection;6;0;3;3
WireConnection;6;1;7;0
WireConnection;23;0;18;0
WireConnection;5;0;6;0
WireConnection;5;1;4;1
WireConnection;21;0;19;0
WireConnection;29;0;28;0
WireConnection;24;0;25;0
WireConnection;24;1;1;0
WireConnection;24;2;23;0
WireConnection;0;0;24;0
WireConnection;0;3;8;0
WireConnection;0;4;8;0
WireConnection;0;11;5;0
ASEEND*/
//CHKSM=16A4771FBBB3CDE3394F90EA0645E3F7E977EAD8