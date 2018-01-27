using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MenuManager : MonoBehaviour {
    [SerializeField] GameFlowManager _gameFlowManager = null;
    [SerializeField] InputManager _inputManager = null;
    [SerializeField] GameObject _mainMenuCanvas = null;
    [SerializeField] TriggerEventAnimation _showTriggerEvent = null;
    [SerializeField] TriggerEventAnimation _hideTriggerEvent = null;

    void Start()
    {
        GoToMainMenu();
    }

    void StartGame (GameObject menu) {
        _hideTriggerEvent.OnAnimationEnd.RemoveListener(StartGame);
        _mainMenuCanvas.SetActive(false);
        _gameFlowManager.StartGame();
    }

    public void GoToMainMenu()
    {
        _mainMenuCanvas.SetActive(true);
        _showTriggerEvent.OnAnimationEnd.AddListener(RegisterSpaceKeyEvent);
    }

    private void RegisterSpaceKeyEvent(GameObject mainMenu)
    {
        _showTriggerEvent.OnAnimationEnd.RemoveListener(RegisterSpaceKeyEvent);
        _inputManager.OnSpaceKeyPressed.AddListener(HideMenu);
    }

    private void HideMenu()
    {
        _inputManager.OnSpaceKeyPressed.RemoveListener(HideMenu);
        _hideTriggerEvent.OnAnimationEnd.AddListener(StartGame);
        _mainMenuCanvas.GetComponent<Animator>().SetTrigger("Hide");
    }
}
