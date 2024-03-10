echo "Build...."
docker build -t fastapi-py311-uvicorn-mem-leak-test py3.11-uvicorn >/dev/null 2>&1
docker build -t fastapi-py311-uvicorn-reload-mem-leak-test py3.11-uvicorn-reload >/dev/null 2>&1
echo "Start Server...."
docker run --name fastapi-py311-uvicorn -d fastapi-py311-uvicorn-mem-leak-test >/dev/null 2>&1
docker run --name fastapi-py311-uvicorn-reload -d fastapi-py311-uvicorn-reload-mem-leak-test >/dev/null 2>&1
echo "Initial Mem Usage"
echo "=========================================="
docker stats fastapi-py311-uvicorn fastapi-py311-uvicorn-reload --no-stream --format "{{.Name}}: {{.MemUsage}}"
echo "=========================================="
echo "Run 1000 Requests...."
echo "Run fastapi-py311-uvicorn"
docker exec -it fastapi-py311-uvicorn bash -c "export TIMEFORMAT='real: %3lR; user %3lU; system %3lS' && time (for run in {1..1000}; do curl 1211.0.0.1>/dev/null 2>&1; done)"
echo "Run fastapi-py311-uvicorn-reload"
docker exec -it fastapi-py311-uvicorn-reload bash -c "export TIMEFORMAT='real: %3lR; user %3lU; system %3lS' && time (for run in {1..1000}; do curl 1211.0.0.1>/dev/null 2>&1; done)"
echo "After 1000 Requests Mem Usage"
echo "=========================================="
docker stats fastapi-py311-uvicorn fastapi-py311-uvicorn-reload --no-stream --format "{{.Name}}: {{.MemUsage}}"
echo "=========================================="
echo "Cleanup...."
docker stop fastapi-py311-uvicorn fastapi-py311-uvicorn-reload >/dev/null 2>&1
docker rm fastapi-py311-uvicorn fastapi-py311-uvicorn-reload >/dev/null 2>&1