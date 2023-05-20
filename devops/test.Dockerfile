ARG PYTHON_VERSION="3.10"
ARG DBT_VERSION="1.3.0"
FROM python:${PYTHON_VERSION}-bullseye

LABEL org.opencontainers.image.description "Image dedicated base setup for dbt Testing"

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
RUN pip install "dbt-sqlserver~=${DBT_VERSION}.0"