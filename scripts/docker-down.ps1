$CremaSiteId = docker ps -q --filter name=cremasite

if(!$CremaSiteId) {
    docker stop cremasite
}