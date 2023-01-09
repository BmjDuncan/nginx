FROM ubuntu:20.04
# From https://www.leaseweb.com/labs/2013/11/streaming-video-demand-nginx-rtmp-module/
RUN apt-get -y -q update 
RUN apt-get install -y git
RUN apt-get install -y gcc
RUN apt-get install -y make
RUN apt-get install -y libpcre3-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y wget
RUN apt-get install -y ffmpeg
RUN mkdir -p /home/nginx-rtmp-module
RUN git clone https://github.com/arut/nginx-rtmp-module /home/nginx-rtmp-module
RUN mkdir -p /home/nginx
RUN cd /home/nginx && wget http://nginx.org/download/nginx-1.4.3.tar.gz && tar zxpvf nginx-1.4.3.tar.gz
RUN cd /home/nginx/nginx-1.4.3 && ./configure --add-module=/home/nginx-rtmp-module/ --with-http_ssl_module --prefix=/usr/local/nginx-streaming/
RUN cd /home/nginx/nginx-1.4.3&& make && make install
RUN mkdir -p /var/www/html
RUN mkdir -p /var/nginx-streaming
RUN mkdir -p /var/log/nginx
RUN cp /home/nginx-rtmp-module/stat.xsl /var/nginx-streaming/
ADD nginx/nginx.conf /usr/local/nginx-streaming/conf/nginx.conf
RUN ffmpeg -re -I ants.mp4 -vcodec copy -loop -1 -c:a aac -b:a 160k -ar 44100 -strict -2 -f flv rtmp: 34.79.49.178/live/ants
EXPOSE 80
EXPOSE 1935
