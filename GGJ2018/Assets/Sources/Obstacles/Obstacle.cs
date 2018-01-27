using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[RequireComponent(typeof(BoxCollider))]
public class Obstacle : MonoBehaviour {



	private void Reset(){
		gameObject.isStatic = true;
		GetComponent<BoxCollider>().isTrigger = true;
	}

	private void OnTriggerEnter(Collider other)
	{
		var plane = other.GetComponent<PaperPlane>();
		if(plane){
			Debug.Log("Boop " + plane.name);
		}
	}

}
