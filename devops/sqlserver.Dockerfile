ARG MSSQL_VERSION="2022"
FROM mcr.microsoft.com/mssql/server:${MSSQL_VERSION}-latest

LABEL org.opencontainers.image.description "Customized SQL Server image used in dbt-resto"

RUN mkdir -p /opt/init_scripts
WORKDIR /opt/init_scripts
COPY sqlserver-scripts/* /opt/init_scripts/

ENTRYPOINT /bin/bash ./entrypoint.sh