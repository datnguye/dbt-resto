import os
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail
import pyodbc


def send_email(
    sent_from="service@dbt-resto.com",
    subject="[Daily Forecast] Power 6x55",
    body="This is a testing or in-completed stuff",
):
    tos = os.environ.get("SENDGRID_MAILING_LIST", "")
    message = Mail(
        from_email=sent_from,
        to_emails=tos,
        subject=subject,
        html_content=f"<strong>{body}</strong>",
    )
    try:
        sg = SendGridAPIClient(os.environ.get("SENDGRID_API_KEY"))
        response = sg.send(message)
        print(response.status_code)
        print(response.body)
        print(response.headers)
    except Exception as e:
        print(e.message)


def get_data():
    cnxn = pyodbc.connect(
        "Driver={ODBC Driver 18 for SQL Server};"
        f"Server={os.environ.get('SQLSERVER_HOST')},{os.environ.get('SQLSERVER_PORT',1433)};"
        f"Database={os.environ.get('SQLSERVER_DATABASE')};"
        f"UID={os.environ.get('SQLSERVER_USER')};"
        f"PWD={os.environ.get('SQLSERVER_PASSWORD')};"
        "encrypt=Yes;"
        "TrustServerCertificate=Yes;"
    )
    cursor = cnxn.cursor()
    try:
        cursor.execute(
            "select     top 1 forecast_numbers "
            "from       mart.fact_number_forecast "
            "order by   forecast_date desc"
        )
        for row in cursor:
            return row["forecast_numbers"]
    except Exception as e:
        print(e)

    return "ERROR"


body = get_data()
send_email(body=body)
