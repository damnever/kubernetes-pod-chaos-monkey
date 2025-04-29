FROM alpine

RUN apk add --no-cache tzdata ca-certificates curl
ENV TZ=Asia/Shanghai

RUN cd /usr/local/bin && \
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
        chmod +x kubectl

WORKDIR /usr/src/app
COPY chaos.sh ./
CMD ["/bin/sh", "/usr/src/app/chaos.sh"]
