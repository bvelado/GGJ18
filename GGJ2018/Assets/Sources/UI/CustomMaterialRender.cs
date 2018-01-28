using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CustomMaterialRender : MonoBehaviour {

	[SerializeField] private Camera src;
	[SerializeField] private RenderTexture dst;
	[SerializeField] private Material mat;
	[SerializeField] private bool renderEveryFrame;
	[SerializeField] private int passes = 2;

	private RenderTexture firstBufferRT;
	private RenderTexture secondBufferRT;

	private WaitForEndOfFrame endOfFrame = new WaitForEndOfFrame();

	private void OnEnable(){
		firstBufferRT = 
			new RenderTexture(1024,1024,0,RenderTextureFormat.ARGB32, RenderTextureReadWrite.Default);
		firstBufferRT.Create();

		secondBufferRT =
			new RenderTexture(1024,1024,0,RenderTextureFormat.ARGB32, RenderTextureReadWrite.Default);
		secondBufferRT.Create();

		if(!dst.IsCreated())
			dst.Create();

		if(!firstBufferRT.IsCreated())
			throw new Exception("Cannot create src RenderTexture.");
		if(!secondBufferRT.IsCreated())
			throw new Exception("Cannot create buffer RenderTexture.");
		if(!dst.IsCreated())
			throw new Exception("Cannot create dst RenderTexture.");

		mat.SetTexture("_MainTex", firstBufferRT);
	}

	private void OnDisable(){
		firstBufferRT.DiscardContents();
		firstBufferRT.Release();
		Destroy(firstBufferRT);
	}

	private void Update(){

		if(Input.GetKeyDown(KeyCode.V)) {
			// render = !render;

			// if(render)
				StartCoroutine(RenderOneShot());
		}
			

		if(renderEveryFrame){
			DoRender();
		}
	}

	public void Execute(){
		StartCoroutine(RenderOneShot());
	}

	public IEnumerator RenderOneShot(){

		yield return endOfFrame;

		DoRender();
		
		yield return null;
	}

	private void DoRender(){
		var oldTargetTexture = src.targetTexture;
		src.targetTexture = firstBufferRT;
		src.Render();
		src.targetTexture = oldTargetTexture;

		mat.SetTexture("_MainTex", firstBufferRT);
		if(passes > 1) {
			for(int i = 0; i < passes; i++){
				Graphics.Blit( i%2>0 ? secondBufferRT : firstBufferRT, i%2>0 ? firstBufferRT : secondBufferRT, mat);
				mat.SetTexture("_MainTex", i%2>0 ? firstBufferRT : secondBufferRT);
			}
			Graphics.Blit((passes-1)%2>0 ? firstBufferRT : secondBufferRT, dst);
		} else {
			Graphics.Blit(firstBufferRT, dst, mat);
		}
	}
}
