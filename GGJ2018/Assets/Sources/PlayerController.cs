using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour {
    [SerializeField] InputManager _inputManager = null;
    [SerializeField] PaperPlane _player1 = null;
    [SerializeField] PaperPlane _player2 = null;

    bool _p1GivingPaper = false;
    bool _p1TakingPaper = false;

    void Start () {
        _inputManager.OnGivePaperP1KeyPressed += P1GivePaper;
        _inputManager.OnGivePaperP2KeyPressed += P2GivePaper;
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
