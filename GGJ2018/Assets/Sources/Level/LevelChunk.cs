using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelChunk : PooledObject {
    
    // private Transform transform;
    [SerializeField] private ObstacleChunk[] allowedObstacles = new ObstacleChunk[0];
    private PooledObject obstacle;

    public void OnSpawn(){
        // TODO
        obstacle = allowedObstacles[Random.Range(0, allowedObstacles.Length)].GetPooledInstance<ObstacleChunk>();
        obstacle.transform.SetParent(transform);
        obstacle.transform.localPosition = Vector3.zero;
        obstacle.transform.localRotation = Quaternion.AngleAxis(180f, Vector3.up);
    }

    public void OnDespawn(){
        // TODO
        obstacle.transform.SetParent(obstacle.Pool.transform);
        obstacle.ReturnToPool();
    }

}