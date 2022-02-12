# dbt-resto
This is dbt package for everyone
- Default warehouse: Snowflake
- Supported warehouses:
    - Snowflake
    - SQL Server 

## Developer's Guide
### Prequesites
- Python 3.9 [here](https://www.python.org/downloads/release/python-390/)
- virtualenv `python -m pip install virtualenv --upgrade`

### Setup local enviroment
- Move to repo directory:
```
cd /path/to/dbt-resto
```

- Windows:
```
python -m venv env
.\env\Scripts\activate
pip install --upgrade pip
pip install -r requirements.txt
```

- Linux (Recommend to install WSL if you're in Windows):
```
python -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
```

- Check dbt version `dbt --version`. Expected to see:
```
installed version: 1.0.1
   latest version: 1.0.1

Up to date!

Plugins:
  - snowflake: 1.0.0
```