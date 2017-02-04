To enable SSL you can use the environment variable ``APACHE_SSL=1``,
just edit the file ``.env`` and change the option accordingly.

Create a folder ``ssl`` here and put the following certificate inside:

    - cert.pem
    - key.pem
    - chain.pem


# build and run the service

> Before running **port 80 and 443 need to be available on the host**

    $ docker-compose up --build -d

# check and follow the log

    $ docker-compose logs -f

# stop the service

    $ docker-compose down