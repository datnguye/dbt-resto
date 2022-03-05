# Test suite of dbt_resto package
Once adding new macro(s), please also create a test here

### Prequesites
- Python 3.9.6
- virtualenv `python -m pip install virtualenv --upgrade`

### Setup local enviroment
- Move to repo directory:
```
cd /path/to/dbt-resto/integration_tests
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