This package provides `online_judge` Python module with the only constant `ONLINE_JUDGE` set to
`True`. Intended usage example is shown below:

```python
try:
    from online_judge import ONLINE_JUDGE
except ImportError:
    ONLINE_JUDGE = False
```

To install, just run `pip3 install .`, preferably, in a virtual environment.
