ARG PYTHON_VERSION="3.10"
FROM python:${PYTHON_VERSION}-bullseye as base

LABEL org.opencontainers.image.description "Image dedicated base setup for Forecasting Power 6/55 job"

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

# install MongoDB tools
RUN wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2004-x86_64-100.7.0.deb
RUN apt install ./mongodb-database-tools-*-100.7.0.deb

# install poetry
RUN pip install poetry

# add sqlcmd to the path
ENV PATH="$PATH:/opt/mssql-tools18/bin"