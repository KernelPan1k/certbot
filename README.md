# certbot
Dockerized [certbot][certbot]

```
docker volume create --name nginx-certs

docker run \
  -v nginx-certs:/etc/letsencrypt \
  -e http_proxy=$http_proxy \
  -e domains="example.com,example.org" \
  -e email="me@example.com" \
  --rm pierreprinetti/certbot:latest
```

## With dockerized nginx

Spin your favorite reverse proxy with something like:

```
docker run \
  --name some-nginx \
  -v nginx-certs:/etc/nginx/certs:ro \
  -p 80:80 \
  -p 443:443 \
  --restart unless-stopped \
  -d nginx:mainline-alpine
```

Example configuration for `example.com` in your dockerized nginX:

```
server {
  listen      443 http2;
  listen      [::]:443 http2;
  server_name example.com;

  ssl on;
  ssl_certificate     /etc/nginx/certs/live/example.com/fullchain.pem;
  ssl_certificate_key /etc/nginx/certs/live/example.com/privkey.pem;

  [...]
```

[certbot]: https://certbot.eff.org/ "letsencrypt client website"
