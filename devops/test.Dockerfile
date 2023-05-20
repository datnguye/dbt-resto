ARG PYTHON_VERSION="3.10"
FROM python:${PYTHON_VERSION}-bullseye

LABEL org.opencontainers.image.description "Image dedicated base setup for Testing"

# Setup dependencies for pyodbc
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      apt-transport-https \
      curl  \
      gnupg2 \
      unixodbc-dev \
      lsb-release && \
    apt-get autoremove -yqq --purge && \
    apt-get clean &&  \
    rm -rf /var/lib/apt/lists/*

# enable Microsoft package repo
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl -sL https://packages.microsoft.com/config/debian/$(lsb_release -sr)/prod.list | tee /etc/apt/sources.list.d/msprod.list

# install ODBC driver 18
ENV ACCEPT_EULA=Y
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      msodbcsql18 \
      mssql-tools18 && \
    apt-get autoremove -yqq --purge && \
    apt-get clean &&  \
    rm -rf /var/lib/apt/lists/*

# install poetry
RUN pip install poetry

# install dbt
COPY pyproject.toml .
RUN poetry install

# setup dbt profile
RUN mkdir ~/.dbt
COPY profiles/profiles.yml ~/.dbt/profiles.yml

ENV SQLSERVER_HOST ${SQLSERVER_HOST}
ENV SQLSERVER_PORT ${SQLSERVER_PORT}
ENV SQLSERVER_DATABASE ${SQLSERVER_DATABASE}
ENV SQLSERVER_SCHEMA ${SQLSERVER_SCHEMA}
ENV SQLSERVER_USER ${SQLSERVER_USER}
ENV SQLSERVER_PASSWORD ${SQLSERVER_PASSWORD}

HEALTHCHECK CMD dbt debug