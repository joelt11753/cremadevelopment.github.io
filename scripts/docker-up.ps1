
$CremaSiteId = docker ps -q --filter name=cremasite

if(!$CremaSiteId) {
    docker stop cremasite
}

docker run --rm --volume=${PWD}:/srv/jekyll -it jekyll/jekyll jekyll build

docker run --name cremasite --rm -d -v ${PWD}\_site:/usr/share/nginx/html -p 8080:80 nginx
