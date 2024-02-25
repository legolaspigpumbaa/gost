FROM ubuntu:latest

# port 80 and 443
EXPOSE 80 443

# install 
RUN apt update && apt install wget nano -y

# download gost
RUN wget https://github.com/ginuerzh/gost/releases/download/v2.11.5/gost-linux-amd64-2.11.5.gz && \
    gunzip gost-linux-amd64-2.11.5.gz

# move gost to /usr/local/bin
RUN mv gost-linux-amd64-2.11.5 /usr/local/bin/gost && \
    chmod +x /usr/local/bin/gost

    #copy ghost service
COPY gost.service /etc/systemd/system/gost.service

# start gost
RUN systemctl start gost
