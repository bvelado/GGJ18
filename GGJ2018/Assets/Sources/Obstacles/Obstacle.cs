using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[RequireComponent(typeof(Collider))]
public class Obstacle : MonoBehaviour {

	private void Reset(){
		gameObject.isStatic = true;
		foreach(var c in GetComponents<Collider>())
			c.isTrigger = true;
	}

	private void OnTriggerEnter(Collider other)
	{
		var plane = other.GetComponent<PlayerController>();
		if(plane){
			Debug.Log("Boop " + plane.name);
		}
	}

}
