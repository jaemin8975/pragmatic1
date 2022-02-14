FROM python:3.9.0

RUN mkdir /root/.ssh/

ADD ./.ssh/id_rsa /root/.ssh/id_rsa

RUN chmod 600 /root/.ssh/id_rsa

RUN touch /root/.ssh/known_hosts

RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

WORKDIR /home/

RUN echo "t2"

#RUN git clone https://github.com/jaemin8975/pragmatic1.git
RUN git clone git@github.com:jaemin8975/pragmatic1.git

WORKDIR /home/pragmatic1

RUN pip install -r requirements.txt

RUN pip install gunicorn

RUN pip install mysqlclient

EXPOSE 80

CMD ["bash", "-c", "python manage.py collectstatic --noinput --settings=pragmatic1.settings.deploy && python manage.py migrate --settings=pragmatic1.settings.deploy && gunicorn pragmatic1.wsgi --env DJANGO_SETTINGS_MODULE=pragmatic1.settings.deploy --bind 0.0.0.0:8080"]

FROM python:3.9-alpine

WORKDIR usr/src/flask_app