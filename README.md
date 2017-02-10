# Apache HTTP Server for PMIS

To enable SSL you can use the environment variable ``APACHE_SSL=1``,
just edit the file ``.env`` and change the option accordingly.

Create a folder ``ssl`` here and put the following certificate inside:

    - cert.pem
    - key.pem
    - chain.pem


## Build and Run the Service

> Before running **port 80 and 443 need to be available on the host**

    $ docker-compose up --build -d

## Check and Follow the Log

    $ docker-compose logs -f

## Stop the Service

    $ docker-compose down

## Run Syntax Check for Apache Configuration

    $ docker-compose run httpd apache2ctl -t