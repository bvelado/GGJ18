using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameFlowManager : MonoBehaviour {
    [SerializeField] InputManager _inputManager = null;
    [SerializeField] PlayerController _player1 = null;
    [SerializeField] PlayerController _player2 = null;

    public void StartGame()
    {
        _inputManager.OnGivePaperP1KeyPressed += P1GivePaper;
        _inputManager.OnGivePaperP2KeyPressed += P2GivePaper;
    }

    public void StopGame()
    {
        _inputManager.OnGivePaperP1KeyPressed -= P1GivePaper;
        _inputManager.OnGivePaperP2KeyPressed -= P2GivePaper;
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
