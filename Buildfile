docker image build -t nginx .
docker run -d -p 1935:1935 -p 80:80 --name nginx -v $PWD/mp4:/var/mp4s -v $PWD/www:/var/www nginx /usr/local/nginx-streaming/sbin/nginx
