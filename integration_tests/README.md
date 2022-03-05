# Test suite of dbt_resto package
Once adding new macro(s), please also create a test here

### Prequesites
- Python 3.9.6
- virtualenv `python -m pip install virtualenv --upgrade`


### Setup local enviroment - with `poetry`
- Move to repo directory:
  ```
  cd /path/to/dbt-resto/integration_tests
  ```

- Install poetry
  ```
  python -m pip install poetry
  ```

- Install dependencies and start shell
  ```
  python -m poetry install
  python -m poetry shell
  # To exit shell, enter: exit
  ```

- Check dbt version `dbt --version`. Expected to see:
  ```
  installed version: 1.0.3
    latest version: 1.0.3

  Up to date!

  Plugins:
    - snowflake: 1.0.0 - Up to date!
    - sqlserver: 1.0.0 - Up to date!
  ```

- See your target profile in [profiles.yml](./.dbt/profiles.yml), and set the enviroment variables appropriately

- Check if you're ready now:
  ```
  dbt debug --profiles-dir .dbt
  ```

### Setup local enviroment - with `virtualenv`
- Move to repo directory:
  ```
  cd /path/to/dbt-resto/integration_tests
  ```

- Install venv
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
  installed version: 1.0.3
    latest version: 1.0.3

  Up to date!

  Plugins:
    - snowflake: 1.0.0 - Up to date!
    - sqlserver: 1.0.0 - Up to date!
  ```

- See your target profile in [profiles.yml](./.dbt/profiles.yml), and set the enviroment variables appropriately

- Check if you're ready now:
  ```
  dbt debug --profiles-dir .dbt
  ```