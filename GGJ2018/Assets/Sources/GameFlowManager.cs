using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class GameFlowManager : MonoBehaviour {
    [SerializeField] InputManager _inputManager = null;
    [SerializeField] Level _levelManager = null;
    [SerializeField] PlayerController _player1 = null;
    [SerializeField] PlayerController _player2 = null;

    public event Action OnGameStarted;
    public event Action OnGamePaused;
    public event Action OnGameResumed;
    public event Action OnGameStopped;

    private bool firstTime = true;

    public void StartGame()
    {
        _inputManager.OnGivePaperP1KeyPressed += P1GivePaper;
        _inputManager.OnGivePaperP2KeyPressed += P2GivePaper;

        _player1.PlayerCollidedWithObstacle.AddListener(StopGame);
        _player2.PlayerCollidedWithObstacle.AddListener(StopGame);

        _player1.ResetModel();
        _player2.ResetModel();

        if(!firstTime) {
            _levelManager.Clear();
            _levelManager.GenerateAllChunks(true, 0.6f);
        }
        
        firstTime = false;
        
        _levelManager.SetPlay(true);
        RaiseAction(OnGameStarted);
    }

    /// Quand on meurt
    public void StopGame()
    {
        _inputManager.OnGivePaperP1KeyPressed -= P1GivePaper;
        _inputManager.OnGivePaperP2KeyPressed -= P2GivePaper;

        _player1.PlayerCollidedWithObstacle.RemoveListener(StopGame);
        _player2.PlayerCollidedWithObstacle.RemoveListener(StopGame);

        _levelManager.SetPlay(false);
        RaiseAction(OnGameStopped);
    }

    public void PauseGame(){
        _inputManager.OnGivePaperP1KeyPressed -= P1GivePaper;
        _inputManager.OnGivePaperP2KeyPressed -= P2GivePaper;

        _levelManager.SetPlay(false);
        RaiseAction(OnGamePaused);
    }

    public void ResumeGame(){
        _inputManager.OnGivePaperP1KeyPressed += P1GivePaper;
        _inputManager.OnGivePaperP2KeyPressed += P2GivePaper;

        _levelManager.SetPlay(true);
        RaiseAction(OnGameResumed);
    }

    private void P1GivePaper()
    {
        _player1.GivePaper();
        _player2.TakePaper();
    }

    private void P2GivePaper()
    {
        _player1.TakePaper();
        _player2.GivePaper();
    }

    void RaiseAction(Action theAction)
    {
        var actionCopy = theAction;
        if(actionCopy != null)
        {
            actionCopy();
        }
    }
}
