using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CustomMaterialRender : MonoBehaviour {

	[SerializeField] private Camera src;
	[SerializeField] private RenderTexture dst;
	[SerializeField] private Material mat;

	private WaitForEndOfFrame endOfFrame = new WaitForEndOfFrame();

	public void Execute(){
		StartCoroutine(Render());
	}

	public IEnumerator Render(){

		RenderTexture srcRt = 
			new RenderTexture(1024,1024,0,RenderTextureFormat.ARGB32, RenderTextureReadWrite.Default);
		srcRt.Create();		

		if(!dst.IsCreated())
			dst.Create();

		yield return endOfFrame;

		if(!srcRt.IsCreated())
			throw new Exception("Cannot create src RenderTexture.");
		if(!dst.IsCreated())
			throw new Exception("Cannot create dst RenderTexture.");

		mat.SetTexture("_MainTex", srcRt);

		var oldTargetTexture = src.targetTexture;
		src.targetTexture = srcRt;
		src.Render();
		src.targetTexture = oldTargetTexture;

		Graphics.Blit(srcRt, dst, mat);

		srcRt.DiscardContents();
		srcRt.Release();

		Destroy(srcRt);

		yield return null;
	}
}
