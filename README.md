# fastapi-memory-leak

This repository includes a simple test for fastapi memory leak with python3.11 discussed on https://github.com/tiangolo/fastapi/discussions/8612

The following patterns can be tested.

- Python 3.11, fastapi 0.95.2, uvicorn
- Python 3.11, fastapi 0.95.2, uvicorn with --reload option
- Python 3.11, fastapi 0.95.2, gunicorn with UvicornWorker class

## Run

1. Install and launch Docker
2. Run `test.sh` or `test-gunicorn.sh`

## Outputs(example)

```
bash test.sh
Build....
Start Server....
Initial Mem Usage
==========================================
fastapi-py311: 70.38MiB / 15.6GiB
fastapi-py311-reload: 141MiB / 15.6GiB
==========================================
Run 1000 Requests....
Run fastapi-py311
real: 1m7.445s; user 0m59.333s; system 0m5.569s
Run fastapi-py311-reload
real: 1m5.373s; user 0m57.200s; system 0m5.337s
After 1000 Requests Mem Usage
==========================================
fastapi-py311: 78.93MiB / 15.6GiB
fastapi-py311-reload: 145.9MiB / 15.6GiB
==========================================
Cleanup....
```

```
Build....
Start Server....
Initial Mem Usage
==========================================
fastapi-py311-gunicorn: 44.86MiB / 15.6GiB
==========================================
Run 1000 Requests....
Run fastapi-py311-gunicorn
real: 1m6.209s; user 0m57.511s; system 0m5.376s
After 1000 Requests Mem Usage
==========================================
fastapi-py311-gunicorn: 592.7MiB / 15.6GiB
==========================================
Cleanup....
```
