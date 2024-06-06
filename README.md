<p align="center">
    <img width="150px" height="150px" src="./logo.svg"/>
</p>

<h1 align="center">WORKSPACE</h1>
<h3 align="center"><i>A set of Dockerized development environments that I use in my daily work</h3></i></h3>
<br/>

## About

Currently, most of my work involves NodeJs and Go, which is why the two images in this repository are dedicated to these environments/languages.

To facilitate the management of images and containers, I use 4 scripts. 

All of them accept the name of the environment as the first argument:

- `workspace-build`: Builds the environment image
- `workspace-init`: Starts a container from the built image
- `workspace-purge`: Kills the container and then removes it
- `workspace-in`: Shortcut to enter inside a container

## How to use these files?

- Install Docker
- Clone this repo
- Update the `~/.bashrc` file, add the following lines:

```bash
alias workspace-build="bash ~/path/to/workspace-build.sh"
alias workspace-init="bash ~/path/to/workspace-init.sh"
alias workspace-purge="bash ~/path/to/workspace-purge.sh"
alias workspace-in="bash ~/path/to/workspace-in.sh"
```
- Build the desired image, start the container and get into it running `workspace-build [image] && workspace-init [image] && workspace-in [image]`
