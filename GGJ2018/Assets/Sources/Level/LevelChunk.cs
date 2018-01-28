using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelChunk : PooledObject {
    
    // private Transform transform;
    [SerializeField] private ObstacleChunk[] allowedObstacles = new ObstacleChunk[0];
    [SerializeField] private EnvironmentChunk[] allowedEnvironment = new EnvironmentChunk[0];
    private ObstacleChunk obstacle;
    private EnvironmentChunk environment;

    public void OnSpawn(){
        // TODO
        if(allowedObstacles.Length > 0){
            obstacle = allowedObstacles[Random.Range(0, allowedObstacles.Length)].GetPooledInstance<ObstacleChunk>();
            if(obstacle){
                obstacle.transform.SetParent(transform);
                obstacle.transform.localPosition = Vector3.zero;
                obstacle.transform.localRotation = Quaternion.AngleAxis(180f, Vector3.up);
            }
        }

        if(allowedEnvironment.Length > 0){
            environment = allowedEnvironment[Random.Range(0, allowedEnvironment.Length)].GetPooledInstance<EnvironmentChunk>();
            if(environment){
                environment.transform.SetParent(transform);
                environment.transform.localPosition = Vector3.zero;
                environment.transform.localRotation = Quaternion.AngleAxis(180f, Vector3.up);
            }
        }
    }

    public void OnDespawn(){
        // TODO
        if(obstacle){
            obstacle.transform.SetParent(obstacle.Pool.transform);
            obstacle.ReturnToPool();
        }

        if(environment){
            environment.transform.SetParent(environment.Pool.transform);
            environment.ReturnToPool();
        }
    }

}