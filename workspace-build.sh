venv=$1

docker build -t workspace-$venv -f ~/Desktop/PROJECTS/workspace/Dockerfile.$venv .
