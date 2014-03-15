docker rm $(docker ps -a -q)
docker images | grep none | cut -f 29 -d" " | xargs docker rmi