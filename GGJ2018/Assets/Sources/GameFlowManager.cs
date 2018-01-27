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

    public void StartGame()
    {
        _inputManager.OnGivePaperP1KeyPressed += P1GivePaper;
        _inputManager.OnGivePaperP2KeyPressed += P2GivePaper;

        // _levelManager.GenerateAllChunks();
        _levelManager.SetPlay(true);
    }

    public void StopGame()
    {
        _inputManager.OnGivePaperP1KeyPressed -= P1GivePaper;
        _inputManager.OnGivePaperP2KeyPressed -= P2GivePaper;

        _levelManager.SetPlay(false);
    }

    public void PauseGame(){
        _inputManager.OnGivePaperP1KeyPressed -= P1GivePaper;
        _inputManager.OnGivePaperP2KeyPressed -= P2GivePaper;

        _levelManager.SetPlay(false);
    }

    public void ResumeGame(){
        _inputManager.OnGivePaperP1KeyPressed += P1GivePaper;
        _inputManager.OnGivePaperP2KeyPressed += P2GivePaper;

        _levelManager.SetPlay(true);
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
}
