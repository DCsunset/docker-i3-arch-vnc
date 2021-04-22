ARG VERSION

FROM archlinux:${VERSION:-latest}
LABEL MAINTAINER="DCsunset"

# copy directory contents to /scripts
COPY ./scripts /scripts

WORKDIR /root

EXPOSE 5900 6080

CMD [ "/scripts/start.sh" ]
