// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BackgroundBlur"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Offset("Offset", Range( 0 , 0.04)) = 1
		_MainTex("MainTex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float2 texcoord_0;
			float2 uv_texcoord;
		};

		uniform sampler2D _MainTex;
		uniform float _Offset;
		uniform float4 _MainTex_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 appendResult21 = (float4(( i.texcoord_0.x + _Offset ) , i.texcoord_0.y , 0.0 , 0.0));
			float4 appendResult30 = (float4(i.texcoord_0.x , ( _Offset + i.texcoord_0.y ) , 0.0 , 0.0));
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 appendResult42 = (float4(( i.texcoord_0.x - _Offset ) , i.texcoord_0.y , 0.0 , 0.0));
			float4 appendResult43 = (float4(i.texcoord_0.x , ( i.texcoord_0.y - _Offset ) , 0.0 , 0.0));
			float2 temp_cast_4 = (_Offset).xx;
			float4 appendResult60 = (float4(( i.texcoord_0.x + _Offset ) , ( i.texcoord_0.y - _Offset ) , 0.0 , 0.0));
			float4 appendResult65 = (float4(( i.texcoord_0.x - _Offset ) , ( i.texcoord_0.y + _Offset ) , 0.0 , 0.0));
			float4 temp_output_38_0 = ( ( ( tex2D( _MainTex, appendResult21.xy ) + tex2D( _MainTex, appendResult30.xy ) + tex2D( _MainTex, uv_MainTex ) + tex2D( _MainTex, appendResult42.xy ) + tex2D( _MainTex, appendResult43.xy ) ) + ( tex2D( _MainTex, ( i.texcoord_0 + _Offset ) ) + tex2D( _MainTex, ( i.texcoord_0 - temp_cast_4 ) ) + tex2D( _MainTex, appendResult60.xy ) + tex2D( _MainTex, appendResult65.xy ) ) ) / 9.0 );
			o.Albedo = temp_output_38_0.rgb;
			o.Emission = temp_output_38_0.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13201
-1883;29;1633;1014;1059.322;-752.5417;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;57;-1758.835,363.8043;Float;False;1257.592;1220.758;4-axis;13;36;45;35;5;44;21;42;43;30;31;20;46;47;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-2785.809,1707.313;Float;False;Property;_Offset;Offset;0;0;1;0;0.04;0;1;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-2743.348,1402.549;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;54;-1755.068,1620.689;Float;False;1260.477;1085.76;Diagonals;13;61;63;64;65;62;58;59;60;49;51;52;50;68;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;47;-1702.271,1300.411;Float;True;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleSubtractOpNode;46;-1681.445,1006.243;Float;True;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;20;-1708.835,435.0893;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-1689.81,749.1439;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleSubtractOpNode;59;-1635.122,2344.121;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;63;-1629.323,2472.241;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleSubtractOpNode;64;-1633.282,2597.317;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;58;-1631.163,2219.045;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;21;-1422.503,419.7212;Float;True;FLOAT4;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.DynamicAppendNode;30;-1403.478,733.7758;Float;True;FLOAT4;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.TexturePropertyNode;71;-2709.671,1040.679;Float;True;Property;_MainTex;MainTex;1;0;None;False;white;Auto;0;1;SAMPLER2D
Node;AmplifyShaderEditor.DynamicAppendNode;42;-1407.488,1007.624;Float;True;FLOAT4;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.DynamicAppendNode;43;-1388.463,1321.678;Float;True;FLOAT4;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-1697.335,1668.784;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0.0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleSubtractOpNode;49;-1688.97,1925.883;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0.0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.DynamicAppendNode;65;-1354.925,2524.189;Float;False;FLOAT4;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.DynamicAppendNode;60;-1356.765,2270.993;Float;False;FLOAT4;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.SamplerNode;52;-1139.182,1706.272;Float;True;Property;_TextureSample4;Texture Sample 4;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;44;-1087.145,1057.524;Float;True;Property;_TextureSample3;Texture Sample 3;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;5;-1125.143,413.8043;Float;True;Property;_Textsdhg;Textsdhg;5;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;48;-961.1993,109.9602;Float;True;Property;_TextureSample5;Texture Sample 5;6;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;61;-1123.227,2240.325;Float;True;Property;_TextureSample6;Texture Sample 6;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;51;-1119.941,1976.21;Float;True;Property;_TextureSample2;Texture Sample 2;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;62;-1121.387,2493.521;Float;True;Property;_TextureSample7;Texture Sample 7;3;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;35;-1110.651,697.277;Float;True;Property;_TextureSample1;Texture Sample 1;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;45;-1072.653,1340.997;Float;True;Property;_TextureSample4;Texture Sample 4;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;68;-694.9548,2128.523;Float;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-662.1881,833.067;Float;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;39;-236.9673,1352.406;Float;False;Constant;_Float2;Float 2;3;0;9;2;2;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;69;-304.0565,1197.867;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleDivideOpNode;38;-67.5889,1177.13;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;4;222.4232,899.1412;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;BackgroundBlur;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;False;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;False;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;47;0;22;2
WireConnection;47;1;17;0
WireConnection;46;0;22;1
WireConnection;46;1;17;0
WireConnection;20;0;22;1
WireConnection;20;1;17;0
WireConnection;31;0;17;0
WireConnection;31;1;22;2
WireConnection;59;0;22;2
WireConnection;59;1;17;0
WireConnection;63;0;22;2
WireConnection;63;1;17;0
WireConnection;64;0;22;1
WireConnection;64;1;17;0
WireConnection;58;0;22;1
WireConnection;58;1;17;0
WireConnection;21;0;20;0
WireConnection;21;1;22;2
WireConnection;30;0;22;1
WireConnection;30;1;31;0
WireConnection;42;0;46;0
WireConnection;42;1;22;2
WireConnection;43;0;22;1
WireConnection;43;1;47;0
WireConnection;50;0;22;0
WireConnection;50;1;17;0
WireConnection;49;0;22;0
WireConnection;49;1;17;0
WireConnection;65;0;64;0
WireConnection;65;1;63;0
WireConnection;60;0;58;0
WireConnection;60;1;59;0
WireConnection;52;0;71;0
WireConnection;52;1;50;0
WireConnection;44;0;71;0
WireConnection;44;1;42;0
WireConnection;5;0;71;0
WireConnection;5;1;21;0
WireConnection;48;0;71;0
WireConnection;61;0;71;0
WireConnection;61;1;60;0
WireConnection;51;0;71;0
WireConnection;51;1;49;0
WireConnection;62;0;71;0
WireConnection;62;1;65;0
WireConnection;35;0;71;0
WireConnection;35;1;30;0
WireConnection;45;0;71;0
WireConnection;45;1;43;0
WireConnection;68;0;52;0
WireConnection;68;1;51;0
WireConnection;68;2;61;0
WireConnection;68;3;62;0
WireConnection;36;0;5;0
WireConnection;36;1;35;0
WireConnection;36;2;48;0
WireConnection;36;3;44;0
WireConnection;36;4;45;0
WireConnection;69;0;36;0
WireConnection;69;1;68;0
WireConnection;38;0;69;0
WireConnection;38;1;39;0
WireConnection;4;0;38;0
WireConnection;4;2;38;0
ASEEND*/
//CHKSM=4ABA41DDAA2B6D2AC24FC83311BAF42789978514