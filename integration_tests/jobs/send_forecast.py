import sendgrid
import os


def send_email(
    sent_from='service@dbt-resto.com',
    subject='[Daily Forecast] Power 6x55',
    body='This is a testing or in-completed stuff',
    debug=False
  ):
    tos = os.environ.get('SENDGRID_MAILING_LIST','').split(';')
    sg = sendgrid.SendGridAPIClient(api_key=os.environ.get('SENDGRID_API_KEY',''))
    data = {
      'personalizations': [
        {
          'to': tos,
          'subject': subject
        }
      ],
      'from': {
        'email': sent_from
      },
      'content': [
        {
          'type': 'text/html',
          'value': f'<p>{body}</p>'
        }
      ]
    }

    response = sg.client.mail.send.post(request_body=data)
    print(f'Sent with response code: {response.status_code}')
    print(f'Sent with response body: {response.body}')
    print(f'Sent with response header: {response.headers}')


def get_data():
  return 'This is a testing or in-completed stuff'


body = get_data()
send_email(subject='[power6x55_crawler] SUCCESS to load', body=body)