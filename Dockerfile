ARG VERSION

FROM archlinux:${VERSION:-latest}
LABEL MAINTAINER="DCsunset"

COPY ./scripts /

WORKDIR /root

EXPOSE 5900 6080

CMD [ "/scripts/start.sh" ]
