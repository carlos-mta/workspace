venv=$1

docker build -t workspace-$venv -f ~/Escritorio/PROJECTS/DEV/workspace/Dockerfile.$venv \
~/Escritorio/PROJECTS/DEV/workspace
