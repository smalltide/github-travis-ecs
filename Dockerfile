FROM python:alpine3.6

ENV APP_PATH /usr/src/app

RUN mkdir -p $APP_PATH

COPY app $APP_PATH
COPY entrypoint.sh /

WORKDIR $APP_PATH

#RUN pip install -r requirements.txt

ENTRYPOINT ["/entrypoint.sh"]

CMD ["python", "app.py"]