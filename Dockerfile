FROM python:3.9.0

WORKDIR /home/

RUN git clone https://github.com/jaemin8975/pragmatic1.git

WORKDIR /home/pragmatic1

RUN pip install -r requirements.txt

RUN echo "SECRET_KEY=django-insecure-$mpnv(f3_tu=!f84*#8_6!kbkrn!f-_#+@87%ew%peeu!695fr" > .env

RUN python manage.py migrate

RUN python manage.py collectstatic

EXPOSE 80

CMD ["python", "manage.py", "runserver", "0.0.0.0:80"]