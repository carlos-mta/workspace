docker run -d --name workspace \
  -p 3000:3000 \
  -p 8080:8080 \
  -p 24678:24678 \
  --add-host=host.docker.internal:host-gateway \
  -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \
  -v ~/Desktop/PROJECTS:/workspace/PROJECTS \
  -v ~/.config/nvim:/root/.config/nvim \
  -v ~/.ssh:/root/.ssh \
  -v ~/.local/share/nvim:/root/.local/share/nvim \
  workspace
 
 xhost +
 docker exec -it workspace chmod 600 /root/.ssh/id_rsa
