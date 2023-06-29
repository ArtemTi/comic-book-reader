FROM python:3.7

ADD . /comic-book-reader

WORKDIR /comic-book-reader

RUN apt-get update \
  && apt-get install -y python3-enchant \
  && apt-get install -y tesseract-ocr \
  && apt-get install tesseract-ocr-hrv \
  && apt-get install -y libtesseract-dev \
  && pip install --upgrade pip \
  && pip install flask_cors \
  && pip install --upgrade pip setuptools wheel \
  && pip install -r requirements.txt

EXPOSE 8080

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--timeout", "60", "--workers=1", "--threads=4", "--worker-class=gthread", "app"]
