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
		Debug.Log(other.name);
	}

}
