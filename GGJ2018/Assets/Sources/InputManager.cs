using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class InputManager : MonoBehaviour {
    bool _gpP1Pressed = false;
    bool _gpP2Pressed = false;

    public event Action OnGivePaperP1KeyPressed;
    public event Action OnGivePaperP1KeyReleased;

    public event Action OnGivePaperP2KeyPressed;
    public event Action OnGivePaperP2KeyReleased;



    public UnityEvent OnSelectKeyPressed;
    public UnityEvent OnBackKeyPressed;
    public UnityEvent OnPauseKeyPressed;
    public UnityEvent OnSpaceKeyPressed;

    void Update () {
        if(Input.GetAxis("Give Paper (P1)") > 0.5f)
        {
            RaiseAction(OnGivePaperP1KeyPressed);
            _gpP1Pressed = true;
        }
        else if (Input.GetAxis("Give Paper (P1)") < 0.5f && _gpP1Pressed)
        {
            RaiseAction(OnGivePaperP1KeyReleased);
            _gpP1Pressed = false;
        }
        if (Input.GetAxis("Give Paper (P2)") > 0.5f)
        {
            RaiseAction(OnGivePaperP2KeyPressed);
            _gpP2Pressed = true;
        }
        else if (Input.GetAxis("Give Paper (P2)") < 0.5f && _gpP2Pressed)
        {
            RaiseAction(OnGivePaperP2KeyReleased);
            _gpP2Pressed = false;
        }

        if (Input.GetAxis("Select") > 0.5f)
        {
            RaiseEvent(OnSelectKeyPressed);
        }
        if (Input.GetAxis("Back") > 0.5f)
        {
            RaiseEvent(OnBackKeyPressed);
        }
        if (Input.GetAxis("Pause") > 0.5f)
        {
            RaiseEvent(OnPauseKeyPressed);
        }
        if(Input.GetAxis("Space") > 0.5f)
        {
            RaiseEvent(OnSpaceKeyPressed);
        }
    }

    void RaiseAction(Action theAction)
    {
        Action actionCopy = theAction;
        if(actionCopy != null)
        {
            actionCopy();
        }
    }

    void RaiseEvent(UnityEvent theEvent)
    {
        var eventCopy = theEvent;
        if(eventCopy != null)
        {
            eventCopy.Invoke();
        }
    }
}
