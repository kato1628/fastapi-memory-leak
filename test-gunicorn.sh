
echo "Build...."
docker build -t fastapi-py311-gunicorn-mem-leak-test py3.11-gunicorn >/dev/null 2>&1
docker build -t fastapi-py311-gunicorn-max-requests-mem-leak-test py3.11-gunicorn-max-requests >/dev/null 2>&1
echo "Start Server...."
docker run --name fastapi-py311-gunicorn -d fastapi-py311-gunicorn-mem-leak-test >/dev/null 2>&1
docker run --name fastapi-py311-gunicorn-max-requests -d fastapi-py311-gunicorn-max-requests-mem-leak-test >/dev/null 2>&1
sleep 10 # wait for launching the server
echo "Initial Mem Usage"
echo "=========================================="
docker stats fastapi-py311-gunicorn fastapi-py311-gunicorn-max-requests --no-stream --format "{{.Name}}: {{.MemUsage}}"
echo "=========================================="
echo "Run 1000 Requests...."
echo "Run fastapi-py311-gunicorn"
docker exec -it fastapi-py311-gunicorn bash -c "export TIMEFORMAT='real: %3lR; user %3lU; system %3lS' && time (for run in {1..1000}; do curl 1211.0.0.1>/dev/null 2>&1; done)"
echo "Run fastapi-py311-gunicorn-max-requests"
docker exec -it fastapi-py311-gunicorn-max-requests bash -c "export TIMEFORMAT='real: %3lR; user %3lU; system %3lS' && time (for run in {1..1000}; do curl 1211.0.0.1>/dev/null 2>&1; done)"
echo "After 1000 Requests Mem Usage"
echo "=========================================="
docker stats fastapi-py311-gunicorn fastapi-py311-gunicorn-max-requests --no-stream --format "{{.Name}}: {{.MemUsage}}"
echo "=========================================="
echo "Cleanup...."
docker stop fastapi-py311-gunicorn fastapi-py311-gunicorn-max-requests >/dev/null 2>&1
docker rm fastapi-py311-gunicorn fastapi-py311-gunicorn-max-requests >/dev/null 2>&1