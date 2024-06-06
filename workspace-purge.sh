venv=$1

docker kill workspace-$venv && docker rm workspace-$venv
docker rmi workspace-$venv
