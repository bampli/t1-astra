FROM python:3.8-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY requirements.txt /usr/src/app/
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . /usr/src/app

ENV FLASK_ENV=development
ENV FLASK_APP=app.py
EXPOSE 9999

ENTRYPOINT ["python3"]
CMD ["-m", "app"]
