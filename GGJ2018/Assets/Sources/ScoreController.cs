using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class ScoreController : MonoBehaviour {
    [SerializeField] GameFlowManager _gameFlowManager = null;
    [SerializeField] Level _level = null;
    [SerializeField] TextMeshProUGUI _scoreLabel = null;

    float _score = 0f;
    bool _scoring = false;

	void Start () {
        _gameFlowManager.OnGamePaused += StopScoring;
        _gameFlowManager.OnGameResumed += ResumeScoring;
        _gameFlowManager.OnGameStarted += StartScoring;
        _gameFlowManager.OnGameStopped += StopScoring;
	}

    private void StartScoring()
    {
        _score = 0f;
        _scoreLabel.text = "0";
        _scoring = true;
    }

    private void ResumeScoring()
    {
        _scoring = true;
    }

    private void StopScoring()
    {
        _scoring = false;
    }

    void Update () {
        if (_scoring)
        {
            _score += Time.deltaTime * _level.MovementSpeed;
            _scoreLabel.text = Mathf.CeilToInt(_score).ToString();
        }
	}
}
