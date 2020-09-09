#!/bin/bash
docker build --rm -t gradle-jdk8-ubuntu .
TAG=1.0.0
#cat ~/GH_TOKEN.txt | docker login docker.pkg.github.com -u alishah730 --password-stdin
# Step 2: Tag
docker tag gradle-jdk8-ubuntu docker.pkg.github.com/alishah730/docker/gradle-jdk8-ubuntu:$TAG
# Step 3: Publish
docker push docker.pkg.github.com/alishah730/docker/gradle-jdk8-ubuntu:$TAG