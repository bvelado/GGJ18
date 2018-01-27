using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PaperPlane : MonoBehaviour {
    [SerializeField] float _initialMass = 1f;
    [SerializeField] AnimationCurve _massEvolution = new AnimationCurve();

    float _currentTime = 0f;
    float _currentMass = 0f;

    float _maxCurveTime;
    float _minCurveTime;

    public bool IsTakingPaper { get; private set; }
    public bool IsGivingPaper { get; private set; }

    Vector3 _initialScale;
    Vector3 _initialPosition;

    private void Start()
    {
        _currentMass = _initialMass;
        _initialScale = transform.localScale;
        _initialPosition = transform.localPosition;
        _maxCurveTime = _massEvolution.keys[_massEvolution.length - 1].time;
        _minCurveTime = _massEvolution.keys[0].time;
    }

    public void TakePaper()
    {
        _currentTime -= Time.deltaTime;
        _currentTime = Mathf.Max(_currentTime, _minCurveTime);
        _currentMass = _initialMass + _massEvolution.Evaluate(_currentTime);
        ReactToMassChange();
        //Debug.Log(string.Format("[TakePaper/{0}] - Current mass : {1}", gameObject.name, _currentMass));
    }

    public void GivePaper()
    {
        _currentTime += Time.deltaTime;
        _currentTime = Mathf.Min(_currentTime, _maxCurveTime);
        _currentMass = _initialMass + _massEvolution.Evaluate(_currentTime);
        ReactToMassChange();
        //Debug.Log(string.Format("[GivePaper/{0}] - Current mass : {1}", gameObject.name, _currentMass));
    }

    void ReactToMassChange()
    {
        var massEvolution = _massEvolution.Evaluate(_currentTime);
        transform.localScale = new Vector3(_currentMass, _currentMass, _currentMass);
        transform.localPosition = _initialPosition + Vector3.up * massEvolution;
    }
}
