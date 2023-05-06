ARG MSSQL_VERSION="2022"
FROM mcr.microsoft.com/mssql/server:${MSSQL_VERSION}-latest

RUN mkdir -p /opt/init_scripts
WORKDIR /opt/init_scripts
COPY scripts/* /opt/init_scripts/

ENTRYPOINT /bin/bash ./entrypoint.sh