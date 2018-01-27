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
	[SerializeField] private bool render = false;

	private RenderTexture srcRt;
	private RenderTexture bufferRt;

	private WaitForEndOfFrame endOfFrame = new WaitForEndOfFrame();

	private void OnEnable(){
		srcRt = 
			new RenderTexture(1024,1024,0,RenderTextureFormat.ARGB32, RenderTextureReadWrite.Default);
		srcRt.Create();

		bufferRt =
			new RenderTexture(1024,1024,0,RenderTextureFormat.ARGB32, RenderTextureReadWrite.Default);
		bufferRt.Create();

		if(!dst.IsCreated())
			dst.Create();

		if(!srcRt.IsCreated())
			throw new Exception("Cannot create src RenderTexture.");
		if(!bufferRt.IsCreated())
			throw new Exception("Cannot create buffer RenderTexture.");
		if(!dst.IsCreated())
			throw new Exception("Cannot create dst RenderTexture.");

		mat.SetTexture("_MainTex", srcRt);
	}

	private void OnDisable(){
		srcRt.DiscardContents();
		srcRt.Release();
		Destroy(srcRt);
	}

	private void Update(){

		if(Input.GetKeyDown(KeyCode.V)) {
			// render = !render;

			// if(render)
				StartCoroutine(RenderOneShot());
		}
			

		// if(renderEveryFrame){
		// 	DoRender();
		// }
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
		src.targetTexture = srcRt;
		src.Render();
		src.targetTexture = oldTargetTexture;

		if(passes > 1) {
			for(int i = 0; i < passes; i++){
				Graphics.Blit( i%2>0 ? bufferRt : srcRt, i%2>0 ? srcRt : bufferRt, mat);
				mat.SetTexture("_MainTex", i%2>0 ? srcRt : bufferRt);
			}
			Graphics.Blit((passes-1)%2>0 ? srcRt : bufferRt, dst);
		} else {
			Graphics.Blit(srcRt, dst, mat);
		}
	}
}
