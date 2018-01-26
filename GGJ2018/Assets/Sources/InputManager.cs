using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InputManager : MonoBehaviour {
    public event Action OnTakePaperP1KeyPressed;
    public event Action OnGivePaperP1KeyPressed;

    public event Action OnTakePaperP2KeyPressed;
    public event Action OnGivePaperP2KeyPressed;

    void Update () {
		if(Input.GetAxis("Take Paper (P1)") > 0.5f)
        {
            RaiseAction(OnTakePaperP1KeyPressed);
        }
        else if(Input.GetAxis("Give Paper (P1)") > 0.5f)
        {
            RaiseAction(OnGivePaperP1KeyPressed);
        }

        if (Input.GetAxis("Take Paper (P2)") > 0.5f)
        {
            RaiseAction(OnTakePaperP2KeyPressed);
        }
        else if (Input.GetAxis("Give Paper (P2)") > 0.5f)
        {
            RaiseAction(OnGivePaperP2KeyPressed);
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
}
