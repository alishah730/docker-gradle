# docker-gradle
- docker
- gradle
- jdk8
- ubuntu
- PUSH CUSTOM IMAGE TO YOUR DOCKER REPOSITORY
Log in to your virtual repository, build, tag and push your custom image with the following commands:

docker login alixray.jfrog.io
docker build --tag alixray.jfrog.io/docker/node-ali:latest .
docker push alixray.jfrog.io/docker/node-ali:latest

