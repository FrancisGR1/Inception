*This project has been created as part of the 42 curriculum by frmiguel.*

# Description
Objective: setup a static file website (Wordpress) with a database (MariaDB) and one single entrypoint, that is, Nginx as a reverse proxy.
Each service is containerized in such a way that it creates a small distributed system.
## What is docker?
Overall it's a technology that decouples software from it's dependencies, namely the ones having to do with the operating system and the host platform.
### VM vs Docker
However, unlike a VM, Docker interacts directly with the host operating system, which means that virtualization is achieved in a less resource-intensive way. For instance, running three VMs requires three separate operating systems. With Docker, three containers can run on the same host OS kernel, dramatically reducing memory usage and startup time.
### Secret
Secrets are variables managed by docker privately, that is, they don't show up on the logs and are only acessible by the designated container(s).
### Network
Another aspect of docker is its network. Multiple containers can communicate with each other with minimal configuration. This makes microservice architectures and decentralized systems very convenient. Unlike traditional hosting environments, the granular details of setting up ports, permissions, and networking are abstracted away.
### Data Persistence
Docker also supports data persistence in two ways:
Named volumes – data managed directly by Docker.
1) Bind mounts – data shared between Docker and the host machine.
2) You can use one or both depending on your needs.

# Instructions
To build and run the projects type: "make"

# Resources
Install: https://docs.docker.com/engine/install/

Intro: //www.youtube.com/watch?v=RqTEHSBrYFw 

Docs: https://docs.docker.com/get-started/introduction/?utm_source=chatgpt.com

AI: used for nginx configuration and some debugging in the docker compose yaml.
