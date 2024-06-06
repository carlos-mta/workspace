venv=$1

docker run -d --name workspace-$venv \
  -p 3000:3000 \
  -p 8080:8080 \
  -p 5555:5555	\
  -p 24678:24678 \
  --add-host=host.docker.internal:host-gateway \
  -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \
  -v ~/Desktop/PROJECTS:/workspace/PROJECTS \
  -v ~/.config/nvim:/root/.config/nvim \
  -v ~/.ssh:/root/.ssh \
  -v ~/.local/share/nvim:/root/.local/share/nvim \
  workspace-$venv
 
 xhost +
 docker exec -it workspace-$venv chmod 600 /root/.ssh/id_rsa
