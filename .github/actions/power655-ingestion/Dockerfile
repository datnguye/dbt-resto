FROM alpine/git:latest

LABEL "maintainer"="Dat Nguyen <datnguyen.it09@gmail.com>"
LABEL "com.github.actions.name"="Vietlot Power 6/55 Ingestion"
LABEL "com.github.actions.description"="Vietlot Power 6/55 Ingestion"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="blue"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]