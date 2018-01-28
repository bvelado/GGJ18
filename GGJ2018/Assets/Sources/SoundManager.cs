using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SoundManager : MonoBehaviour {
    [SerializeField] MenuManager _menuManager = null;
    [SerializeField] GameMenuManager _gameMenuManager = null;
    [SerializeField] AudioSource _spaceSound = null;
    [SerializeField] AudioSource _pauseSound = null;

    void Start () {
        _menuManager.OnMainMenuHidden += PlaySpaceSound;
        _gameMenuManager.OnGameMenuHidden += PlaySpaceSound;
        _gameMenuManager.OnGameMenuDisplayed += PlayPauseSound;
    }

    private void PlayPauseSound()
    {
        _pauseSound.Play();
    }

    private void PlaySpaceSound()
    {
        _spaceSound.Play();
    }
}
