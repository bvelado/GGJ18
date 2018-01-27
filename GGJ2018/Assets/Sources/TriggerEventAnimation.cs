using System.Collections;
using UnityEngine;
using UnityEngine.Events;

[System.Serializable]
public class GameObjectUnityEvent : UnityEvent<GameObject> { }

public class TriggerEventAnimation : MonoBehaviour
{
    [SerializeField] Animator _animator = null;
    [SerializeField] string _animatorStateName = "";
    [Tooltip("Full animation normalized time, if animation plays twice before stopping, should be 2.")]
    [SerializeField]
    float _animationNormalizedTime = 1f;
    [SerializeField] bool _checkOnStart = false;
    [SerializeField] bool _checkOnEnable = false;
    [Tooltip("Interval in (s) between two state check. 0 means real-time. Be aware that a too big number can make you miss the state.")]
    [SerializeField]
    float _checkInterval = 0f;
    [SerializeField] string _animatorLayerName = "Base Layer";

    bool _shouldCheck = false;
    bool _isPlaying = false;

    AnimatorStateInfo _animationState;

    public GameObjectUnityEvent OnAnimationStart;
    public GameObjectUnityEvent OnAnimationEnd;
    int _animatorLayer = 0;

    void Start()
    {
        _animatorLayer = _animator.GetLayerIndex(_animatorLayerName);
        if (_animatorLayer == -1)
        {
            _animatorLayer = 0;
        }
        if (_checkOnStart)
        {
            StartChecking();
        }
    }

    private void OnEnable()
    {
        if (_checkOnEnable)
        {
            StartChecking();
        }
    }

    private void OnDisable()
    {
        StopAllCoroutines();
    }

    #region Check Methods

    public void StartChecking()
    {
        _shouldCheck = true;
        if (_checkInterval > 0f)
        {
            StartCoroutine(CheckStateNameCoroutine(_checkInterval));
        }
        else
        {
            StartCoroutine(CheckStateNameCoroutine());
        }
    }

    IEnumerator CheckStateNameCoroutine()
    {
        while (_shouldCheck)
        {
            if (_animator.GetCurrentAnimatorStateInfo(_animatorLayer).IsName(_animatorStateName))
            {
                _animationState = _animator.GetCurrentAnimatorStateInfo(_animatorLayer);
                _isPlaying = true;
                _shouldCheck = false;
                if(OnAnimationStart != null)
                {
                    OnAnimationStart.Invoke(gameObject);
                }
                yield break;
            }
            yield return null;
        }
    }

    IEnumerator CheckStateNameCoroutine(float checkInterval)
    {
        while (_shouldCheck)
        {
            if (_animator.GetCurrentAnimatorStateInfo(_animatorLayer).IsName(_animatorStateName))
            {
                _animationState = _animator.GetCurrentAnimatorStateInfo(_animatorLayer);
                _isPlaying = true;
                _shouldCheck = false;

                if (OnAnimationStart != null)
                {
                    OnAnimationStart.Invoke(gameObject);
                }
                yield break;
            }
            yield return new WaitForSeconds(checkInterval);
        }
    }

    #endregion

    void Update()
    {
        if (_isPlaying)
        {
            _animationState = _animator.GetCurrentAnimatorStateInfo(0);
            if (_animationState.normalizedTime >= _animationNormalizedTime)
            {
                if (OnAnimationEnd != null)
                {
                    OnAnimationEnd.Invoke(gameObject);
                }
                _isPlaying = false;
            }
        }
    }
}
