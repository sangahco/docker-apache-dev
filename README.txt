# build the image
docker build -t pmis-apache:latest .

# run as anonymous container
docker run --rm -d -p 80:80 -p 443:443 pmis-apache

# run as named container
docker run --rm -d -p 80:80 -p 443:443 --name apache pmis-apache

# attach a console to the container
docker exec -it apache /bin/bash