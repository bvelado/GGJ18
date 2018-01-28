using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameMenuManager : MonoBehaviour {
	[SerializeField] GameFlowManager _gameFlowManager = null;
    [SerializeField] InputManager _inputManager = null;
    [SerializeField] GameObject _gameMenuCanvas = null;
    [SerializeField] TriggerEventAnimation _showTriggerEvent = null;
    [SerializeField] TriggerEventAnimation _hideTriggerEvent = null;

    public event Action OnGameMenuDisplayed;
    public event Action OnGameMenuHidden;

	public void InitializeInputHandlers(){
        _inputManager.OnBackKeyPressed.RemoveListener(PauseGame);
        _inputManager.OnBackKeyPressed.AddListener(PauseGame);
	}

    void ResumeGame (GameObject menu) {
        _hideTriggerEvent.OnAnimationEnd.RemoveListener(ResumeGame);

        _gameFlowManager.ResumeGame();
		_inputManager.OnBackKeyPressed.AddListener(PauseGame);
    }

	void PauseGame(){
		_inputManager.OnBackKeyPressed.RemoveListener(PauseGame);

		_gameFlowManager.PauseGame();
		DisplayGameMenu();
	}

    public void DisplayGameMenu()
    {
        _gameMenuCanvas.GetComponent<CanvasGroup>().alpha = 0f;
        _showTriggerEvent.OnAnimationEnd.AddListener(RegisterResumeOnSpacebarKeyEvent);
		_showTriggerEvent.OnAnimationEnd.AddListener(RegisterExitApplicationOnKeyEvent);
        _gameMenuCanvas.SetActive(true);
        OnGameMenuDisplayed.RaiseEvent();
    }

    private void HideGameMenu()
    {
        _inputManager.OnSpaceKeyPressed.RemoveListener(HideGameMenu);
		_inputManager.OnBackKeyPressed.RemoveListener(ExitGame);

        _hideTriggerEvent.OnAnimationEnd.AddListener(ResumeGame);
        _gameMenuCanvas.GetComponent<Animator>().SetTrigger("Hide");
        OnGameMenuHidden.RaiseEvent();
    }

    private void ExitGame(){
		Application.Quit();
	}

    #region Events

        private void RegisterDisplayMenuOnBackKeyEvent(GameObject mainMenu)
        {
            _showTriggerEvent.OnAnimationEnd.RemoveListener(RegisterDisplayMenuOnBackKeyEvent);

            _inputManager.OnBackKeyPressed.AddListener(DisplayGameMenu);
        }

	    private void RegisterResumeOnSpacebarKeyEvent(GameObject mainMenu)
        {
            _showTriggerEvent.OnAnimationEnd.RemoveListener(RegisterResumeOnSpacebarKeyEvent);

            _inputManager.OnSpaceKeyPressed.AddListener(HideGameMenu);
        }

	    private void RegisterExitApplicationOnKeyEvent(GameObject mainMenu)
        {
            _showTriggerEvent.OnAnimationEnd.RemoveListener(RegisterExitApplicationOnKeyEvent);

            _inputManager.OnBackKeyPressed.AddListener(ExitGame);
        }
    
    #endregion
}
