﻿using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MenuManager : MonoBehaviour {
    [SerializeField] GameFlowManager _gameFlowManager = null;
    [SerializeField] InputManager _inputManager = null;
    [SerializeField] GameObject _mainMenuCanvas = null;
    [SerializeField] TriggerEventAnimation _showTriggerEvent = null;
    [SerializeField] TriggerEventAnimation _hideTriggerEvent = null;
    [SerializeField] GameMenuManager _gameMenuManager = null;

    public event Action OnMainMenuDisplayed;
    public event Action OnMainMenuHidden;

    void Start()
    {
        _gameFlowManager.OnGameStopped += GoToMainMenu;

        GoToMainMenu();
    }

    void StartGame (GameObject menu) {
        _hideTriggerEvent.OnAnimationEnd.RemoveListener(StartGame);
        _mainMenuCanvas.SetActive(false);
        _gameFlowManager.StartGame();
        _gameMenuManager.InitializeInputHandlers();
    }

    public void GoToMainMenu()
    {
        _mainMenuCanvas.GetComponent<CanvasGroup>().alpha = 0f;
        _mainMenuCanvas.SetActive(true);
        _showTriggerEvent.OnAnimationEnd.AddListener(RegisterSpaceKeyEvent);
    }

    private void RegisterSpaceKeyEvent(GameObject mainMenu)
    {
        var eventCopy = OnMainMenuDisplayed;
        if(eventCopy != null)
        {
            eventCopy();
        }
        _showTriggerEvent.OnAnimationEnd.RemoveListener(RegisterSpaceKeyEvent);
        _inputManager.OnSpaceKeyPressed.AddListener(HideMenu);
    }

    private void HideMenu()
    {
        var eventCopy = OnMainMenuHidden;
        if (eventCopy != null)
        {
            eventCopy();
        }
        _inputManager.OnSpaceKeyPressed.RemoveListener(HideMenu);
        _hideTriggerEvent.OnAnimationEnd.AddListener(StartGame);
        _mainMenuCanvas.GetComponent<Animator>().SetTrigger("Hide");
    }
}
