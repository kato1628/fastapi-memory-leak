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
Initial Mem Usage
==========================================
fastapi-py311-gunicorn: 595.2MiB / 15.6GiB
fastapi-py311-gunicorn-max-requests: 616.5MiB / 15.6GiB
==========================================
Run 5000 Requests....
Run fastapi-py311-gunicorn
real: 1m8.272s; user 0m59.336s; system 0m6.126s
Run fastapi-py311-gunicorn-max-requests
real: 1m9.008s; user 1m0.062s; system 0m6.047s
After 1000 Requests Mem Usage
==========================================
fastapi-py311-gunicorn: 595.7MiB / 15.6GiB
fastapi-py311-gunicorn-max-requests: 616.8MiB / 15.6GiB
==========================================
Cleanup....
```
