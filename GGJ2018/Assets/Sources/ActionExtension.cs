using System;

public static class ActionExtension {
    public static void RaiseEvent(this Action theAction)
    {
        var actionCopy = theAction;
        if(actionCopy != null)
        {
            actionCopy();
        }
    }
}
